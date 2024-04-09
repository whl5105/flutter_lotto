import 'dart:convert';
import 'package:flutter_lotto/models/lotto_result_models.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseURL =
      "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1109";

  static Future<LottoResultModel> getLottoResult() async {
    // final currentWeek = await getCurrentWeekNumber();
    final url = Uri.parse(baseURL);
    // final response = await http.get(url);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> lottoData = jsonDecode(response.body);
      return LottoResultModel.fromJson(lottoData);
    } else {
      throw Exception('Failed to load lotto result');
    }
  }
}
