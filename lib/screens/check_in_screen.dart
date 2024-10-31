import 'package:check_in_out_app/widgets/elice_white_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/elicer.dart';
import '../providers/elicer_provider.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  // 선택된 엘리서의 인덱스
  int _selectedNameIndex = 0;

  // 시간을 선택하기 위한 TimeOfDay 변수
  TimeOfDay? _selectedTime;

  // 기준 출근 시간 설정 (오전 9시)
  DateTime get standardCheckInTime {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 9, 0);
  }

  // 출근 처리 메서드
  void _submit() {
    // 시간이 선택되었는지 확인
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('입실 시간을 선택해주세요.')),
      );
      return;
    }

    // 모든 엘리서의 이름을 가져옴
    final elicerNames = ref
        .read(elicerProvider.notifier)
        .getAllElicers()
        .map((e) => e.name)
        .toList();

    String selectedName = elicerNames[_selectedNameIndex];

    // 선택된 시간을 DateTime 객체로 변환
    DateTime now = DateTime.now();
    DateTime checkInTime = DateTime(now.year, now.month, now.day,
        _selectedTime!.hour, _selectedTime!.minute);

    // ElicerNotifier 가져오기
    final elicerNotifier = ref.read(elicerProvider.notifier);
    // 선택된 이름으로 엘리서 객체 가져오기
    Elicer? elicer = elicerNotifier.getElicerByName(selectedName);

    if (elicer != null) {
      // 출근 처리 업데이트
      elicer.checkIn(checkInTime, standardCheckInTime);
      elicerNotifier.updateElicer(elicer);

      // 성공 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$selectedName 입실 완료')),
      );

      // 선택 초기화
      setState(() {
        _selectedTime = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('선택한 엘리서를 찾을 수 없습니다.')),
      );
    }
  }

  // 시간 선택 다이얼로그 표시
  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
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

    String timeText = _selectedTime != null ? "TIME" : 'TIME';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(225, 94, 14, 222),
          foregroundColor: Colors.white,
          title: const Text(
            'IN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
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

                // 출근 시간 선택 버튼
                GestureDetector(
                  onTap: _pickTime,
                  child: EliceWhiteButton(text: timeText),
                ),
                const SizedBox(height: 40),
                // 출근하기 버튼
                ElevatedButton(
                  // style: ButtonStyle(
                  // backgroundColor: Color.fromARGB(225, 94, 14, 222)),
                  onPressed: _submit,
                  child: const Text('GET IN'), // 버튼 클릭 시 _submit 메서드 호출
                ),
              ],
            ),
          ),
        ));
  }
}
