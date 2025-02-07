import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<String?> uploadDropinImage(String userId, File imageFile) async {
    try {
      final fileName = 'dropin_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref().child('dropins/$userId/$fileName');
      
      final uploadTask = await ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('이미지 업로드 실패: $e');
      rethrow;
    }
  }

  Future<File?> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      print('이미지 선택 실패: $e');
      rethrow;
    }
  }
} 