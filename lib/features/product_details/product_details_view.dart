// create class ProductDetailsView for navigator from Home View to Product Details and using navigator push to navigate to ProductDetailsView and create a hero animation for the image and text and using curve easeInOutBack and give it a tag to animate it and speed transition

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../core/styles/app_colors.dart';
import '../home/views/widgets/app_bar/app_bar_home_view.dart';
import '../home/views/widgets/header_text_field.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final double _size = 10;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        //     Scaffold(
        //   floatingActionButton: FloatingActionButton(
        //     child: Icon(Icons.add),
        //     onPressed: () => setState(() => _size += 50),
        //   ),
        //   body:
        //   AnimatedDefaultTextStyle(curve: Curves.easeInOutBack,
        //     duration: Duration(milliseconds: 400),
        //     style: TextStyle(fontSize: _size),
        //     child: Text('A',style: TextStyle(color: Colors.red),),
        //   ),
        // );
        PlatformScaffold(
      backgroundColor: AppColors.productDetailsBackground,
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: EdgeInsets.only(
            right: 24.w,
            left: 24.w,
            top: 55.h,
          ),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppBarHomeView(
                  redCircleTag: 'redCircleTag',
                  showIconMenuWithTitleOnly: true,
                ),
                Gap(21.h),
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: const HeaderTextField(
                    startAnimationHero: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
