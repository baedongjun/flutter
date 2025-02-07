import 'package:flutter/material.dart';

class DropinRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('드랍인 신청')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: '크로스핏 박스 이름'),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(labelText: '희망 날짜'),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(labelText: '추가 요청사항'),
              maxLines: 3,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('신청하기'),
              onPressed: () {
                // TODO: 신청 로직 구현
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

