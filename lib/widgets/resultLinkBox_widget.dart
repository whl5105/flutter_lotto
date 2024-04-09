import 'package:flutter/material.dart';

class ResultLinkBox extends StatelessWidget {
  const ResultLinkBox({
    Key? key,
    required this.title,
    required this.subTitle,
    this.nextPage,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage!), // 다음 페이지로 이동
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff7B7A7A),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward,
                  ), // 아이콘은 우측 상단에 위치
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
