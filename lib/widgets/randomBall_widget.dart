import 'package:flutter/material.dart';

class RandomBall extends StatelessWidget {
  final int number;
  final bool isEmpty;
  final double size;

  const RandomBall({
    super.key,
    required this.number,
    required this.isEmpty,
    required this.size,
  });

  //숫자 범위에 따라 컬러 생성
  Color getColorForNumber(int number) {
    if (number >= 1 && number <= 10) {
      return Colors.yellow.shade700;
    } else if (number >= 11 && number <= 20) {
      return Colors.blue.shade600;
    } else if (number >= 21 && number <= 30) {
      return Colors.red.shade500;
    } else if (number >= 31 && number <= 40) {
      return Colors.grey.shade600;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size * 0.1),
      child: Container(
        width: size, //35
        height: size,
        decoration: BoxDecoration(
          color: isEmpty ? Colors.white : getColorForNumber(number),
          shape: BoxShape.circle,
          border: isEmpty
              ? Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                )
              : null,
        ),
        child: Center(
          child: Text(
            isEmpty ? '?' : '$number',
            style: TextStyle(
              fontSize: size * 0.4,
              color: isEmpty ? Colors.black12 : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
