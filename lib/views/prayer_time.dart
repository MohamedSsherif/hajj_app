import 'package:flutter/material.dart';
import 'package:hajj_app/constants.dart';
import 'package:hajj_app/widgets/card_for_prayer_time.dart';

class PrayerTimePage extends StatelessWidget {
  const PrayerTimePage({super.key});
  static String id = 'PrayerTimePage';

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
        appBar: AppBar(
          title: Text('أوقات الصلاة'),
          centerTitle: true,
          backgroundColor: KPrimaryColor,
        ),
            body:
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/maxresdefault.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CardPrayerTime(
                    prayerName: 'الفجر',
                    prayerTime: '5',
                  ),
                  CardPrayerTime(
                    prayerName: 'الظهر',
                    prayerTime: '6',
                  ),
                  CardPrayerTime(
                    prayerName: 'العصر',
                    prayerTime: '7',
                  ),
                  CardPrayerTime(
                    prayerName: 'المغرب',
                    prayerTime: '8',
                  ),
                  CardPrayerTime(
                    prayerName: 'العشاء',
                    prayerTime: '9',
                  ),
                ],
              ),
            ),
    );
  
          
    
  }
}
