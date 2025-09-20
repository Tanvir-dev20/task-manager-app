import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utilits/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  ScreenBackground({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
