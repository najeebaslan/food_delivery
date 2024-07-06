import 'package:flutter/material.dart';

class ChooseSizeProductView extends StatelessWidget {
  const ChooseSizeProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.blue,
        ),
        Container(
          height: 100,
          width: 100,
          color: Colors.blue,
        ),
      ],
    );
  }
}
