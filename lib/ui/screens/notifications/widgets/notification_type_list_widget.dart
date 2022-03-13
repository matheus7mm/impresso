import 'package:flutter/material.dart';

import './../../../../domain/domain.dart';

import './../notifications_presenter.dart';
import './notification_type_tile/notification_type_tile.dart';

class NotificationTypeListWidget extends StatefulWidget {
  final NotificationsPresenter presenter;
  final double expandedHeight;
  const NotificationTypeListWidget({
    Key? key,
    required this.presenter,
    required this.expandedHeight,
  }) : super(key: key);

  @override
  State<NotificationTypeListWidget> createState() =>
      _NotificationTypeListWidgetState();
}

class _NotificationTypeListWidgetState
    extends State<NotificationTypeListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      widget.presenter.addSelectedNotificationTypeId(
        widget.presenter.getNotificationTypeList.first.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: widget.presenter.selectedNotificationTypeIdStream,
      builder: (context, snapshot) {
        List<NotificationTypeTile> notificationTileList = [];

        int selectedNotificationTypeId =
            widget.presenter.getNotificationTypeList.first.id;

        if (snapshot.hasData) {
          selectedNotificationTypeId = snapshot.data!;
        }

        final List<NotificationTypeEntity> notificationTypeList =
            widget.presenter.getNotificationTypeList;

        for (int i = 0; i < notificationTypeList.length; i++) {
          final int id = notificationTypeList[i].id;

          notificationTileList.add(
            NotificationTypeTile(
              key: GlobalKey(),
              notificationType: notificationTypeList[i],
              showSidedBorder: i == 0 ? false : true,
              showBottomBorder:
                  i == notificationTypeList.length - 1 ? true : false,
              expandedHeight: widget.expandedHeight,
              expansionTileKey: Key(i.toString()),
              initiallyExpanded: id == selectedNotificationTypeId,
              onExpansionChanged: (isExpanding) {
                if (isExpanding == true) {
                  widget.presenter.addSelectedNotificationTypeId(id);
                } else {
                  if (id == widget.presenter.selectedNotificationTypeId) {
                    setState(() {
                      widget.presenter.addSelectedNotificationTypeId(id);
                    });
                  }
                }
              },
            ),
          );
        }
        return Column(
          children: notificationTileList,
        );
      },
    );
  }
}
