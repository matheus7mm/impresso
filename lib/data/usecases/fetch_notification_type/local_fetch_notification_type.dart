import './../../../domain/domain.dart';
import './../../repositories/repositories.dart';

class LocalFetchNotificationType implements FetchNotificationType {
  NotificationTypeRepository repository;

  LocalFetchNotificationType({required this.repository});

  @override
  List<NotificationTypeEntity> fetchAll() {
    return repository.fetchAll();
  }
}
