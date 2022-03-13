import 'package:flutter/material.dart';

import './../../../theme/theme.dart';

import './svg_icon_widget.dart';

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
              const SvgIconWidget(
                assetPath: MainAssets.backArrowSvg,
              ),
              Expanded(
                child: Container(),
              ),
              const SvgIconWidget(
                assetPath: MainAssets.settingsSvg,
              ),
              const SvgIconWidget(
                assetPath: MainAssets.editSvg,
              ),
              const SvgIconWidget(
                assetPath: MainAssets.booksSvg,
              ),
              const SvgIconWidget(
                assetPath: MainAssets.shareSvg,
              ),
            ],
          ),
        ),
      );
}
