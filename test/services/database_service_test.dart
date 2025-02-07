import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crossfit_dropin_challenge/services/database_service.dart';

// Mockito 생성 파일
import 'database_service_test.mocks.dart';

@GenerateMocks([FirebaseFirestore, CollectionReference, DocumentReference])
void main() {
  late DatabaseService databaseService;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    databaseService = DatabaseService();

    // Firestore 인스턴스 모킹
    when(mockFirestore.collection(any)).thenReturn(MockCollectionReference());
  });

  test('addDropin should increment dropinCount', () async {
    final userId = 'test-user-id';
    final dropinData = {'boxName': 'Test Box'};
    
    // 테스트 로직 구현
    await databaseService.addDropin(userId, dropinData);
    
    verify(mockFirestore.collection('users')).called(1);
  });

  test('getUserProfile should return correct data', () async {
    // 테스트 구현
  });
} 