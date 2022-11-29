import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

import '../../domain/entities/received_notifications_entity.dart';
import '../../infra/drivers/local_notifications_driver.dart';

class LocalNotificationsDriver extends ILocalNotificationsDriver
    with Disposable {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<ReceivedNotificationEntity>
      onDidReceiveLocalNotification;
  final BehaviorSubject<NotificationResponse> selectNotificationSubject;

  LocalNotificationsDriver({
    required this.onDidReceiveLocalNotification,
    required this.selectNotificationSubject,
  });

  @override
  Future<Either<Exception, Unit>> init() async {
    try {
      const settingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      final settingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {
          onDidReceiveLocalNotification.add(
            ReceivedNotificationEntity(
              id: id,
              title: title,
              body: body,
              payload: payload,
            ),
          );
        },
      );

      final settings = InitializationSettings(
        android: settingsAndroid,
        iOS: settingsIOS,
      );
      await _localNotificationsPlugin.initialize(
        settings,
        onDidReceiveNotificationResponse: (NotificationResponse payload) async {
          debugPrint('notification payload: $payload');
          selectNotificationSubject.add(payload);
        },
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> requestPermissions() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> scheduleNotification() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, Unit>> showNotification({
    required ReceivedNotificationEntity notification,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );
      const iOSDetails = DarwinNotificationDetails();
      const platformChannelSpecifics = NotificationDetails(
        android: androidDetails,
        iOS: iOSDetails,
      );
      await _localNotificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: notification.payload,
      );
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  void dispose() {
    onDidReceiveLocalNotification.close();
    selectNotificationSubject.close();
  }
}
