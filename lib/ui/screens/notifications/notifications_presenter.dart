import 'dart:async';

import './../../../domain/domain.dart';

abstract class NotificationsPresenter {
  int get selectedNotificationTypeId;

  void addSelectedNotificationTypeId(int id);

  Stream<int> get selectedNotificationTypeIdStream;

  Stream<int> unreadNotificationsCountStream({
    required int notificationTypeId,
  });

  List<NotificationTypeEntity> get getNotificationTypeList;

  void addNotificationAsRead({
    required int notificationTypeId,
    required int notificationId,
  });

  void updateNotificationTypeListUnreadCount();

  void dispose();
}
