import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final databaseService = Provider.of<DatabaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authService.signOut(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(authService.user?.photoURL ?? ''),
                  ),
                  SizedBox(height: 16),
                  Text(
                    authService.user?.displayName ?? '이름 없음',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(authService.user?.email ?? ''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '드랍인 통계',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: databaseService.getUserProfile(authService.user!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData || snapshot.data == null) {
                            return Text('데이터가 없습니다.');
                          }
                          final data = snapshot.data!.data();
                          return Text('총 드랍인 횟수: ${data?['dropinCount'] ?? 0}회', style: TextStyle(fontSize: 18));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('드랍인 인증하기'),
              onPressed: () {
                Navigator.pushNamed(context, '/dropin_verification');
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('드랍인 신청하기'),
              onPressed: () {
                Navigator.pushNamed(context, '/dropin_request');
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('랭킹 보기'),
              onPressed: () {
                Navigator.pushNamed(context, '/ranking');
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('추천 박스 보기'),
              onPressed: () {
                Navigator.pushNamed(context, '/top_boxes');
              },
            ),
          ],
        ),
      ),
    );
  }
}