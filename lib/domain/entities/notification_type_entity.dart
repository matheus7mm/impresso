import 'package:equatable/equatable.dart';

import './notification_entity.dart';

class NotificationTypeEntity extends Equatable {
  final int id; // Unique
  final String title;
  final int unreadNotificationsCount;
  final List<NotificationEntity> notifications;

  const NotificationTypeEntity({
    required this.id,
    required this.title,
    required this.unreadNotificationsCount,
    required this.notifications,
  });

  NotificationTypeEntity copyWith({
    int? id,
    String? title,
    int? unreadNotificationsCount,
    List<NotificationEntity>? notifications,
  }) {
    return NotificationTypeEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        unreadNotificationsCount,
        notifications,
      ];
}
