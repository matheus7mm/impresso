import 'dart:async';

import './../../domain/domain.dart';

class NotificationsState {
  NotificationsState({
    required this.notificationTypeList,
    required this.selectedNotificationTypeId,
  });

  int selectedNotificationTypeId;
  List<NotificationTypeEntity> notificationTypeList;
}

class NotificationsPresenter {
  final FetchNotificationType fetchNotificationType;
  final SetNotificationAsRead setNotificationAsRead;
  final LoadNotificationTypeUnreadCount loadNotificationTypeUnreadCount;
  final SetNotificationTypeOnTop setNotificationTypeOnTop;

  static late NotificationsState state;

  NotificationsPresenter({
    required this.fetchNotificationType,
    required this.setNotificationAsRead,
    required this.loadNotificationTypeUnreadCount,
    required this.setNotificationTypeOnTop,
  }) {
    state = NotificationsState(
      notificationTypeList: fetchNotificationType.fetchAll(),
      selectedNotificationTypeId: fetchNotificationType.fetchAll().first.id,
    );
  }

  final _controller = StreamController<NotificationsState>.broadcast();

  int get selectedNotificationTypeId => state.selectedNotificationTypeId;

  void addSelectedNotificationTypeId(int id) {
    state.selectedNotificationTypeId = id;

    // put the NotificationType selected as first element in the list
    setNotificationTypeOnTop.set(notificationTypeId: id);

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
