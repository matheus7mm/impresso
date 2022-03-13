import 'dart:developer';

import './../../domain/domain.dart';

import './factories/factories.dart';

class NotificationTypeRepository {
  static List<NotificationTypeEntity> notificationTypeList =
      NotificationTypeFactory.makeFakeData;

  List<NotificationTypeEntity> fetchAll() => notificationTypeList;

  void updateHasBeenRead({
    required int notificationTypeId,
    required int notificationId,
    required bool hasBeenRead,
  }) {
    try {
      NotificationTypeEntity notificationType = notificationTypeList
          .where((element) => element.id == notificationTypeId)
          .first;

      NotificationEntity notification = notificationType.notifications
          .where((element) => element.id == notificationId)
          .first;

      final indexNotificationType =
          notificationTypeList.indexOf(notificationType);
      final indexNotification = notificationTypeList[indexNotificationType]
          .notifications
          .indexOf(notification);

      notificationTypeList[indexNotificationType]
              .notifications[indexNotification] =
          notification.copyWith(hasBeenRead: hasBeenRead);
    } catch (error) {
      log(error.toString());
    }
  }

  void updateUnreadNotificationsCount({
    required int notificationTypeId,
  }) {
    try {
      NotificationTypeEntity notificationType = notificationTypeList
          .where((element) => element.id == notificationTypeId)
          .first;

      int count = 0;

      for (final element in notificationType.notifications) {
        if (element.hasBeenRead == false) {
          count++;
        }
      }

      final index = notificationTypeList.indexOf(notificationType);

      notificationTypeList[index] = notificationType.copyWith(
        unreadNotificationsCount: count,
      );
    } catch (error) {
      log(error.toString());
    }
  }

  void setNotificationTypeOnTop({
    required int notificationTypeId,
  }) {
    try {
      NotificationTypeEntity notificationType = notificationTypeList.firstWhere(
          (notificationType) => notificationType.id == notificationTypeId);

      final index = notificationTypeList.indexOf(notificationType);

      notificationTypeList.removeAt(index);
      notificationTypeList.insert(0, notificationType);
    } catch (error) {
      log(error.toString());
    }
  }
}
