import 'package:flutter/material.dart';
import 'package:hajj_app/constants.dart';

class PrayerTimePage extends StatelessWidget {
  const PrayerTimePage({super.key});
  static String id = 'PrayerTimePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor,
      appBar: AppBar(
        title: const Text('مواقيت الصلاه'),
        centerTitle: true,
      ),
     body: Card(
      color: Colors.black,
      child: Text('Prayer Time', style: TextStyle(color: Colors.white, fontSize: 24),)
     ),
      );
    
  }
}