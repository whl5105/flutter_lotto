import 'package:flutter/material.dart';
import 'package:flutter_lotto/screens/calculator_screen.dart';
import 'package:flutter_lotto/screens/qr_scanner_screen.dart';
import 'package:flutter_lotto/screens/random_screen.dart';
import 'package:flutter_lotto/widgets/lottoResultsCard_widget.dart';
import 'package:flutter_lotto/widgets/resultLinkBox_widget.dart';
import 'package:intl/intl.dart';

var f = NumberFormat('###,###,###,###');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        backgroundColor: const Color(0xffF4F5F8),
        elevation: 0, // 하단 그라데이션 제거
        leading: const SizedBox(
          child: Image(
            image: AssetImage('assets/logo.png'),
          ),
        ),
        actions: const <Widget>[
          SizedBox(
            width: 24,
            height: 24,
            child: Image(
              image: AssetImage('assets/bell.png'),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF4F5F8),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              LottoResultsCard(lottoDrwNo: 1122),
              SizedBox(height: 16),
              Row(
                children: [
                  ResultLinkBox(
                      title: 'QR 확인',
                      subTitle: 'QR 코드\n간편 확인!',
                      nextPage: QrScannerScreen()),
                  SizedBox(width: 8),
                  ResultLinkBox(
                      title: '랜덤 뽑기',
                      subTitle: '자동번호 뽑기\n',
                      nextPage: RandomScreen()),
                  SizedBox(width: 8),
                  ResultLinkBox(
                      title: '계산기',
                      subTitle: '실수령액\n바로 확인!',
                      nextPage: CalculatorScreen()),
                ],
              ),
              //큐알
            ],
          ),
        ),
      ),
    );
  }
}
