import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JellyfishClassifier(),
    );
  }
}

class JellyfishClassifier extends StatefulWidget {
  @override
  _JellyfishClassifierState createState() => _JellyfishClassifierState();
}

class _JellyfishClassifierState extends State<JellyfishClassifier> {
  String predictedLabel = "";
  String predictionScore = "";
  String apiBaseUrl = "https://4543-119-204-54-208.ngrok-free.app"; // API 주소

  // 예측 라벨 가져오기 (라벨만 업데이트)
  Future<void> fetchLabel() async {
    try {
      final response = await http.get(
        Uri.parse("$apiBaseUrl/label"), // /label 엔드포인트 호출
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          predictedLabel = data['predicted_label'];
          predictionScore = ""; // Score 초기화
        });
      } else {
        setState(() {
          predictedLabel = "오류 발생!";
          predictionScore = "";
        });
      }
    } catch (e) {
      setState(() {
        predictedLabel = "네트워크 오류 발생!";
        predictionScore = "";
      });
    }
  }

  // 예측 확률 가져오기 (확률만 업데이트)
  Future<void> fetchScore() async {
    try {
      final response = await http.get(
        Uri.parse("$apiBaseUrl/score"), // /score 엔드포인트 호출
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          predictionScore = data['prediction_score'];
          predictedLabel = ""; // Label 초기화
        });
      } else {
        setState(() {
          predictionScore = "오류 발생!";
          predictedLabel = "";
        });
      }
    } catch (e) {
      setState(() {
        predictionScore = "네트워크 오류 발생!";
        predictedLabel = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jellyfish Classifier", style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        leading: Icon(
          Icons.waves, // 물고기 느낌의 기본 아이콘
          size: 30, // 아이콘 크기 조정
          color: Colors.white, // 아이콘 색상 설정
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50), // 이미지를 더 위로 올리기 위한 간격 조정

          // 이미지 표시
          Container(
            margin: EdgeInsets.only(bottom: 50), // 이미지 아래 여백 추가
            child: Image.asset("images/jellyfish.png", width: 350),
          ),

          // 예측 결과 표시 (출력 창)
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // 위아래 간격 증가
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                if (predictedLabel.isNotEmpty) // Label이 있을 때만 표시
                  Padding(
                    padding: EdgeInsets.only(bottom: 10), // Label과 Score 간격 추가
                    child: Text(
                      "Label: $predictedLabel",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                if (predictionScore.isNotEmpty) // Score가 있을 때만 표시
                  Text(
                    "Score: $predictionScore",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
              ],
            ),
          ),

          SizedBox(height: 20), // 출력창과 버튼 사이 간격 조정

          // 버튼 2개 (예측값 가져오기 / 확률 가져오기)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 예측된 라벨 가져오기 버튼
              SizedBox(
                width: 180, height: 55, // 버튼 크기 조정
                child: ElevatedButton(
                  onPressed: fetchLabel, // /label API 요청
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12), // 버튼 내부 패딩
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // 텍스트 크기
                  ),
                  child: Text("Prediction Label"),
                ),
              ),
              SizedBox(width: 15), // 버튼 간격 조정

              // 예측 확률 가져오기 버튼
              SizedBox(
                width: 180, height: 55, // 버튼 크기 조정
                child: ElevatedButton(
                  onPressed: fetchScore, // /score API 요청
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text("Prediction Score"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
