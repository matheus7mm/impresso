import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './../../../theme/theme.dart';

class AvatarWidget extends StatelessWidget {
  final String? url;
  final double avatarSize;

  const AvatarWidget({
    Key? key,
    this.url,
    this.avatarSize = 45.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Radius radius = Radius.circular(avatarSize * 0.44);
    Radius topLeftRadius = Radius.circular(avatarSize * 0.06);

    return url != null
        ? Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(url!),
              ),
              borderRadius: BorderRadius.only(
                topRight: radius,
                bottomLeft: radius,
                bottomRight: radius,
                topLeft: topLeftRadius,
              ),
            ),
          )
        : SizedBox(
            width: avatarSize,
            height: avatarSize,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: radius,
                bottomLeft: radius,
                bottomRight: radius,
                topLeft: topLeftRadius,
              ),
              child: Center(
                child: SvgPicture.asset(
                  NotificationsAssets.logoSvg,
                  width: avatarSize,
                  height: avatarSize,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
  }
}
