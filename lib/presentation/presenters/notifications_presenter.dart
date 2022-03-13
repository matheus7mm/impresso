import 'dart:async';

import './../../domain/domain.dart';

class NotificationsState {
  NotificationsState({required this.notificationTypeList});

  int selectedNotificationTypeId = 1;
  List<NotificationTypeEntity> notificationTypeList;
}

class NotificationsPresenter {
  final FetchNotificationType fetchNotificationType;
  final SetNotificationAsRead setNotificationAsRead;
  final LoadNotificationTypeUnreadCount loadNotificationTypeUnreadCount;

  static late NotificationsState state;

  NotificationsPresenter({
    required this.fetchNotificationType,
    required this.setNotificationAsRead,
    required this.loadNotificationTypeUnreadCount,
  }) {
    state = NotificationsState(
        notificationTypeList: fetchNotificationType.fetchAll());
  }

  final _controller = StreamController<NotificationsState>.broadcast();

  int get selectedNotificationTypeId => state.selectedNotificationTypeId;

  void addSelectedNotificationTypeId(int id) {
    state.selectedNotificationTypeId = id;

    // put the NotificationType selected as first element in the list
    NotificationTypeEntity notificationType = getNotificationTypeList
        .firstWhere((notificationType) => notificationType.id == id);

    final index = getNotificationTypeList.indexOf(notificationType);

    getNotificationTypeList.removeAt(index);
    getNotificationTypeList.insert(0, notificationType);

    _update();
  }

  void _update() => _controller.add(state);

  Stream<int> get selectedNotificationTypeIdStream => _controller.stream
      .map(
        (state) => state.selectedNotificationTypeId,
      )
      .distinct();

  Stream<NotificationTypeEntity> notificationTypeStream({
    required int notificationTypeId,
  }) =>
      _controller.stream
          .map(
            (state) => state.notificationTypeList.firstWhere(
                (notificationType) =>
                    notificationType.id == notificationTypeId),
          )
          .distinct();

  Stream<int> unreadNotificationsCountStream({
    required int notificationTypeId,
  }) =>
      _controller.stream
          .map(
            (state) => state.notificationTypeList
                .firstWhere((notificationType) =>
                    notificationType.id == notificationTypeId)
                .unreadNotificationsCount,
          )
          .distinct();

  List<NotificationTypeEntity> get getNotificationTypeList =>
      fetchNotificationType.fetchAll();

  void addNotificationAsRead({
    required int notificationTypeId,
    required int notificationId,
  }) {
    setNotificationAsRead.set(
      notificationTypeId: notificationTypeId,
      notificationId: notificationId,
    );

    loadNotificationTypeUnreadCount.load(
      notificationTypeId: notificationTypeId,
    );

    state.notificationTypeList = getNotificationTypeList;

    _update();
  }

  void updateNotificationTypeListUnreadCount() {
    for (final notificationType in getNotificationTypeList) {
      loadNotificationTypeUnreadCount.load(
        notificationTypeId: notificationType.id,
      );
    }
  }

  void dispose() {
    _controller.close();
  }
}
