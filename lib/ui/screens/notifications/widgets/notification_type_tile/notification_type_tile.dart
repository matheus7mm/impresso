import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import './../../../../../domain/entities/entities.dart';

import '../../../../theme/theme.dart';

import './../../notifications_config.dart';
import './notification_type_tile_title.dart';
import './notification_item.dart';

class NotificationTypeTile extends StatefulWidget {
  final bool showSidedBorder;
  final NotificationTypeEntity notificationType;
  final double expandedHeight;
  final Key expansionTileKey;
  final bool initiallyExpanded;
  final void Function(bool)? onExpansionChanged;
  final bool showBottomBorder;

  const NotificationTypeTile({
    Key? key,
    required this.notificationType,
    required this.expandedHeight,
    required this.expansionTileKey,
    required this.initiallyExpanded,
    required this.onExpansionChanged,
    this.showBottomBorder = false,
    this.showSidedBorder = true,
  }) : super(key: key);

  @override
  State<NotificationTypeTile> createState() => _NotificationTypeTileState();
}

class _NotificationTypeTileState extends State<NotificationTypeTile> {
  final ExpandableController controller = ExpandableController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.expanded = widget.initiallyExpanded;

    controller.addListener(() {
      widget.onExpansionChanged!(controller.expanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kBorderColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            30,
          ),
          topLeft: Radius.circular(
            30,
          ),
        ),
      ),
      child: Container(
        decoration: widget.showSidedBorder == true
            ? BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 1,
                    color: kBorderColor.withOpacity(0.9),
                    style: BorderStyle.solid,
                  ),
                  right: BorderSide(
                    width: 1,
                    color: kBorderColor.withOpacity(0.9),
                    style: BorderStyle.solid,
                  ),
                ),
              )
            : null,
        child: Container(
          margin: EdgeInsets.only(
            top: 1,
            left: widget.showSidedBorder == false ? 1 : 0,
            right: widget.showSidedBorder == false ? 1 : 0,
            bottom: widget.showBottomBorder == true ? 1 : 0,
          ),
          decoration: const BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                30,
              ),
              topLeft: Radius.circular(
                30,
              ),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ListTileTheme(
              child: ExpandablePanel(
                key: widget.expansionTileKey,
                controller: controller,
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  hasIcon: false,
                ),
                header: SizedBox(
                  height: NotificationsConfig.collapsedNotificationTypeStack,
                  child: NotificationTypeTileTitle(
                    notificationType: widget.notificationType,
                    textColor: controller.expanded == true
                        ? kNotificationTileExpandedTextColor
                        : kNotificationTileCollapsedTextColor,
                  ),
                ),
                collapsed: Container(),
                expanded: SizedBox(
                  height: widget.expandedHeight,
                  child: RawScrollbar(
                    isAlwaysShown: true,
                    interactive: true,
                    thickness: 10,
                    thumbColor: kBackgroundColor,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: kBorderColor,
                        width: 1,
                      ),
                    ),
                    controller: scrollController,
                    child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: widget.notificationType.notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTileTheme(
                            dense: false,
                            child: NotificationItem(
                              key: GlobalKey(),
                              message: widget.notificationType
                                  .notifications[index].message,
                              time: widget.notificationType.notifications[index]
                                  .getStringTime(),
                              url: widget.notificationType.notifications[index]
                                  .pictureUrl,
                              hasBeenRead: widget.notificationType
                                  .notifications[index].hasBeenRead,
                              notificationTypeId: widget.notificationType.id,
                              notificationId: widget
                                  .notificationType.notifications[index].id,
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
