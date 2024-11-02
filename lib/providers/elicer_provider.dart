import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/elicer.dart';
import '../db/database_helper.dart';

class ElicerNotifier extends StateNotifier<Map<String, Elicer>> {
  ElicerNotifier() : super({}) {
    _loadElicers(); // 데이터베이스에서 엘리서 로드
  }

  final dbHelper = DatabaseHelper.instance;

  // 데이터베이스에서 엘리서 목록 로드
  void _loadElicers() async {
    List<Elicer> elicers = await dbHelper.getElicers();

    if (elicers.isEmpty) {
      // 데이터베이스가 비어있으면 초기 엘리서 목록을 삽입
      elicers = getInitialElicers();
      for (var elicer in elicers) {
        await dbHelper.insertElicer(elicer);
      }
    }

    // 상태 업데이트
    state = {for (var elicer in elicers) elicer.name: elicer};
  }

  // 엘리서 업데이트 메서드
  void updateElicer(Elicer elicer) async {
    await dbHelper.updateElicer(elicer);
    state = {...state, elicer.name: elicer};
  }

  // 이름으로 엘리서 가져오기
  Elicer? getElicerByName(String name) {
    return state[name];
  }

  // 모든 엘리서 리스트 반환
  List<Elicer> getAllElicers() {
    return state.values.toList();
  }
}

// Provider 정의
final elicerProvider =
    StateNotifierProvider<ElicerNotifier, Map<String, Elicer>>((ref) {
  return ElicerNotifier();
});
