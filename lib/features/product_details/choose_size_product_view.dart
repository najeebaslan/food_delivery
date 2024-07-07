import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/core/styles/app_text_styles.dart';
import 'package:food_delivery/features/product_details/product_details_cubit/product_details_cubit.dart';

class ChooseSizeProductView extends StatelessWidget {
  const ChooseSizeProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ProductDetailsCubit.get(context).animationController,
      builder: (context, child) {
        return Column(
          children: [
            AnimatedOpacity(
              opacity: ProductDetailsCubit.get(context).textChooseSizeOpacity.value,
              duration: Duration.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 35.w),
                    child: Text(
                      'Spudnut dounut',
                      style: AppTextStyles.font40Black700W.copyWith(
                        height: 0,
                      ),
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 3,
                    margin: EdgeInsets.only(left: 35.w),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF4DB066),
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
