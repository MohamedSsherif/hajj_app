import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadProfileImage(String userId, File imageFile) async {
    try {
      Reference storageReference = _storage.ref().child('profilePictures/$userId');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading profile image: $e');
      throw e;
    }
  }

  Future<void> addOrUpdateProfilePhoto(String userId, File imageFile) async {
    try {
      // Upload profile image to Firebase Storage
      String imageUrl = await uploadProfileImage(userId, imageFile);

      // Update user document in Firestore with imageUrl
      await _firestore.collection('users').doc(userId).update({
        'profileImageUrl': imageUrl,
      });

      print('Profile photo added/updated for user $userId: $imageUrl');
    } catch (e) {
      print('Error adding/updating profile photo: $e');
      throw e;
    }
  }

 Future<void> updateUserInfo(String userId, String newEmail, Map<String, dynamic> userData) async {
    try {
      if (userId.isEmpty) {
        throw ArgumentError('userId cannot be empty');
      }

      // Update user document in Firestore with the new data
      await _firestore.collection('users').doc(userId).update(userData);

      // Update user's email in Firebase Authentication
      await _auth.currentUser!.updateEmail(newEmail);

      print('User information and email updated successfully for user $userId');
    } catch (e) {
      print('Error updating user information: $e');
      throw e;
    }
  }


   static Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      return userSnapshot.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error retrieving user data: $e');
      throw e;
    }
  }
}
