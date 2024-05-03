import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hajj_app/constants.dart';
import 'package:hajj_app/widgets/card_for_prayer_time.dart';
import 'package:pray_times/pray_times.dart';


// double lat= GetLocation.lat, lng = GetLocation.lng;
class PrayerTimePage extends StatefulWidget {
  static String id = 'PrayerTimePage';

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {

  static List<String> prayerTimes = [];

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    try {
      final position = await _determinePosition();
      // final latitude = position.latitude;
      // final longitude = position.longitude;
      final latitude = 30.033333;
      final longitude = 31.233334;
      const timzone = 3.0;

      List<String> prtimes = prayTimeZone(latitude, longitude, timzone);

      setState(() {
        prayerTimes = prtimes;
      });
    } catch (e) {
      // Handle error
      print('Error fetching prayer times: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (prayerTimes.isNotEmpty){
    return Scaffold(
      appBar: AppBar(
        title: Text('أوقات الصلاة'),
        centerTitle: true,
        backgroundColor: KPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (prayerTimes.isNotEmpty)
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
            const SizedBox(
              height: 10,
            ),
            CardPrayerTime(
              prayerName: 'الفجر',
              prayerTime: prayerTimes[0],
              prayerIcon: CupertinoIcons.moon_stars,
            ),
            CardPrayerTime(
              prayerName: 'الظهر',
              prayerTime: prayerTimes[2],
              prayerIcon: CupertinoIcons.sun_min,
            ),
            CardPrayerTime(
              prayerName: 'العصر',
              prayerTime: prayerTimes[3],
              prayerIcon: CupertinoIcons.sun_haze,
            ),
            CardPrayerTime(
              prayerName: 'المغرب',
              prayerTime: prayerTimes[5],
              prayerIcon: CupertinoIcons.sunset,
            ),
            CardPrayerTime(
              prayerName: 'العشاء',
              prayerTime: prayerTimes[6],
              prayerIcon: CupertinoIcons.moon,
            ),
            
          ],
        ),
      ),
    );
    } else{
        return Scaffold(
      appBar: AppBar(
        title: Text('أوقات الصلاة'),
        centerTitle: true,
        backgroundColor: KPrimaryColor,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator()
            ),
        ],
      ),
      );
    }
  }

  List<String> prayTimeZone (double latitude, double longitude, double timezone){
    PrayerTimes pray = PrayerTimes();
    pray.setTimeFormat(pray.Time12);
    pray.setCalcMethod(pray.MWL);
    pray.setAsrJuristic(pray.Shafii);
    pray.setAdjustHighLats(pray.AngleBased);
    // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
    var offsets = [0, 0, 0, 0, 0, 0, 0];
    pray.tune(offsets);
    final date = DateTime.now()!;
    // final date = DateTime(2023, DateTime.january, 20);
    List<String> prayerTimes =
        pray.getPrayerTimes(date, latitude, longitude, timezone);
    List<String> prayerNames = pray.getTimeNames();
    return prayerTimes;
    }



Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
  return await Geolocator.getCurrentPosition();
}
}
