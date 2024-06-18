
//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class OnboardingCircleGreenSmallCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6125088, size.height * 0.9427404);
    path_0.cubicTo(
        size.width * 0.6175491,
        size.height * 0.9626070,
        size.width * 0.6055386,
        size.height * 0.9829456,
        size.width * 0.5853491,
        size.height * 0.9864789);
    path_0.cubicTo(size.width * 0.4792105, size.height * 1.005051, size.width * 0.3695158,
        size.height * 0.9884211, size.width * 0.2732386, size.height * 0.9385421);
    path_0.cubicTo(
        size.width * 0.1659409,
        size.height * 0.8829544,
        size.width * 0.08276351,
        size.height * 0.7899351,
        size.width * 0.03947088,
        size.height * 0.6771140);
    path_0.cubicTo(
        size.width * -0.003821614,
        size.height * 0.5642912,
        size.width * -0.004220772,
        size.height * 0.4395088,
        size.width * 0.03834912,
        size.height * 0.3264123);
    path_0.cubicTo(
        size.width * 0.08091895,
        size.height * 0.2133158,
        size.width * 0.1634996,
        size.height * 0.1197667,
        size.width * 0.2704404,
        size.height * 0.06349351);
    path_0.cubicTo(
        size.width * 0.3773807,
        size.height * 0.007220368,
        size.width * 0.5012491,
        size.height * -0.007865807,
        size.width * 0.6185702,
        size.height * 0.02109404);
    path_0.cubicTo(
        size.width * 0.7358912,
        size.height * 0.05005404,
        size.width * 0.8385123,
        size.height * 0.1210475,
        size.width * 0.9069842,
        size.height * 0.2206193);
    path_0.cubicTo(size.width * 0.9754544, size.height * 0.3201930, size.width * 1.005018,
        size.height * 0.4414246, size.width * 0.9900702, size.height * 0.5613386);
    path_0.cubicTo(
        size.width * 0.9766596,
        size.height * 0.6689368,
        size.width * 0.9282474,
        size.height * 0.7687649,
        size.width * 0.8528333,
        size.height * 0.8457263);
    path_0.cubicTo(
        size.width * 0.8384877,
        size.height * 0.8603649,
        size.width * 0.8149246,
        size.height * 0.8587474,
        size.width * 0.8014035,
        size.height * 0.8433421);
    path_0.cubicTo(
        size.width * 0.7878825,
        size.height * 0.8279386,
        size.width * 0.7895474,
        size.height * 0.8045965,
        size.width * 0.8036965,
        size.height * 0.7897684);
    path_0.cubicTo(
        size.width * 0.8655491,
        size.height * 0.7249404,
        size.width * 0.9052544,
        size.height * 0.6417158,
        size.width * 0.9164175,
        size.height * 0.5521579);
    path_0.cubicTo(
        size.width * 0.9291158,
        size.height * 0.4502754,
        size.width * 0.9039982,
        size.height * 0.3472754,
        size.width * 0.8458246,
        size.height * 0.2626754);
    path_0.cubicTo(
        size.width * 0.7876491,
        size.height * 0.1780772,
        size.width * 0.7004614,
        size.height * 0.1177598,
        size.width * 0.6007825,
        size.height * 0.09315491);
    path_0.cubicTo(
        size.width * 0.5011053,
        size.height * 0.06855000,
        size.width * 0.3958632,
        size.height * 0.08136754,
        size.width * 0.3050035,
        size.height * 0.1291782);
    path_0.cubicTo(
        size.width * 0.2141456,
        size.height * 0.1769895,
        size.width * 0.1439832,
        size.height * 0.2564702,
        size.width * 0.1078149,
        size.height * 0.3525596);
    path_0.cubicTo(
        size.width * 0.07164667,
        size.height * 0.4486491,
        size.width * 0.07198579,
        size.height * 0.5546667,
        size.width * 0.1087679,
        size.height * 0.6505228);
    path_0.cubicTo(
        size.width * 0.1455502,
        size.height * 0.7463772,
        size.width * 0.2162193,
        size.height * 0.8254088,
        size.width * 0.3073825,
        size.height * 0.8726368);
    path_0.cubicTo(
        size.width * 0.3875193,
        size.height * 0.9141544,
        size.width * 0.4785965,
        size.height * 0.9285596,
        size.width * 0.5670544,
        size.height * 0.9142912);
    path_0.cubicTo(
        size.width * 0.5872895,
        size.height * 0.9110263,
        size.width * 0.6074702,
        size.height * 0.9228737,
        size.width * 0.6125088,
        size.height * 0.9427404);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff3AA856).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
