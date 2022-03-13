import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './../../../theme/theme.dart';

import './avatar_widget.dart';

class HeaderWidget extends StatelessWidget {
  final String fullName;
  final String pictureUrl;
  final String role;
  final String company;
  final String place;
  final double pictureSize;

  const HeaderWidget({
    Key? key,
    required this.fullName,
    required this.pictureUrl,
    required this.role,
    required this.company,
    required this.place,
    required this.pictureSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 7,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: const TextStyle(
                      color: kHeaderTitle,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                      color: kHeaderSubtitle,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    company,
                    style: const TextStyle(
                      color: kHeaderSubtitle,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    place,
                    style: const TextStyle(
                      color: kHeaderSubtitle,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: pictureSize * 0.2,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(NotificationsAssets.checkSvg),
                        const SizedBox(
                          width: 2,
                        ),
                        SvgPicture.asset(NotificationsAssets.s1Svg),
                      ],
                    ),
                    SvgPicture.asset(NotificationsAssets.checkSvg),
                    SvgPicture.asset(NotificationsAssets.checkSvg),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: AvatarWidget(
              url: pictureUrl,
              avatarSize: pictureSize,
            ),
          )
        ],
      ),
    );
  }
}
