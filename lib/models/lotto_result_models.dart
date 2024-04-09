class LottoResultModel {
  final String returnValue, drwNoDate;
  final int totSellamnt,
      firstWinamnt,
      firstAccumamnt,
      firstPrzwnerCo,
      bnusNo,
      drwNo;
  final List<int> winningNumbers;

  LottoResultModel.fromJson(Map<String, dynamic> json)
      : totSellamnt = json['totSellamnt'],
        returnValue = json['returnValue'],
        drwNoDate = json['drwNoDate'],
        firstWinamnt = json['firstWinamnt'],
        firstAccumamnt = json['firstAccumamnt'],
        firstPrzwnerCo = json['firstPrzwnerCo'],
        bnusNo = json['bnusNo'],
        drwNo = json['drwNo'],
        winningNumbers = [
          json['drwtNo1'],
          json['drwtNo2'],
          json['drwtNo3'],
          json['drwtNo4'],
          json['drwtNo5'],
          json['drwtNo6'],
          json['bnusNo']
        ];
}



// {
// 	"returnValue":"success",			// 요청결과
// 	"drwNoDate":"2004-10-30",			// 날짜
// 	"totSellamnt":56561977000,			// 총상금금액
// 	"firstWinamnt":3315315525,			// 1등 상금액
// 	"firstPrzwnerCo":4,				// 1등 당첨인원
// 	"firstAccumamnt":0,
// 	"drwtNo1":1,					// 로또번호 1
// 	"drwtNo2":7,					// 로또번호 2
// 	"drwtNo3":11,					// 로또번호 3
// 	"drwtNo4":23,					// 로또번호 4
// 	"drwtNo5":37,					// 로또번호 5
// 	"drwtNo6":42,					// 로또번호 6
// 	"bnusNo":6,					// 로또 보너스 번호
// 	"drwNo":100					// 로또회차
// }
