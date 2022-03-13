import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../../../presentation/presentation.dart';
import './../../../../domain/domain.dart';

import './notification_type_tile/notification_type_tile.dart';

class NotificationTypeListWidget extends StatefulWidget {
  final double expandedHeight;
  const NotificationTypeListWidget({
    Key? key,
    required this.expandedHeight,
  }) : super(key: key);

  @override
  State<NotificationTypeListWidget> createState() =>
      _NotificationTypeListWidgetState();
}

class _NotificationTypeListWidgetState
    extends State<NotificationTypeListWidget> {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<NotificationsPresenter>(context);

    return StreamBuilder<int>(
      stream: presenter.selectedNotificationTypeIdStream,
      builder: (context, snapshot) {
        List<NotificationTypeTile> notificationTileList = [];

        int selectedNotificationTypeId =
            presenter.getNotificationTypeList.first.id;

        if (snapshot.hasData) {
          selectedNotificationTypeId = snapshot.data!;
        }

        final List<NotificationTypeEntity> notificationTypeList =
            presenter.getNotificationTypeList;

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
                  presenter.addSelectedNotificationTypeId(id);
                } else {
                  if (id == presenter.selectedNotificationTypeId) {
                    setState(() {
                      presenter.addSelectedNotificationTypeId(id);
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
