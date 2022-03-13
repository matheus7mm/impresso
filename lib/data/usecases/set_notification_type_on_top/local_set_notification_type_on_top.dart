import './../../../domain/domain.dart';
import './../../repositories/repositories.dart';

class LocalSetNotificationTypeOnTop implements SetNotificationTypeOnTop {
  NotificationTypeRepository repository;

  LocalSetNotificationTypeOnTop({required this.repository});

  @override
  void set({
    required notificationTypeId,
  }) {
    repository.setNotificationTypeOnTop(
      notificationTypeId: notificationTypeId,
    );
  }
}
