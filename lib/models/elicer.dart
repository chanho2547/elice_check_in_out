// 엘리서의 상태를 나타내는 열거형 (항목 소문자)
enum Status { checkIn, checkOut }

// 엘리서 클래스 정의
class Elicer {
  String name; // 이름
  String className = 'Flutter 3기'; // 클래스 이름 (고정값)
  Status currentStatus; // 현재 상태 (출근 또는 퇴근)
  int lateCount; // 지각 횟수
  DateTime? checkInTime; // 출근 시간
  DateTime? checkOutTime; // 퇴근 시간

  // 생성자
  Elicer({
    required this.name,
    this.currentStatus = Status.checkOut, // 기본 상태는 퇴근으로 설정
    this.lateCount = 0,
    this.checkInTime,
    this.checkOutTime,
  });

  // 출근 메서드
  void checkIn(DateTime checkInTime, DateTime standardTime) {
    this.checkInTime = checkInTime; // 입력받은 출근 시간 설정
    currentStatus = Status.checkIn; // 상태를 출근으로 변경
    // 출근 시간이 기준 시간 이후인지 확인하여 지각 여부 판단
    if (this.checkInTime!.isAfter(standardTime)) {
      lateCount++; // 지각 횟수 증가
    } else {}
  }

  // 퇴근 메서드
  void checkOut() {
    currentStatus = Status.checkOut; // 상태를 퇴근으로 변경
    checkOutTime = DateTime.now(); // 현재 시간을 퇴근 시간으로 설정
  }

  // Map으로 변환하는 메서드
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'className': className,
      'currentStatus': currentStatus == Status.checkIn ? 1 : 0,
      'lateCount': lateCount,
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
    };
  }

  // Map에서 객체로 변환하는 메서드
  static Elicer fromMap(Map<String, dynamic> map) {
    return Elicer(
      name: map['name'],
      currentStatus:
          map['currentStatus'] == 1 ? Status.checkIn : Status.checkOut,
      lateCount: map['lateCount'],
      checkInTime: map['checkInTime'] != null
          ? DateTime.parse(map['checkInTime'])
          : null,
      checkOutTime: map['checkOutTime'] != null
          ? DateTime.parse(map['checkOutTime'])
          : null,
    );
  }
}

// 9명의 엘리서 목록을 생성하는 함수
List<Elicer> getInitialElicers() {
  return [
    Elicer(name: '정찬호'),
    Elicer(name: '이예지'),
    Elicer(name: '김나연'),
    Elicer(name: '조진혁'),
    Elicer(name: '김건호'),
    Elicer(name: '임종섭'),
    Elicer(name: '유재원'),
    Elicer(name: '이준영'),
    Elicer(name: '이정건'),
  ];
}
