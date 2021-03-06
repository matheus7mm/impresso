import 'package:flutter/material.dart';

import './data/data.dart';
import './presentation/presentation.dart';
import './ui/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    AppConfig.setOrientation(portraitMode: true);
  }

  @override
  Widget build(BuildContext context) {
    final NotificationTypeRepository notificationTypeRepository =
        NotificationTypeRepository();

    return MaterialApp(
      title: 'IMPRESSO Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans'),
      home: NotificationsScreen(
        presenter: StreamNotificationsPresenter(
          fetchNotificationType: LocalFetchNotificationType(
            repository: notificationTypeRepository,
          ),
          setNotificationAsRead: LocalSetNotificationAsRead(
            repository: notificationTypeRepository,
          ),
          loadNotificationTypeUnreadCount: LocalLoadNotificationTypeUnreadCount(
            repository: notificationTypeRepository,
          ),
          setNotificationTypeOnTop: LocalSetNotificationTypeOnTop(
            repository: notificationTypeRepository,
          ),
        ),
      ),
    );
  }
}
