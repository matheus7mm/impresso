import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class NotificationEntity extends Equatable {
  final int id; // Unique
  final String? pictureUrl;
  final String message;
  final DateTime time;
  final bool hasBeenRead;

  const NotificationEntity({
    this.pictureUrl,
    required this.id,
    required this.message,
    required this.time,
    required this.hasBeenRead,
  });

  String getStringTime() {
    final DateTime today = DateTime.now();

    DateFormat dateFormat;

    if (time.difference(today).inDays == 0) {
      dateFormat = DateFormat('HH:mm');
    } else {
      dateFormat = DateFormat('dd/MM/yy');
    }

    final String stringTime = dateFormat.format(time);

    return stringTime;
  }

  NotificationEntity copyWith({
    int? id,
    String? pictureUrl,
    String? message,
    DateTime? time,
    bool? hasBeenRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      message: message ?? this.message,
      time: time ?? this.time,
      hasBeenRead: hasBeenRead ?? this.hasBeenRead,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  @override
  List<Object?> get props => [
        pictureUrl,
        id,
        message,
        time,
        hasBeenRead,
      ];
}
