import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/elicer.dart';
import '../providers/elicer_provider.dart';

class CheckOutScreen extends ConsumerStatefulWidget {
  const CheckOutScreen({super.key});

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends ConsumerState<CheckOutScreen> {
  // 선택된 엘리서의 인덱스
  int _selectedNameIndex = 0;

  // 퇴근 처리 메서드
  void _submit() {
    // 모든 엘리서의 이름을 가져옴
    final elicerNames = ref
        .read(elicerProvider.notifier)
        .getAllElicers()
        .map((e) => e.name)
        .toList();

    String selectedName = elicerNames[_selectedNameIndex];

    // ElicerNotifier 가져오기
    final elicerNotifier = ref.read(elicerProvider.notifier);
    // 선택된 이름으로 엘리서 객체 가져오기
    Elicer? elicer = elicerNotifier.getElicerByName(selectedName);

    if (elicer != null && elicer.currentStatus == Status.checkIn) {
      // 출근 상태인 경우 퇴근 처리
      elicer.checkOut();
      elicerNotifier.updateElicer(elicer);

      // 성공 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$selectedName 퇴실 완료')),
      );

      // 선택 초기화
      setState(() {
        _selectedNameIndex = 0;
      });
    } else if (elicer != null && elicer.currentStatus == Status.checkOut) {
      // 이미 퇴근한 경우 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미 퇴실했습니다.')),
      );
    } else {
      // 출근 기록이 없는 경우 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('입실 기록이 없습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 모든 엘리서의 이름을 가져옴
    final elicerNames = ref
        .read(elicerProvider.notifier)
        .getAllElicers()
        .map((e) => e.name)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 94, 14, 222),
        foregroundColor: Colors.white,
        title: const Text(
          'OUT',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // CupertinoPicker를 사용한 이름 선택
            SizedBox(
              height: 300,
              width: 200,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedNameIndex = index;
                  });
                },
                children: elicerNames.map((name) => Text(name)).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // 퇴근하기 버튼
            ElevatedButton(
              // style: ButtonStyle(
              // backgroundColor: Color.fromARGB(225, 94, 14, 222)),
              onPressed: _submit,
              child: const Text('OUT'), // 버튼 클릭 시 _submit 메서드 호출
            ),
          ],
        ),
      ),
    );
  }
}
