import 'dart:convert' show jsonEncode;

import 'package:firebase_messaging/firebase_messaging.dart'
    show RemoteMessage, FirebaseMessaging;
import 'package:flutter/foundation.dart';

import '../../../domain/interfaces/either.dart';
import '../../../infra/drivers/firebase/i_firebase_crashlytics_driver.dart';
import '../../../infra/drivers/firebase/i_firebase_notifications_driver.dart'
    show IFirebaseNotificationsDriver;
import '../../../infra/drivers/i_local_notifications_driver.dart';
import '../../../infra/models/received_notifications_model.dart'
    show ReceivedNotificationModel;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('onMessageOpenedApp: $message');
}

class FirebaseNotificationsDriver extends IFirebaseNotificationsDriver {
  final FirebaseMessaging instance;
  final IFirebaseCrashlyticsDriver crashlyticsDriver;
  final ILocalNotificationsDriver localNotificationsDriver;

  FirebaseNotificationsDriver({
    required this.instance,
    required this.crashlyticsDriver,
    required this.localNotificationsDriver,
  });

  @override
  Future<Either<Exception, String>> getToken() async {
    try {
      final token = await instance.getToken();
      if (token == null) {
        return Left(Exception('Token está vazio'));
      }
      return Right(token);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> configure() async {
    try {
      //Define as opções de apresentação para notificações da Apple
      //  quando recebidas em primeiro plano.
      instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final notification = ReceivedNotificationModel(
          id: message.messageId?.hashCode ?? message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.title ?? '',
          payload: jsonEncode(message.data),
        );

        await localNotificationsDriver
            .showNotification(notification: notification)
            .then((value) {
          value.fold(
            (l) => debugPrint('[ERROR]onMessage: $l'),
            (r) => debugPrint('onMessage: $notification'),
          );
        });
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        final notification = ReceivedNotificationModel(
          id: message.messageId?.hashCode ?? message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.title ?? '',
          payload: jsonEncode(message.data),
        );

        debugPrint('onMessageOpenedApp: $notification');
      });

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> subscribeToTopic({
    required String topic,
  }) async {
    try {
      await instance.subscribeToTopic(topic);
      return Right(unit);
    } catch (exception, strackTrace) {
      await crashlyticsDriver.setError(
        exception: exception,
        stackTrace: strackTrace,
      );
      debugPrint('Error to subscribe to topic: $topic');
      return Left(Exception(exception));
    }
  }

  @override
  Future<Either<Exception, Unit>> unsubscribeFromTopic({
    required String topic,
  }) async {
    try {
      await instance.unsubscribeFromTopic(topic);
      return Right(unit);
    } catch (exception, strackTrace) {
      await crashlyticsDriver.setError(
        exception: exception,
        stackTrace: strackTrace,
      );
      debugPrint('Error to unsubscribe to topic: $topic');
      return Left(Exception(exception));
    }
  }
}
