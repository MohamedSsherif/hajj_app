import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> updateUserInfo(String userId, String newEmail, Map<String, dynamic> userData) async {
    try {
      if (userId.isEmpty) {
        throw ArgumentError('userId cannot be empty');
      }

      // Get the current user
      User? user = _auth.currentUser;

      if (user != null && user.uid == userId) {
        // Update user document in Firestore with the new data
        await _firestore.collection('users').doc(userId).update(userData);

        // Update user's email in Firebase Authentication
        await user.updateEmail(newEmail);

        print('User information and email updated successfully for user $userId');
      } else {
        throw Exception('User not found or userId does not match the authenticated user');
      }
    } on FirebaseAuthException catch (e) {
      print('Error updating user information: ${e.code} - ${e.message}');
      throw e;
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
