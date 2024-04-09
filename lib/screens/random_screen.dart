import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_lotto/widgets/randomBall_widget.dart';

class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  RandomNumberAppState createState() => RandomNumberAppState();
}

class RandomNumberAppState extends State<RandomScreen> {
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
      backgroundColor: const Color(0xffF3F5FF),
      appBar: AppBar(
        title: const Text(
          '랜덤 번호 뽑기',
          // style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffF3F5FF),
        shadowColor: Colors.black12,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //-- 1열 번호  --
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (idx) => RandomBall(
                      number:
                          selectedNumbers.isNotEmpty ? selectedNumbers[idx] : 0,
                      isEmpty: selectedNumbers.isEmpty,
                      size: 60,
                    ),
                  ),
                ),
                //-- 2열 번호  --
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (idx) => RandomBall(
                      number: selectedNumbers.length > 3
                          ? selectedNumbers[idx + 3]
                          : selectedNumbers.isNotEmpty
                              ? selectedNumbers[idx]
                              : 0,
                      isEmpty: selectedNumbers.isEmpty,
                      size: 60,
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
                    backgroundColor: const Color(0xff107eee),
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
