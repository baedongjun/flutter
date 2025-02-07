import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('카카오 로그인'),
              onPressed: () async {
                await authService.signInWithKakao();
                if (authService.user != null) {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('네이버 로그인'),
              onPressed: () async {
                await authService.signInWithNaver();
                if (authService.user != null) {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

