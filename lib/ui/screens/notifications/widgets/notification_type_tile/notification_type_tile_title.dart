import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './.././../../../../domain/domain.dart';
import './../../../../theme/theme.dart';
import './../../notifications_presenter.dart';

class NotificationTypeTileTitle extends StatelessWidget {
  final NotificationTypeEntity notificationType;
  final Color? textColor;

  const NotificationTypeTileTitle({
    Key? key,
    required this.notificationType,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<NotificationsPresenter>(context);

    return StreamBuilder<int>(
      stream: presenter.unreadNotificationsCountStream(
        notificationTypeId: notificationType.id,
      ),
      builder: (context, snapshot) {
        String title = notificationType.title.toUpperCase();
        int unreadNotificationsCount = 0;

        if (snapshot.hasData) {
          unreadNotificationsCount = snapshot.data!;
        } else {
          unreadNotificationsCount = notificationType.unreadNotificationsCount;
        }

        if (unreadNotificationsCount > 0) {
          title = title + ' ($unreadNotificationsCount)';
        }

        return Center(
          key: GlobalKey(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              if (unreadNotificationsCount > 0)
                const SizedBox(
                  width: 10,
                ),
              if (unreadNotificationsCount > 0)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kHasNotificationCircleColor,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
