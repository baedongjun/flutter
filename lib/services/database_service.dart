// TODO Implement this library.import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(String userId) async {
    return await _db.collection('users').doc(userId).get();
  }

  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(userId).set(data, SetOptions(merge: true));
  }

  Future<void> addDropin(String userId, Map<String, dynamic> dropinData) async {
    try {
      final userRef = _db.collection('users').doc(userId);
      
      await _db.runTransaction((transaction) async {
        final userDoc = await transaction.get(userRef);
        
        // 드랍인 추가
        await userRef.collection('dropins').add(dropinData);
        
        // 카운트 증가
        final currentCount = userDoc.data()?['dropinCount'] ?? 0;
        transaction.update(userRef, {
          'dropinCount': currentCount + 1,
          'lastDropinDate': DateTime.now(),
        });
      });
    } catch (e) {
      throw Exception('드랍인 추가 실패: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getRankings() async {
    final snapshot = await _db.collection('users')
        .orderBy('dropinCount', descending: true)
        .limit(10)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Map<String, dynamic>>> getTopBoxes() async {
    final snapshot = await _db.collection('boxes')
        .orderBy('dropinCount', descending: true)
        .limit(10)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}