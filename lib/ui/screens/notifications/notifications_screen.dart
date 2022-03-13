import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../../../presentation/presentation.dart';

import './../../theme/theme.dart';

import './widgets/widgets.dart';
import './notifications_config.dart';

class NotificationsScreen extends StatefulWidget {
  final NotificationsPresenter presenter;

  const NotificationsScreen({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    widget.presenter.updateNotificationTypeListUnreadCount();

    final PreferredSizeWidget appBar = ImpressoAppBar.buildAppBar;

    final mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width;
    final double bodyHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom -
        appBar.preferredSize.height;

    final double pictureSize =
        (width - (2 * NotificationsConfig.horizontalPadding)) * 0.3;

    final double expandedHeight = bodyHeight -
        pictureSize -
        NotificationsConfig.topPadding -
        NotificationsConfig.bottomPadding -
        (NotificationsConfig.collapsedNotificationTypeStack * 3) -
        NotificationsConfig.headerBottomPadding;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar,
      body: SafeArea(
        minimum: const EdgeInsets.only(
          top: NotificationsConfig.topPadding,
          right: NotificationsConfig.horizontalPadding,
          left: NotificationsConfig.horizontalPadding,
          bottom: NotificationsConfig.bottomPadding,
        ),
        child: Provider<NotificationsPresenter>(
          create: (_) => widget.presenter,
          child: Column(
            key: GlobalKey(),
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Header(
                fullName: 'Alexandra van Wolfeschlegelsteinzuipoa',
                pictureUrl: 'https://pbs.twimg.com/media/EeoixBkWoAEphkQ.jpg',
                role: 'Pharmaceutical Science Specialisto',
                company:
                    'IMPRESSO Labs International Corporation of Industrial Clean Energy',
                place: 'Lausanne',
                pictureSize: pictureSize,
              ),
              NotificationTypeListWidget(
                expandedHeight: expandedHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }
}
