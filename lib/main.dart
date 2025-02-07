import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';
import 'services/notification_service.dart';
import 'pages/login_page.dart';
import 'pages/profile_page.dart';
import 'pages/dropin_verification_page.dart';
import 'pages/dropin_request_page.dart';
import 'pages/ranking_page.dart';
import 'pages/top_boxes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => DatabaseService()),
      ],
      child: MaterialApp(
        title: 'CrossFit Drop-in Challenge',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/profile': (context) => ProfilePage(),
          '/dropin_verification': (context) => DropinVerificationPage(),
          '/dropin_request': (context) => DropinRequestPage(),
          '/ranking': (context) => RankingPage(),
          '/top_boxes': (context) => TopBoxesPage(),
        },
      ),
    );
  }
}

