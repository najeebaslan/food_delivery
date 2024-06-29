import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

class AdaptiveAppBar extends StatelessWidget
    implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    this.size,
    this.title,
    this.customAppBar,
  });
  final Size? size;
  final Widget? title;
  final Widget? customAppBar;
  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return customAppBar ??
          CupertinoNavigationBar(
            middle: title,
          );
    }
    return customAppBar ??
        AppBar(
          title: title,
        );
  }

  @override
  Size get preferredSize => size ?? const Size.fromHeight(kToolbarHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
