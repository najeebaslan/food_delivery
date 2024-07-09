import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/styles/app_text_styles.dart';

class TitleAndSubtitleProduct extends StatelessWidget {
  const TitleAndSubtitleProduct({
    super.key,
    required this.isOdd,
    required this.index,
    required this.title,
    required this.color,
  });
  final bool isOdd;
  final int index;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isOdd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 140.w,
            maxHeight: 28.h,
          ),
          child: AutoSizeText(
            title,
            textAlign: isOdd ? TextAlign.left : TextAlign.right,
            style: AppTextStyles.font30Black400W.copyWith(
              height: 0,
            ),
          ),
        ),
        if (index != 0)
          Container(
            width: 80.w,
            height: 3.h,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 10),
                  spreadRadius: 0,
                )
              ],
            ),
          )
        else
          Gap(50.h),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 232.w,
            maxHeight: 32.h,
          ),
          child: AutoSizeText(
            'Want a delicious meal, but no \ntime we will deliver it hot and yummy.',
            textAlign: isOdd ? TextAlign.right : TextAlign.left,
            textDirection: TextDirection.ltr,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Black400W.copyWith(
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}
