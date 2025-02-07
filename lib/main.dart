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
import 'services/cache_service.dart';
import 'services/connectivity_service.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 서비스 초기화
  await Firebase.initializeApp();
  final cacheService = await CacheService.init();
  final connectivityService = ConnectivityService();
  final storageService = StorageService();
  
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('에러가 발생했습니다: ${details.exception}'),
        ),
      ),
    );
  };
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => DatabaseService()),
        Provider(create: (_) => NotificationService()),
        Provider(create: (_) => storageService),
        Provider(create: (_) => cacheService),
        ChangeNotifierProvider(create: (_) => connectivityService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrossFit Drop-in Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/profile': (context) => ProfilePage(),
        '/dropin_verification': (context) => DropinVerificationPage(),
        '/dropin_request': (context) => DropinRequestPage(),
        '/ranking': (context) => RankingPage(),
        '/top_boxes': (context) => TopBoxesPage(),
      },
    );
  }
}

