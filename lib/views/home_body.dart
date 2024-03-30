import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hajj_app/constants.dart';
import 'package:hajj_app/views/azkar_page.dart';
import 'package:hajj_app/views/prayer_time.dart';
import 'package:hajj_app/views/quibla.dart';
import 'package:hajj_app/widgets/List_title_drawer.dart';
import 'package:hajj_app/widgets/navigation_bottom.dart';

class HomeBody extends StatelessWidget {
  static const String id = 'home_body';
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: const Center(
        child: Text('Home Body'),
      )
    );
  }
}