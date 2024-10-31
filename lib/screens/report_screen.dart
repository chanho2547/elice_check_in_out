import 'package:check_in_out_app/models/elicer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/elicer_provider.dart';

class ReportScreen extends ConsumerWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Elicer 객체들의 Map 가져오기
    final elicerMap = ref.watch(elicerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 94, 14, 222),
        foregroundColor: Colors.white,
        title: const Text(
          'REPORT',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Center(
          child: SizedBox(
            // width: 280,
            child: ListView(
              // 각 엘리서의 정보를 리스트로 표시
              children: elicerMap.values.map((elicer) {
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: 10), // ListTile 간의 간격 추가
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300, // 배경색 설정
                    borderRadius: BorderRadius.circular(15), // 모서리를 둥글게 설정
                  ),
                  child: ListTile(
                    // tileColor 속성은 제거하여 중복된 색상 설정을 방지
                    title: Text(elicer.name), // 엘리서 이름
                    subtitle: Text('지각 횟수: ${elicer.lateCount}'), // 지각 횟수 표시
                    trailing: Text(
                        '상태: ${elicer.currentStatus == Status.checkIn ? '입실중' : '퇴실'}'), // 현재 상태 표시
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
