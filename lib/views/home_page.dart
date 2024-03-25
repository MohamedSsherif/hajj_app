import 'package:flutter/material.dart';
import 'package:hajj_app/constants.dart';
import 'package:hajj_app/views/azkar_page.dart';
import 'package:hajj_app/views/prayer_time.dart';
import 'package:hajj_app/views/quibla.dart';
import 'package:hajj_app/widgets/List_title_drawer.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hajj_app/widgets/navigation_bottom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = 'HomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'قافلة المسلمين',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 20,
              backgroundImage: AssetImage('assets/images/Hajj.png'),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: KPrimaryColor,
      ),
      body: const NavigationBottom(),
      endDrawer: Drawer(
          child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: KPrimaryColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/OIP.jpeg'),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'قافلة المسلمين',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
         
          ListTileDrawer(
            title: 'مواقيت الصلاه',
            icon: const Icon(FlutterIslamicIcons.kowtow),
            onTap: () {
              Navigator.pushNamed(context, PrayerTimePage.id);
            },
          ),
          ListTileDrawer(
            title: ' اتجاه القبله',
            icon: const Icon(FlutterIslamicIcons.qibla),
            onTap: () {
              Navigator.pushNamed(context, QuiblahPage.id);
            },
          ),
          ListTileDrawer(
            title: 'الاذكار',
            icon: const Icon(FlutterIslamicIcons.hadji),
            onTap: () {
              Navigator.pushNamed(context, AzkarPage.id);
            
            },
          ),
          ListTileDrawer(
            title: 'المساعدة',
            icon: const Icon(Icons.help_center_outlined),
          ),
        ],
      )),
    );
  }
}
