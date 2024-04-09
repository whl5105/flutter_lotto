import 'package:flutter/material.dart';
import 'package:flutter_lotto/models/lotto_result_models.dart';
import 'package:flutter_lotto/services/api_service.dart';
import 'package:flutter_lotto/widgets/randomBall_widget.dart';
import 'package:flutter_lotto/widgets/textBetweenTable_widget.dart';
import 'package:intl/intl.dart';

class LottoResultsCard extends StatelessWidget {
  final int lottoDrwNo; //로또 회차번호
  const LottoResultsCard({
    Key? key,
    required this.lottoDrwNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NumberFormat f = NumberFormat('###,###,###,###');
    return FutureBuilder<LottoResultModel>(
      future: ApiService.getLottoResult(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 로딩 중일 때 표시할 위젯
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final lottoResult = snapshot.data!;
          return Container(
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // -- 회차 --
                Text.rich(
                  TextSpan(
                    text: '제',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${f.format(lottoResult.drwNo)}회',
                        style: const TextStyle(color: Color(0xff107eee)),
                      ),
                    ],
                  ),
                ),
                // -- 추첨 일자 --
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    '(${lottoResult.drwNoDate} 추첨)',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                // -- 추첨 번호 --
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...lottoResult.winningNumbers
                        .take(lottoResult.winningNumbers.length - 1)
                        .map(
                          (item) => RandomBall(
                            number: item,
                            isEmpty: false,
                            size: 35,
                          ),
                        )
                        .toList(),
                    const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.grey,
                    ),
                    RandomBall(
                        number: lottoResult.winningNumbers.last,
                        isEmpty: false,
                        size: 35),
                  ],
                ),
                const SizedBox(height: 32),
                // --총 상금액 ,1등 당첨 금액, 1등 당첨인원  --
                TextBetweenTable(
                  leftText: '총 상금액',
                  rightText: '${f.format(lottoResult.totSellamnt)} 원',
                ),
                TextBetweenTable(
                  leftText: '1등 당첨 금액',
                  rightText: '${f.format(lottoResult.firstWinamnt)} 원',
                ),
                TextBetweenTable(
                  leftText: '1등 당첨인원',
                  rightText: '${lottoResult.firstPrzwnerCo} 명',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
