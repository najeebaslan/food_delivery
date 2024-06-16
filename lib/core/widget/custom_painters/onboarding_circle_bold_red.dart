import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingCircleBoldRed extends StatelessWidget {
  const OnboardingCircleBoldRed({super.key});

  @override
  Widget build(BuildContext context) {
    double onboardingCircleRedWidth = 69.33.w;

    return CustomPaint(
      size: Size(
        onboardingCircleRedWidth,
        (onboardingCircleRedWidth * 1.0142857142857142).toDouble(),
      ),
      painter: OnboardingCircleBoldRedCustomPainter(),
    );
  }
}

class OnboardingCircleBoldRedCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1835171, size.height * 0.2455352);
    path_0.cubicTo(
        size.width * 0.1482114,
        size.height * 0.2173887,
        size.width * 0.1423493,
        size.height * 0.1657310,
        size.width * 0.1763400,
        size.height * 0.1360524);
    path_0.cubicTo(
        size.width * 0.2456371,
        size.height * 0.07554535,
        size.width * 0.3312100,
        size.height * 0.03501901,
        size.width * 0.4236086,
        size.height * 0.01990338);
    path_0.cubicTo(
        size.width * 0.5432200,
        size.height * 0.0003360113,
        size.width * 0.6659543,
        size.height * 0.02471028,
        size.width * 0.7685543,
        size.height * 0.08840648);
    path_0.cubicTo(
        size.width * 0.8711529,
        size.height * 0.1521028,
        size.width * 0.9464857,
        size.height * 0.2506944,
        size.width * 0.9802757,
        size.height * 0.3654972);
    path_0.cubicTo(size.width * 1.014066, size.height * 0.4802986, size.width * 1.003963,
        size.height * 0.6033338, size.width * 0.9518843, size.height * 0.7112831);
    path_0.cubicTo(
        size.width * 0.8998057,
        size.height * 0.8192324,
        size.width * 0.8093686,
        size.height * 0.9045944,
        size.width * 0.6977143,
        size.height * 0.9511901);
    path_0.cubicTo(
        size.width * 0.5860600,
        size.height * 0.9977873,
        size.width * 0.4609457,
        size.height * 1.002382,
        size.width * 0.3460857,
        size.height * 0.9641014);
    path_0.cubicTo(
        size.width * 0.2312243,
        size.height * 0.9258211,
        size.width * 0.1345987,
        size.height * 0.8473268,
        size.width * 0.07452043,
        size.height * 0.7434958);
    path_0.cubicTo(
        size.width * 0.02811043,
        size.height * 0.6632873,
        size.width * 0.006001486,
        size.height * 0.5722634,
        size.width * 0.009884686,
        size.height * 0.4810817);
    path_0.cubicTo(
        size.width * 0.01178939,
        size.height * 0.4363563,
        size.width * 0.05613586,
        size.height * 0.4082423,
        size.width * 0.1005613,
        size.height * 0.4174859);
    path_0.cubicTo(
        size.width * 0.1449871,
        size.height * 0.4267296,
        size.width * 0.1723014,
        size.height * 0.4700577,
        size.width * 0.1741429,
        size.height * 0.5147859);
    path_0.cubicTo(
        size.width * 0.1762743,
        size.height * 0.5665577,
        size.width * 0.1909057,
        size.height * 0.6174901,
        size.width * 0.2173371,
        size.height * 0.6631718);
    path_0.cubicTo(
        size.width * 0.2574686,
        size.height * 0.7325282,
        size.width * 0.3220143,
        size.height * 0.7849620,
        size.width * 0.3987386,
        size.height * 0.8105324);
    path_0.cubicTo(
        size.width * 0.4754643,
        size.height * 0.8361028,
        size.width * 0.5590386,
        size.height * 0.8330338,
        size.width * 0.6336214,
        size.height * 0.8019085);
    path_0.cubicTo(
        size.width * 0.7082057,
        size.height * 0.7707817,
        size.width * 0.7686157,
        size.height * 0.7137620,
        size.width * 0.8034029,
        size.height * 0.6416535);
    path_0.cubicTo(
        size.width * 0.8381914,
        size.height * 0.5695451,
        size.width * 0.8449386,
        size.height * 0.4873592,
        size.width * 0.8223686,
        size.height * 0.4106732);
    path_0.cubicTo(
        size.width * 0.7997971,
        size.height * 0.3339873,
        size.width * 0.7494757,
        size.height * 0.2681296,
        size.width * 0.6809414,
        size.height * 0.2255817);
    path_0.cubicTo(
        size.width * 0.6124071,
        size.height * 0.1830338,
        size.width * 0.5304214,
        size.height * 0.1667521,
        size.width * 0.4505229,
        size.height * 0.1798225);
    path_0.cubicTo(
        size.width * 0.3979000,
        size.height * 0.1884310,
        size.width * 0.3485914,
        size.height * 0.2093789,
        size.width * 0.3065086,
        size.height * 0.2404183);
    path_0.cubicTo(
        size.width * 0.2701529,
        size.height * 0.2672324,
        size.width * 0.2188229,
        size.height * 0.2736817,
        size.width * 0.1835171,
        size.height * 0.2455352);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffE8453C).withOpacity(0.90);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
