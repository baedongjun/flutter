import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';

class DropinVerificationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _boxNameController = TextEditingController();
  final _visitDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final databaseService = Provider.of<DatabaseService>(context);
    final notificationService = Provider.of<NotificationService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('드랍인 인증')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _boxNameController,
                decoration: InputDecoration(labelText: '크로스핏 박스 이름'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '크로스핏 박스 이름을 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _visitDateController,
                decoration: InputDecoration(labelText: '방문 날짜'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '방문 날짜를 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                child: Text('사진 업로드'),
                onPressed: () {
                  // TODO: 사진 업로드 로직 구현
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('인증하기'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final dropinData = {
                      'boxName': _boxNameController.text,
                      'visitDate': _visitDateController.text,
                      'userId': authService.user!.uid,
                      'timestamp': DateTime.now(),
                    };
                    await databaseService.addDropin(authService.user!.uid, dropinData);
                    await notificationService.showNotification(
                      'Drop-in 인증 완료',
                      '${_boxNameController.text}에서의 드랍인이 인증되었습니다!',
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}