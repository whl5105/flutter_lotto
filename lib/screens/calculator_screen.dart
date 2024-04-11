import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

var f = NumberFormat('###,###,###,###');

class CalculatorScreenState extends State<CalculatorScreen> {
  final NumberFormat f = NumberFormat('###,###,###,###');

  final TextEditingController _winningAmountController =
      TextEditingController();
  double _incomeTax = 0.0;
  double _residentTax = 0.0;
  double _totalTax = 0.0;
  double _netIncome = 0.0;
  double incomeTax1 = 0.0;
  double incomeTax2 = 0.0;
  double winningAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F8),
      appBar: AppBar(
        title: const Text('로또 당첨금 계산기'),
        elevation: 0, // 하단 그라데이션 제거
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffF4F5F8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                    _winningAmountController.text.isEmpty
                        ? '당첨금액'
                        : f.format(double.parse(_winningAmountController.text)),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: _winningAmountController.text.isEmpty
                          ? const Color(0xff8F9398)
                          : Colors.black,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  for (var row in [
                    ['1', '2', '3'],
                    ['4', '5', '6'],
                    ['7', '8', '9'],
                    ['00', '0', 'del'],
                  ])
                    Expanded(
                      child: Row(
                        children: row.map((buttonText) {
                          return _buildButton(buttonText);
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _winningAmountController.text.isEmpty
                  ? null
                  : () {
                      _calculateTax();
                      _showTaxInfoDialog();
                    },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(double.infinity, 50), // 너비와 높이를 원하는 값으로 지정
                ),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey; // 비활성화된 상태일 때 회색으로 표시
                    }
                    return const Color(0xff107eee); // 활성화된 상태일 때 원래 버튼 색상 사용
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // 버튼의 각 모서리를 둥글게 만듭니다.
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              child: const Text(
                '세금 계산',
                style: TextStyle(
                  fontSize: 17, // 폰트 크기
                  fontWeight: FontWeight.w600, // 폰트 굵기
                  color: Colors.white, // 폰트 색상
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _calculateTax() {
    winningAmount = double.tryParse(_winningAmountController.text) ?? 0;
    double purchaseCost = 1000;
    double taxableAmount = winningAmount - purchaseCost;

    if (winningAmount <= 2000000) {
      _incomeTax = 0.0;
      _residentTax = 0.0;
      _totalTax = 0.0;
    } else if (winningAmount <= 300000000) {
      _incomeTax = taxableAmount * 0.2;
      _residentTax = taxableAmount * 0.02;
      _totalTax = _incomeTax + _residentTax;
    } else {
      incomeTax1 = 300000000 * 0.2;
      incomeTax2 = (taxableAmount - 300000000) * 0.3;
      _incomeTax = incomeTax1 + incomeTax2;
      _residentTax = (300000000 * 0.02) + ((taxableAmount - 300000000) * 0.03);
      _totalTax = _incomeTax + _residentTax;
    }

    _netIncome = winningAmount - _totalTax;
  }

  void _showTaxInfoDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              _buildTaxInfo('당첨 금액', winningAmount),
              _buildTaxInfo('소득세', _incomeTax),
              _buildTaxInfo('주민세', _residentTax),
              _buildTaxInfo('총 세금', _totalTax),
              const SizedBox(height: 30),
              Container(
                width: 500,
                color: const Color(0xfff1f3f5),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  '3억이상 : 소득세 30 % , 지방세 3% \n 3억이상 : 소득세 30 % , 지방세 3% \n 200만원 이하 : 비과세',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff8F9398),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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

  void _onNumberPressed(String number) {
    setState(() {
      if (_winningAmountController.text.isEmpty &&
          (number == '0' || number == '00')) {
        null;
      } else {
        _winningAmountController.text += number;
      }
      // if (_winningAmountController.text == '0') {
      //   _winningAmountController.text = number;
      // } else {
      //   _winningAmountController.text += number;
      // }
    });
  }

  void _onDeletePressed() {
    setState(() {
      String currentValue = _winningAmountController.text;
      if (currentValue.isNotEmpty) {
        _winningAmountController.text =
            currentValue.substring(0, currentValue.length - 1);
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (buttonText == 'del') {
            _onDeletePressed();
          } else {
            _onNumberPressed(buttonText);
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  Widget _buildTaxInfo(String title, double value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff7B7A7A),
              ),
            ),
          ),
          Text(
            '${f.format(value.truncate())}원',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff7B7A7A),
            ),
          ),
        ],
      ),
    );
  }
}
