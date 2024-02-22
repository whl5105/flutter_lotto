import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RandomNumberApp(),
    );
  }
}

class RandomNumberApp extends StatefulWidget {
  const RandomNumberApp({super.key});

  @override
  RandomNumberAppState createState() => RandomNumberAppState();
}

class _RandomNumberBall extends StatelessWidget {
  final int number;
  final bool isEmpty;

  const _RandomNumberBall({required this.number, required this.isEmpty});

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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 60,
        height: 60,
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
              fontSize: 20,
              color: isEmpty ? Colors.black12 : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class RandomNumberAppState extends State<RandomNumberApp> {
  List<int> selectedNumbers = [];

  // --랜덤하고 중복되지 않는 숫자를 생성하는 함수--
  void generateRandomNumbers() {
    Set<int> uniqueNumbers = {}; // Set - 중복된 값을 허용하지 않는 데이터 구조

    // uniqueNumbers 길이 확인
    while (uniqueNumbers.length < 6) {
      int randomNumber = Random().nextInt(45) + 1; // 0~44까지의 난수를 생성+1 = 1~45
      uniqueNumbers.add(randomNumber); //uniqueNumbers에 중복된 값 존재시 - 추가 무시
    }

    setState(() {
      selectedNumbers = uniqueNumbers.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('랜덤 번호 뽑기'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //-- 1열 번호  --
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (idx) => _RandomNumberBall(
                      number:
                          selectedNumbers.isNotEmpty ? selectedNumbers[idx] : 0,
                      isEmpty: selectedNumbers.isEmpty,
                    ),
                  ),
                ),
                //-- 2열 번호  --
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (idx) => _RandomNumberBall(
                      number: selectedNumbers.length > 3
                          ? selectedNumbers[idx + 3]
                          : selectedNumbers.isNotEmpty
                              ? selectedNumbers[idx]
                              : 0,
                      isEmpty: selectedNumbers.isEmpty,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                //-- 번호뽑기 버튼  --
                TextButton(
                  onPressed: () {
                    generateRandomNumbers();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.grey.shade700,
                    minimumSize: const Size(200, 50), //width, height
                  ),
                  child: const Text(
                    '번호 뽑기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //-- 하단 이미지 --
          const Image(
            image: AssetImage('assets/lottoBall.png'),
            width: 200,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
