import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/extensions/context_extension.dart';

import 'adaptive_app_bar.dart';

class AdaptiveScaffold extends StatelessWidget {
  const AdaptiveScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.backgroundColor,
  });
  final Widget body;
  final AdaptiveAppBar? appBar;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    if (context.isIOS) {
      return CupertinoPageScaffold(
        backgroundColor: backgroundColor,
        navigationBar: appBar,
        child: body,
      );
    }
    return Scaffold(
      body: body,
      appBar: appBar,
      backgroundColor: backgroundColor,
    );
  }
}
