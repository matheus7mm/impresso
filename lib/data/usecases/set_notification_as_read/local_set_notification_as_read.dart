import './../../../domain/domain.dart';
import './../../repositories/repositories.dart';

class LocalSetNotificationAsRead implements SetNotificationAsRead {
  NotificationTypeRepository repository;

  LocalSetNotificationAsRead({required this.repository});

  @override
  void set({
    required int notificationTypeId,
    required int notificationId,
  }) {
    repository.updateHasBeenRead(
      hasBeenRead: true,
      notificationTypeId: notificationTypeId,
      notificationId: notificationId,
    );
  }
}
