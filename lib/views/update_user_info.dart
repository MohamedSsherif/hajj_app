import 'package:flutter/material.dart';
import 'package:hajj_app/services/user_service.dart';


class UserProfilePage extends StatefulWidget {
  final String userId;
  static  String id = 'UserProfilePage';

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserService _userService = UserService();
  String _newUsername = '';
  String _newEmail = '';
 void _updateUserInfo() {
    // Call the updateUserInfo method with the new data
    _userService.updateUserInfo(widget.userId,  _newEmail , {
      'name': _newUsername,
      'email': _newEmail,
      // Add other fields to update here
    }).then((_) {
      // Handle success
      print('User information updated successfully.');
    }).catchError((error) {
      // Handle error
      print('Error updating user information: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Update User Information', style: TextStyle(fontSize: 20)),
            TextField(
              onChanged: (value) => _newUsername = value,
              decoration: InputDecoration(labelText: 'New Username'),
            ),
            TextField(
              onChanged: (value) => _newEmail = value,
              decoration: InputDecoration(labelText: 'New Email'),
            ),
            ElevatedButton(
              onPressed: _updateUserInfo
              ,
              
              child: Text('Update'),
              
            ),
          ],
        ),
      ),
    );
  }
}
