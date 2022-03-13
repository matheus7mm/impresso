import 'dart:developer';

import './../../domain/domain.dart';

class NotificationTypeRepository {
  static List<NotificationTypeEntity> notificationTypeList = [
    NotificationTypeEntity(
      id: 1,
      title: 'Announcements',
      unreadNotificationsCount: 134,
      notifications: [
        NotificationEntity(
          id: 1,
          pictureUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/Elliot_Page_2021.png/200px-Elliot_Page_2021.png',
          message: 'You have a new coffee invitation from Victor McComrick!',
          time: DateTime.now(),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 2,
          pictureUrl:
              'https://cachedimages.podchaser.com/256x256/aHR0cHM6Ly9jcmVhdG9yLWltYWdlcy5wb2RjaGFzZXIuY29tLzc0NTBlZmVjYjZmNjZjYmRhMWZlMjhmOTM0YjFhN2UwLnBuZw%3D%3D/aHR0cHM6Ly93d3cucG9kY2hhc2VyLmNvbS9pbWFnZXMvbWlzc2luZy1pbWFnZS5wbmc%3D',
          message: 'Zhang Zilin has accepted your coffee invitation!',
          time: DateTime.now(),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 3,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.now(),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 4,
          message: 'You have a new message! Profile Validation status results',
          time: DateTime.parse('2022-02-20 20:18:04Z'),
          hasBeenRead: true,
        ),
        NotificationEntity(
          id: 5,
          pictureUrl:
              'https://media.nu.nl/m/42mx5dra285v_sqr256.jpg/rol-in-the-power-of-the-dog-hielp-benedict-cumberbatch-om-minder-te-pleasen.jpg',
          message: 'Zhang Zilin has returned your coffee invitation',
          time: DateTime.parse('2022-02-12 20:18:04Z'),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 6,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2022-01-10 20:18:04Z'),
          hasBeenRead: true,
        ),
        NotificationEntity(
          id: 7,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2019-12-23 20:18:04Z'),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 8,
          pictureUrl: 'https://64.media.tumblr.com/avatar_4514eb0cd274_128.pnj',
          message: 'Sydney Barrett has returned your coffee invitation',
          time: DateTime.parse('2019-02-20 20:18:04Z'),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 9,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2019-02-20 20:18:04Z'),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 10,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2019-02-20 20:18:04Z'),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 11,
          pictureUrl: 'https://64.media.tumblr.com/avatar_e5c58a2af3d7_128.pnj',
          message: 'Yorkie has returned your coffee invitation',
          time: DateTime.parse('2019-02-19 20:18:04Z'),
          hasBeenRead: true,
        ),
      ],
    ),
    NotificationTypeEntity(
      id: 2,
      title: 'Career-Invites',
      unreadNotificationsCount: 13,
      notifications: [
        NotificationEntity(
          id: 12,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.now(),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 13,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2022-02-20 20:18:04Z'),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 14,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2022-02-15 20:18:04Z'),
          hasBeenRead: false,
        ),
        NotificationEntity(
          id: 15,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2022-01-19 20:18:04Z'),
          hasBeenRead: true,
        ),
        NotificationEntity(
          id: 16,
          message: 'You have a new message! Coffee Invitation Reminder',
          time: DateTime.parse('2022-01-01 20:18:04Z'),
          hasBeenRead: false,
        ),
      ],
    ),
    NotificationTypeEntity(
      id: 3,
      title: 'Verification',
      unreadNotificationsCount: 0,
      notifications: [
        NotificationEntity(
          id: 17,
          message: 'Congratulations! Your account is now verified',
          time: DateTime.parse('2022-02-21 20:18:04Z'),
          hasBeenRead: true,
        ),
      ],
    )
  ];

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
