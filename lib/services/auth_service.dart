import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadProfilePicture(String userId, File? imageFile) async {
    try {
      if (imageFile != null) {
        Reference storageReference = _storage.ref().child('profilePictures/$userId');
        UploadTask uploadTask = storageReference.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        return downloadURL;
      }
    } catch (e) {
      print('Error uploading profile picture: $e');
    }
    return null;
  }

   // Function to pick image from gallery
  void pickImage(Function(File) onImagePicked) async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        onImagePicked(File(pickedImage.path));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

 Future<void> registerUser(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        String defaultPhotoUrl = 'assets/images/default-avatar-profile-in-trendy-style-for-social-media-user-icon-700-228654852.jpg';

        // Create a new document in Firestore with the initial profile photo
        await _firestore.collection('users').doc(user.uid).set({
          'name': username,
          'email': email,
          'profilePicture': defaultPhotoUrl
        });

        print('User registered with default profile photo');
      } else {
        throw Exception('User registration failed');
      }
    } on FirebaseAuthException catch (e) {
      print('Error registering user: ${e.code} - ${e.message}');
      throw e;
    } catch (e) {
      print('Error registering user: $e');
      throw e;
    }
  }

  // Other authentication-related functions...
}
//https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png