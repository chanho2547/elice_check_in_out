// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:check_in_out_app/widgets/elice_button.dart';
import 'package:flutter/material.dart';

import 'package:check_in_out_app/screens/check_in_screen.dart';
import 'package:check_in_out_app/screens/check_out_screen.dart';

import 'report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onInTap() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CheckInScreen()),
      );
    }

    void onOutTap() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CheckOutScreen()),
      );
    }

    void onLogTap() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ReportScreen()),
      );
    }

    return Scaffold(
      // 앱바 설정
      appBar: AppBar(
        title: SizedBox(
          width: 160,
          child: Image.asset("assets/images/elice_logo.png"),
        ),
        // backgroundColor: const Color.fromARGB(225, 94, 14, 222),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Image.asset(
              'assets/images/lab.png', // 배경 이미지 경로 (assets 폴더 안에 이미지가 있어야 합니다.)
              fit: BoxFit.cover, // 이미지를 화면에 맞게 조정
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: onInTap,
                child: EliceButton(text: "IN"),
              ),
              GestureDetector(
                onTap: onOutTap,
                child: EliceButton(text: "OUT"),
              ),
              GestureDetector(
                onTap: onLogTap,
                child: EliceButton(text: "LOG"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// ElevatedButton(
//             child: const Text('입실하기'),
//             onPressed: () {
//               // 출근하기 화면으로 이동
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const CheckInScreen()),
//               );
//             },
//           ),
//           // 퇴근하기 버튼
//           ElevatedButton(
//             child: const Text('퇴실하기'),
//             onPressed: () {
//               // 퇴근하기 화면으로 이동
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const CheckOutScreen()),
//               );
//             },
//           ),
//           // 리포트 보기 버튼
//           ElevatedButton(
//             child: const Text('리포트 보기'),
//             onPressed: () {
//               // 리포트 화면으로 이동
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ReportScreen()),
//               );
//             },
//           ),