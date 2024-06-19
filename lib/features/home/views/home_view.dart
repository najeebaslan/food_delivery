import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_colors.dart';
import 'package:gap/gap.dart';

import 'widgets/app_bar_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: 26.w,
            left: 26.w,
            top: 30.h,
          ),
          child: Column(
            children: [
              AppBarHomeView(),
              Gap(14.h),
              HeaderHomeView(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderHomeView extends StatelessWidget {
  const HeaderHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PlatformWidget(
          cupertino: (_, __) => _buildIOSSearchTextField(),
          material: (_, __) => _buildAndroidSearchTextField(),
        )
      ],
    );
  }

  Widget _buildAndroidSearchTextField() {
    return TextField(
      // onChanged: (){},
      decoration: InputDecoration(
        hintText: 'What you wanna order today ?..',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildIOSSearchTextField() {
    return CupertinoSearchTextField(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
        height: 0,
      ),
      backgroundColor: AppColors.white,
      onChanged: (value) {
        print(value);
      },
      placeholder: 'What you wanna order today ?..',
    );
  }
}
