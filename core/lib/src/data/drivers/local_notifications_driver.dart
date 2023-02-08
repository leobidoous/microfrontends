import 'package:dartz/dartz.dart' show Either, Unit, Right, unit, Left;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        FlutterLocalNotificationsPlugin,
        NotificationResponse,
        AndroidInitializationSettings,
        DarwinInitializationSettings,
        InitializationSettings,
        AndroidNotificationDetails,
        NotificationDetails,
        Importance,
        Priority,
        DarwinNotificationDetails;
import 'package:flutter_modular/flutter_modular.dart' show Disposable;
import 'package:rxdart/subjects.dart' show BehaviorSubject;

import '../../domain/entities/received_notifications_entity.dart'
    show ReceivedNotificationEntity;
import '../../infra/drivers/local_notifications_driver.dart'
    show ILocalNotificationsDriver;

class LocalNotificationsDriver extends ILocalNotificationsDriver
    with Disposable {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<ReceivedNotificationEntity> onReceiveNotification;
  final BehaviorSubject<NotificationResponse> selectNotificationSubject;

  LocalNotificationsDriver({
    required this.onReceiveNotification,
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
          onReceiveNotification.add(
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
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
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
    onReceiveNotification.close();
    selectNotificationSubject.close();
  }
}
