import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/elicer.dart';

// Elicer 객체들을 관리하는 StateNotifier 클래스
class ElicerNotifier extends StateNotifier<Map<String, Elicer>> {
  // 생성자: 초기 상태를 9명의 엘리서로 설정
  ElicerNotifier() : super({}) {
    _initializeElicers(); // 초기화 메서드를 호출하여 엘리서를 초기화
  }

  // 9명의 엘리서를 초기화하는 메서드
  void _initializeElicers() {
    state = {for (var elicer in getInitialElicers()) elicer.name: elicer};
  }

  // 엘리서를 업데이트하는 메서드
  void updateElicer(Elicer elicer) {
    state = {...state, elicer.name: elicer}; // 이름을 키로 하여 Map에 저장
  }

  // 이름으로 엘리서를 가져오는 메서드
  Elicer? getElicerByName(String name) {
    return state[name]; // Map에서 이름으로 검색하여 반환
  }

  // 모든 엘리서의 리스트를 반환하는 메서드
  List<Elicer> getAllElicers() {
    return state.values.toList();
  }
}

// ElicerNotifier를 제공하는 Riverpod Provider
final elicerProvider =
    StateNotifierProvider<ElicerNotifier, Map<String, Elicer>>((ref) {
  return ElicerNotifier(); // ElicerNotifier 인스턴스 반환
});
