import 'dart:convert';
import 'package:flutter_lotto/models/lotto_result_models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl =
      "https://www.dhlottery.co.kr/common.do?method=getLottoNumber";

  //  특정회차
  static Future<LottoResultModel> getLottoResult(int drawNo) async {
    try {
      final Uri url = Uri.parse('$baseUrl&drwNo=$drawNo');
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> lottoData = jsonDecode(response.body);
        return LottoResultModel.fromJson(lottoData);
      } else {
        throw Exception('Failed to load lotto result: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load lotto result: $e');
    }
  }

  //  최신회차
  static Future<LottoResultModel> getRealTimeLottoResult() async {
    try {
      // 시작 날짜 2024년 3월 2일 1109회 / 매주 토요일 오후 8시 35분 추첨
      DateTime startDate = DateTime(2024, 3, 2, 20, 35);

      // 현재 날짜 및 시간
      DateTime currentDate = DateTime.now();

      // 현재 시간과 시작 시간 사이의 시간 차이를 계산합니다.
      Duration difference = currentDate.difference(startDate);

      // 시간 차이를 분 단위로 변환합니다.
      int differenceInMinutes = difference.inMinutes;

      // 1회 추첨 간격은 1주일(7일)이므로 1주일을 분 단위로 계산합니다.
      int drawIntervalInMinutes = 7 * 24 * 60;

      // 현재까지의 시간 차이를 기반으로 회차 번호를 계산합니다.
      int drawNo = (differenceInMinutes / drawIntervalInMinutes).floor() + 1109;

      // 계산된 회차 번호로 API 요청을 보냅니다.
      final Uri url = Uri.parse('$baseUrl&drwNo=$drawNo');
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic jsonBody = jsonDecode(response.body);
        return LottoResultModel.fromJson(jsonBody);
      } else {
        throw Exception(
            'Failed to load real-time lotto result: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load real-time lotto result: $e');
    }
  }
}

// import 'dart:convert';
// import 'package:flutter_lotto/models/lotto_result_models.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const baseURL =
//       "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1109";

//   static Future<LottoResultModel> getLottoResult() async {
//     // final currentWeek = await getCurrentWeekNumber();
//     final url = Uri.parse(baseURL);
//     // final response = await http.get(url);
//     http.Response response = await http.get(url);

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> lottoData = jsonDecode(response.body);
//       return LottoResultModel.fromJson(lottoData);
//     } else {
//       throw Exception('Failed to load lotto result');
//     }
//   }
// }
