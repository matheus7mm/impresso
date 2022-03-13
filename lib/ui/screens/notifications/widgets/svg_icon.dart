import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetPath;
  final double iconSize;

  const SvgIcon({
    Key? key,
    required this.assetPath,
    this.iconSize = 36,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: iconSize,
      width: iconSize,
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          assetPath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
