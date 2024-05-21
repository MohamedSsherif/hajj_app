// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hajj_app/services/user_service.dart';

// class ShowUserData extends StatefulWidget {
//    ShowUserData({super.key});

//   @override
//   State<ShowUserData> createState() => _ShowUserDataState();
// }

// class _ShowUserDataState extends State<ShowUserData> {
//   String _username = '';
//    String _imageUrl = '';
   

//   Future<void> _getUserData() async {
//     try {
//       Map<String, dynamic> userData =
//           await UserService.getUserData(FirebaseAuth.instance.currentUser!.uid);
//       setState(() {
//         _username = userData['name'];
        
//          _imageUrl = userData['profilePicture'];
         
//       });
//     } catch (e) {
//       print('Error retrieving user data: $e');
//     }
//   }
//     @override
//   void initState() {
//     super.initState();
//     _getUserData(); // Load user data when the widget initializes
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         StreamBuilder<Object>(
//           stream: FirebaseAuth.instance.authStateChanges().distinct().cast<Object>(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return const Text('Error');
//             } else if (!snapshot.hasData) {
//               return const Text('No Data');
//             }
//             return CircleAvatar(
//               backgroundColor: Colors.grey,
//               radius: 50,
//               backgroundImage: AssetImage(_imageUrl),
//             );
//           },
//         ),
//         const SizedBox(
//           height: 2,
//         ),
//         SizedBox(
//           height: 30,
//           child:  // Show username only if data is loaded
//               Text(
//                   _username,
//                   style: const TextStyle(color: Colors.white, fontSize: 18),
//                 )
              
//         ),
//       ],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hajj_app/services/user_service.dart';

class ShowUserData extends StatefulWidget {
  ShowUserData({Key? key}) : super(key: key);

  @override
  State<ShowUserData> createState() => _ShowUserDataState();
}

class _ShowUserDataState extends State<ShowUserData> {
  String _username = '';
  String _imageUrl = '';
  bool _isLoading = true;

  Future<void> _getUserData() async {
    try {
      Map<String, dynamic> userData =
          await UserService.getUserData(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _username = userData['name'];
        _imageUrl = userData['profilePicture'];
        _isLoading = false;
      });
    } catch (e) {
      print('Error retrieving user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData(); // Load user data when the widget initializes
  }

  @override
   Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('No Data');
        } else {
          var userData = snapshot.data!.data()!;
          String username = userData['name'] ?? 'No username';
          String imageUrl = userData['profilePicture'] ?? 'assets/default_profile_picture.png';

          return Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                backgroundImage: 
                    AssetImage(imageUrl) as ImageProvider,
              ),
              const SizedBox(
                height: 2,
              ),
              SizedBox(
                height: 30,
                child: Text(
                  username,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          );
        }
      },
    );
  }
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       _isLoading
  //           ? const CircularProgressIndicator()
  //           : CircleAvatar(
  //               backgroundColor: Colors.grey,
  //               radius: 50,
  //               backgroundImage: 
  //                   AssetImage(_imageUrl) as ImageProvider,
  //             ),
  //       const SizedBox(
  //         height: 2,
  //       ),
  //       SizedBox(
  //         height: 30,
  //         child: _username.isNotEmpty
  //             ? Text(
  //                 _username,
  //                 style: const TextStyle(color: Colors.white, fontSize: 18),
  //               )
  //             : const Text(
  //                 'No username',
  //                 style: TextStyle(color: Colors.white, fontSize: 18),
  //               ),
  //       ),
  //     ],
  //   );
  // }
}

