import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> rankings = [
    {'name': '홍길동', 'dropins': 20},
    {'name': '김철수', 'dropins': 18},
    {'name': '이영희', 'dropins': 15},
    // TODO: 실제 데이터로 대체
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('랭킹')),
      body: ListView.builder(
        itemCount: rankings.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('${index + 1}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            title: Text(rankings[index]['name']),
            trailing: Text('${rankings[index]['dropins']}회'),
          );
        },
      ),
    );
  }
}

