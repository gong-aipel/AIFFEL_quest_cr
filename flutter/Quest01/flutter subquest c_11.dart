import 'dart:async';

void main() {
  PomodoroTimer().start();
}

class PomodoroTimer {
  int workTime = 25; // 25분 (분 단위)
  int shortBreakTime = 5; // 5분
  int longBreakTime = 15; // 15분
  int cycleCount = 0; // 몇 번째 사이클인지 기록

  void start() {
    print("Pomodoro 타이머를 시작합니다.");
    _startWorkTimer();
  }

  void _startWorkTimer() {
    int minutesLeft = workTime;
    Timer.periodic(Duration(minutes: 1), (timer) {
      if (minutesLeft == 0) {
        timer.cancel();
        cycleCount++;
        print("작업 시간이 끝났어요");
        if (cycleCount % 4 == 0) {
          print("4번째 작업 완료 15분 쉬기 시작합니다.");
          _startBreakTimer(longBreakTime);
        } else {
          print("쉬는 시간 시작 (5분)");
          _startBreakTimer(shortBreakTime);
        }
      } else {
        print("⌛ 작업 중: $minutesLeft분 남음");
        minutesLeft--;
      }
    });
  }

  void _startBreakTimer(int breakTime) {
    int minutesLeft = breakTime; // 세미콜론 추가
    Timer.periodic(Duration(minutes: 1), (timer) {
      if (minutesLeft == 0) {
        timer.cancel();
        print("쉬는 시간이 끝났어요 다시 작업 시작");
        _startWorkTimer();
      } else {
        print("쉬는 중: $minutesLeft분 남음");
        minutesLeft--;
      }
    });
  }
}
