import 'package:flutter/material.dart';

class TopBoxesPage extends StatelessWidget {
  final List<Map<String, dynamic>> topBoxes = [
    {'name': 'CrossFit A', 'location': '서울', 'dropins': 100},
    {'name': 'CrossFit B', 'location': '부산', 'dropins': 80},
    {'name': 'CrossFit C', 'location': '대구', 'dropins': 60},
    // TODO: 실제 데이터로 대체
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('추천 크로스핏 박스')),
      body: ListView.builder(
        itemCount: topBoxes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topBoxes[index]['name']),
            subtitle: Text(topBoxes[index]['location']),
            trailing: Text('${topBoxes[index]['dropins']}회 방문'),
          );
        },
      ),
    );
  }
}

