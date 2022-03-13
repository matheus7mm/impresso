import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../../../theme/theme.dart';
import './../../notifications_presenter.dart';

import './../avatar_widget.dart';

class NotificationItemWidget extends StatefulWidget {
  final String message;
  final String time;
  final bool hasBeenRead;
  final String? url;

  final int notificationTypeId;
  final int notificationId;

  const NotificationItemWidget({
    Key? key,
    required this.message,
    required this.time,
    required this.hasBeenRead,
    required this.notificationTypeId,
    required this.notificationId,
    this.url,
  }) : super(key: key);

  @override
  State<NotificationItemWidget> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItemWidget> {
  bool hasBeenRead = true;

  @override
  void initState() {
    super.initState();
    hasBeenRead = widget.hasBeenRead;
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<NotificationsPresenter>(context);

    final TextStyle style = TextStyle(
      color: hasBeenRead == true
          ? kNotificationTextColorRead
          : kNotificationTextColorUnread,
      fontSize: 11,
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: hasBeenRead == true
            ? Colors.transparent
            : kNotificationUnreadBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      child: ListTile(
        leading: AvatarWidget(url: widget.url),
        title: Text(
          widget.message,
          style: style,
        ),
        trailing: Text(
          widget.time,
          style: style,
        ),
        onTap: () {
          presenter.addNotificationAsRead(
            notificationTypeId: widget.notificationTypeId,
            notificationId: widget.notificationId,
          );

          setState(() {
            hasBeenRead = true;
          });
        },
      ),
    );
  }
}
