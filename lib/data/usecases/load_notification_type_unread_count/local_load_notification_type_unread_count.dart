import './../../../domain/domain.dart';
import './../../repositories/repositories.dart';

class LocalLoadNotificationTypeUnreadCount
    implements LoadNotificationTypeUnreadCount {
  NotificationTypeRepository repository;

  LocalLoadNotificationTypeUnreadCount({required this.repository});

  @override
  void load({
    required int notificationTypeId,
  }) {
    repository.updateUnreadNotificationsCount(
      notificationTypeId: notificationTypeId,
    );
  }
}
