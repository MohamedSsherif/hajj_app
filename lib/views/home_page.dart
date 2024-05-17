import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hajj_app/auth/login_page.dart';
import 'package:hajj_app/constants.dart';
import 'package:hajj_app/services/prayer_times_service.dart';
import 'package:hajj_app/services/user_service.dart';
import 'package:hajj_app/views/EmergencyPage.dart';
import 'package:hajj_app/views/azkar_page.dart';
import 'package:hajj_app/views/doaa_body.dart';
import 'package:hajj_app/views/home_body.dart';
import 'package:hajj_app/views/mnask_body.dart';
import 'package:hajj_app/views/place_body.dart';
import 'package:hajj_app/views/prayer_time.dart';
import 'package:hajj_app/views/quibla.dart';
import 'package:hajj_app/views/tasbih_page.dart';
import 'package:hajj_app/views/update_user_info.dart';
import 'package:hajj_app/widgets/List_title_drawer.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userId});
  static String id = 'HomePage';
  final String userId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PrayerTimeService service;
  late String _username;
  //late String _imageUrl;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
   // _getUserData();
    // PrayerTimeService.instance.getPrayersTimes();
  }
  Future<void> _getUserData() async {
    try {
      Map<String, dynamic> userData =
          await UserService.getUserData(widget.userId);
      setState(() {
        _username = userData['name'];
        // _imageUrl = userData['imageUrl'];
      });
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: currentPageIndex == 2 || currentPageIndex == 3
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'قافلة المسلمين',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/ji8.jpg'),
                    ),
                  ],
                ),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 156, 149, 87),
              ),
        endDrawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: KPrimaryColor,
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/ji8.jpg'),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 30,
                    child: StreamBuilder<Object>(
                        stream: FirebaseAuth.instance
                            .authStateChanges().distinct()
                            .cast<Object>(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            _getUserData();
                          } else {
                            return const Text('No Data');
                          }
                          return Text(
                            _username,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          );

  
                        }),
                  ),
                ],
              ),
            ),
            ListTileDrawer(
              title: 'الصفحه الشخصيه',
              icon: const Icon(Icons.person),
              onTap: () {
                Navigator.pushNamed(context, UserProfilePage.id);
              },
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
              title: 'المسبحه',
              icon: const Icon(FlutterIslamicIcons.tasbih),
              onTap: () {
                Navigator.pushNamed(context, TasbihPage.id);
              },
            ),
            ListTileDrawer(
              title: 'المساعدة',
              icon: const Icon(Icons.help_center_outlined),
              onTap: () {
                Navigator.pushNamed(context, EmergencyPage.id);
              },
            ),
            ListTileDrawer(
              title: 'تسجيل خروج',
              icon: const Icon(Icons.logout),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.id, (route) => false);
              },
            ),
          ],
        )),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              label: 'الصفحة الرئيسية',
              icon: Icon(Icons.home),
            ),
            NavigationDestination(
              label: 'الادعيه ',
              icon: Icon(FlutterIslamicIcons.takbir),
            ),
            NavigationDestination(
              label: 'المناسك ',
              icon: Icon(FlutterIslamicIcons.kaaba),
            ),
            NavigationDestination(
              label: 'رؤيه الاماكن المقدسه',
              icon: Icon(FlutterIslamicIcons.qibla),
            ),
          ],
        ),
        body: <Widget>[
          const HomeBody(),
          const DoaaBody(),
          const MnaskBody(),
          const PlaceBody(),
        ][currentPageIndex]);
  }
}
