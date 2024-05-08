import 'package:flutter/material.dart';
import 'package:hajj_app/services/video_player_360.dart';
import 'package:hajj_app/widgets/container_for_360.dart';
import 'package:video_360/video_360.dart';

class PlaceBody extends StatefulWidget {
  const PlaceBody({super.key});

 //static const String id = 'place_body';
  @override
  // ignore: library_private_types_in_public_api
  _PlaceBodyState createState() => _PlaceBodyState();
}

class _PlaceBodyState extends State<PlaceBody> {

  Video360Controller? controller;

  String durationText = '';
  String totalText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('الأماكن المقدسة', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
        centerTitle: true,
      ),
       body: SingleChildScrollView(
         child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container360(
                backgroundImage: const AssetImage('assets/images/OIP.jpeg'),
                text: 'الكعبة',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const View360()),
                  );
                },
              ),
              Container360(
                backgroundImage: const AssetImage('assets/images/photo_2024-05-01_20-09-21 (2).jpg'),
                text: 'المسجد النبوي',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const View360()),
                  );
                },
              ),
              Container360(
                backgroundImage: const AssetImage('assets/images/ph.jpg'),
                text: 'منى',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const View360()),
                  );
                },
              ),
              Container360(
                backgroundImage: const AssetImage('assets/images/arafaa.jpg'),
                text: 'جبل عرفة',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const View360()),
                  );
                },
              ),
            ],
          ),
               ),
       ),
    );
  }
}
  