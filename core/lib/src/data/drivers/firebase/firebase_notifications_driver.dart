import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../domain/services/local_notifications_service.dart';
import '../../../infra/drivers/firebase/firebase_notifications_driver.dart';
import '../../../infra/models/received_notifications_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final notification = ReceivedNotificationModel(
    id: message.messageId?.hashCode ?? message.hashCode,
    title: message.notification?.title ?? '',
    body: message.notification?.title ?? '',
    payload: jsonEncode(message.data),
  );
  log('onBackgroundMessage: $notification');
}

class FirebaseNotificationsDriver extends IFirebaseNotificationsDriver {
  final FirebaseMessaging instance;
  final ILocalNotificationsService localNotificationsService;

  FirebaseNotificationsDriver({
    required this.instance,
    required this.localNotificationsService,
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
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = ReceivedNotificationModel(
          id: message.messageId?.hashCode ?? message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.title ?? '',
          payload: jsonEncode(message.data),
        );

        localNotificationsService
            .showNotification(notification: notification.toEntity())
            .then((value) {
          value.fold(
            (l) => log('[ERROR]onMessage: $l'),
            (r) => log('onMessage: $notification'),
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
        log('onMessageOpenedApp: $notification');
      });
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
      return const Right(unit);
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
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> unsubscribeFromTopic({
    required String topic,
  }) async {
    try {
      await instance.unsubscribeFromTopic(topic);
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
