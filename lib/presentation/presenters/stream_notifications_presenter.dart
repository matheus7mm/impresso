import 'dart:async';

import './../../domain/domain.dart';
import './../../ui/screens/notifications/notifications.dart';

class NotificationsState {
  NotificationsState({
    required this.notificationTypeList,
    required this.selectedNotificationTypeId,
  });

  int selectedNotificationTypeId;
  List<NotificationTypeEntity> notificationTypeList;
}

class StreamNotificationsPresenter implements NotificationsPresenter {
  final FetchNotificationType fetchNotificationType;
  final SetNotificationAsRead setNotificationAsRead;
  final LoadNotificationTypeUnreadCount loadNotificationTypeUnreadCount;
  final SetNotificationTypeOnTop setNotificationTypeOnTop;

  static late NotificationsState state;

  StreamNotificationsPresenter({
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

  @override
  int get selectedNotificationTypeId => state.selectedNotificationTypeId;

  @override
  void addSelectedNotificationTypeId(int id) {
    state.selectedNotificationTypeId = id;

    // put the NotificationType selected as first element in the list
    setNotificationTypeOnTop.set(notificationTypeId: id);

    _update();
  }

  void _update() => _controller.add(state);

  @override
  Stream<int> get selectedNotificationTypeIdStream => _controller.stream
      .map(
        (state) => state.selectedNotificationTypeId,
      )
      .distinct();

  @override
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

  @override
  List<NotificationTypeEntity> get getNotificationTypeList =>
      fetchNotificationType.fetchAll();

  @override
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

  @override
  void updateNotificationTypeListUnreadCount() {
    for (final notificationType in getNotificationTypeList) {
      loadNotificationTypeUnreadCount.load(
        notificationTypeId: notificationType.id,
      );
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
