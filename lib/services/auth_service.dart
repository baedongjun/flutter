import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // User 클래스를 직접 사용
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;  // 제거
// import 'package:flutter_naver_login/flutter_naver_login.dart';  // 이 줄 주석 처리

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;  // Firebase User

  User? get user => _user;  // Firebase User

  AuthService() {
    _auth.authStateChanges().listen((User? user) {  // Firebase User
      _user = user;
      notifyListeners();
    });
  }

  // 카카오 로그인 메서드 주석 처리
  /*
  Future<UserCredential?> signInWithKakao() async {
    try {
      if (!await kakao.isKakaoTalkInstalled()) {
        throw Exception('카카오톡이 설치되어 있지 않습니다.');
      }

      final token = await kakao.UserApi.instance.loginWithKakaoTalk();
      
      final authCredential = OAuthProvider('oidc.kakao').credential(
        idToken: token.idToken,
        accessToken: token.accessToken,
      );

      return await _auth.signInWithCredential(authCredential);
    } catch (e) {
      print('카카오 로그인 에러: $e');
      rethrow;
    }
  }
  */

  // 네이버 로그인 메서드 주석 처리
  /*
  Future<UserCredential?> signInWithNaver() async {
    try {
      final result = await FlutterNaverLogin.logIn();
      if (result.status == NaverLoginStatus.loggedIn) {
        final AuthCredential credential = OAuthProvider('oidc.naver').credential(
          idToken: result.accessToken.toString(),
          accessToken: result.accessToken.toString(),
        );
        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('네이버 로그인 에러: $e');
    }
    return null;
  }
  */

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Google 로그인 에러: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

