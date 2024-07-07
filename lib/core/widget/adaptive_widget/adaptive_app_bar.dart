import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

class AdaptiveAppBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    required this.size,
    this.title,
    this.customAppBar,
  });
  final Size size;
  final Widget? title;
  final Widget? customAppBar;
  @override
  Widget build(BuildContext context) {
    if (customAppBar != null) return customAppBar!;
    if (context.isIOS) {
      return CupertinoNavigationBar(
        middle: title,
        padding: EdgeInsetsDirectional.zero,
      );
    } else {
      return AppBar(title: title);
    }
  }

  @override
  Size get preferredSize => size;

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
