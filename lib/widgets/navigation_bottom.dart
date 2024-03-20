import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hajj_app/views/home_page.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({super.key});

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
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
            icon:  Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'الادعيه ',
            icon:  Icon(FlutterIslamicIcons.takbir),
          ),
          NavigationDestination(
            label: 'المناسك ',
            icon:  Icon(FlutterIslamicIcons.kaaba),
          ),
          NavigationDestination(
            label: 'رؤيه الاماكن المقدسه',
            icon:  Icon(FlutterIslamicIcons.qibla),
          ),
        ],
      ),

      //  body: <Widget>[
      //     const HomePage(),
      //     // const PrayerTimes(),
      //     // const QiblaDirection()
      //  ][currentPageIndex],
    );
  }
}
