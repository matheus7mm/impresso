import 'package:flutter/material.dart';

import './../../../theme/theme.dart';

import './svg_icon.dart';

class ImpressoAppBar {
  static PreferredSizeWidget get buildAppBar => AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 20,
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.only(
            right: 14,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SvgIcon(
                assetPath: MainAssets.backArrowSvg,
              ),
              Expanded(
                child: Container(),
              ),
              const SvgIcon(
                assetPath: MainAssets.settingsSvg,
              ),
              const SvgIcon(
                assetPath: MainAssets.editSvg,
              ),
              const SvgIcon(
                assetPath: MainAssets.booksSvg,
              ),
              const SvgIcon(
                assetPath: MainAssets.shareSvg,
              ),
            ],
          ),
        ),
      );
}
