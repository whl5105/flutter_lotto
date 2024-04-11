// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_lotto/widgets/textBetweenTable_widget.dart';
import 'package:intl/intl.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  final NumberFormat f = NumberFormat('###,###,###,###');

  final TextEditingController _winningAmountController =
      TextEditingController();
  double _incomeTax = 0.0; // 소득세
  double _residentTax = 0.0; // 주민세
  double _totalTax = 0.0; //총 세금
  double _netIncome = 0.0; //실 수령액
  double incomeTax1 = 0.0; //3억이상 소득세1
  double incomeTax2 = 0.0; //3억이상 소득세2
  double winningAmount = 0.0; //당첨금

  void _calculateTax() {
    winningAmount = double.tryParse(_winningAmountController.text) ?? 0;
    double purchaseCost = 1000; // 복권 구입비용 1000원
    double taxableAmount = winningAmount - purchaseCost; //과세 대상금 = 당첨금액 - 구입비용

    // 당첨금액 이 200만원 이하일경우
    if (winningAmount <= 2000000) {
      _incomeTax = 0.0; // 소득세 0
      _residentTax = 0.0; // 주민세 0
      _totalTax = 0.0; //총 세금 0
    } else if (winningAmount <= 300000000) {
      //당첨금액이 3미만 일경우
      _incomeTax = taxableAmount * 0.2; // 소득세 20
      _residentTax = taxableAmount * 0.02; // 주민세 2
      _totalTax = _incomeTax + _residentTax; //총 세금 = 소득세 + 주민세
    } else {
      //당첨금액이 3억이상 일경우
      incomeTax1 = 300000000 * 0.2;
      incomeTax2 = (taxableAmount - 300000000) * 0.3;
      _incomeTax = incomeTax1 + incomeTax2; // 소득세 =
      _residentTax = (300000000 * 0.02) +
          ((taxableAmount - 300000000) * 0.03); //3억의 주민세 + 나머지 주민세
      _totalTax = _incomeTax + _residentTax; //총 세금 = 소득세 + 주민세
    }

    _netIncome = winningAmount - _totalTax; //실 수령액 =  당첨금액 -  총 세금

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F8),
      appBar: AppBar(
        title: const Text('로또 당첨금 계산기'),
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffF4F5F8),
        shadowColor: Colors.black12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: TextFormField(
                  controller: _winningAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: "당첨금액",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(style: BorderStyle.none, width: 0)),
                  ),
                  // decoration: const InputDecoration(
                  //     // labelText: '당첨금',
                  //     ),
                ),
              ),
            ),
            // const SizedBox(height: 20.0),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    _calculateTax(); // 세금 계산
                    _showTaxInfoDialog(); // 다이얼로그 표시
                  },
                  child: const Text('세금 계산'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//세금 계산 결과 다이얼로그
  void _showTaxInfoDialog() {
    showDialog(
      barrierDismissible: false, // 배경 클릭으로 다이얼로그 닫히지 않도록 설정
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          backgroundColor: Colors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '예상 실수령액',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${f.format(_netIncome.truncate())}원',
                style: const TextStyle(
                    fontSize: 26,
                    color: Color(0xff107eee),
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 20),
              TextBetweenTable(
                leftText: '당첨 금액',
                rightText: '${f.format(winningAmount)}원',
                color: const Color(0xff7B7A7A),
              ),
              TextBetweenTable(
                leftText: '소득세',
                rightText: '${f.format(_incomeTax.truncate())}원',
                color: const Color(0xff7B7A7A),
              ),
              TextBetweenTable(
                leftText: '주민세',
                rightText: '${f.format(_residentTax.truncate())}원',
                color: const Color(0xff7B7A7A),
              ),
              TextBetweenTable(
                leftText: '총 세금',
                rightText: '${f.format(_totalTax.truncate())}원',
                color: const Color(0xff7B7A7A),
              ),
              const SizedBox(height: 30),
              Container(
                width: 500,
                color: const Color(0xfff1f3f5), // 회색 배경색 설정
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  '3억이상 : 소득세 30 % , 지방세 3% \n 3억이상 : 소득세 30 % , 지방세 3% \n 200만원 이하 : 비과세', // 여기에 텍스트 내용을 입력하세요
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff8F9398),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '확인',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
