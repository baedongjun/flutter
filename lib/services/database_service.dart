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
    await _db.collection('users').doc(userId).collection('dropins').add(dropinData);
    // 드랍인 횟수 증가
    await _db.collection('users').doc(userId).update({
      'dropinCount': FieldValue.increment(1),
    });
  }

  Future<List<Map<String, dynamic>>> getRankings() async {
    final snapshot = await _db.collection('users').orderBy('dropinCount', descending: true).limit(10).get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> getTopBoxes() async {
    final snapshot = await _db.collection('boxes').orderBy('dropinCount', descending: true).limit(10).get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}