import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hajj_app/firebase_options.dart';
import 'package:hajj_app/views/azkar_page.dart';
import 'package:hajj_app/views/home_page.dart';
import 'package:hajj_app/views/login_page.dart';
import 'package:hajj_app/views/prayer_time.dart';
import 'package:hajj_app/views/quibla.dart';
import 'package:hajj_app/views/register_page.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const Hajj());
}

class Hajj extends StatelessWidget {
  const Hajj({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
        loginPage.id: (context) =>  loginPage(),
        Register.id: (context) =>  Register(),
        HomePage.id: (context) =>  HomePage(),
        QuiblahPage.id: (context) =>  QuiblahPage(),
        AzkarPage.id: (context) =>  AzkarPage(),
        PrayerTimePage.id: (context) =>  PrayerTimePage(),

      },
      initialRoute: loginPage.id,
    );
  }
}
