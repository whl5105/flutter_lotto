import 'package:flutter/material.dart';

class TextBetweenTable extends StatelessWidget {
  const TextBetweenTable({
    Key? key,
    required this.leftText,
    required this.rightText,
    this.color = Colors.black,
  }) : super(key: key);

  final String leftText;
  final String rightText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: TextStyle(color: color, fontSize: 14)),
        Text(rightText, style: TextStyle(color: color, fontSize: 14)),
      ],
    );
  }
}
