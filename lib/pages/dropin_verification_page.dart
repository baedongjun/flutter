import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/notification_service.dart';

class DropinVerificationPage extends StatefulWidget {
  const DropinVerificationPage({Key? key}) : super(key: key);

  @override
  State<DropinVerificationPage> createState() => _DropinVerificationPageState();
}

class _DropinVerificationPageState extends State<DropinVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _boxNameController = TextEditingController();
  final _visitDateController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _boxNameController.dispose();
    _visitDateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    try {
      final authService = context.read<AuthService>();
      final databaseService = context.read<DatabaseService>();
      final notificationService = context.read<NotificationService>();

      final dropinData = {
        'boxName': _boxNameController.text,
        'visitDate': _visitDateController.text,
        'userId': authService.user!.uid,
        'timestamp': DateTime.now().toIso8601String(),
      };

      await databaseService.addDropin(authService.user!.uid, dropinData);
      await notificationService.showNotification(
        'Drop-in 인증 완료',
        '${_boxNameController.text}에서의 드랍인이 인증되었습니다!',
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 실패: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('드랍인 인증')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
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
                      onPressed: _isLoading ? null : () => _submitForm(context),
                      child: Text(_isLoading ? '처리중...' : '인증하기'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}