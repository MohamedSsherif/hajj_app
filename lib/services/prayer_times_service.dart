import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pray_times/pray_times.dart';

class PrayerTimeService {
  static PrayerTimeService? _instance;

  static PrayerTimeService get instance {
    _instance ??= PrayerTimeService();
    return _instance!;
  }

  List<String> prayerTimes = [];
  Future getPrayersTimes() async {
    await _determinePosition().then((pos) {
      PrayerTimes pray = PrayerTimes();
      pray.setTimeFormat(pray.Time12);
      pray.setCalcMethod(pray.MWL);
      pray.setAsrJuristic(pray.Shafii);
      pray.setAdjustHighLats(pray.AngleBased);
      // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
      var offsets = [0, 0, 0, 0, 0, 0, 0];
      pray.tune(offsets);
      final date = DateTime.now();
      // final date = DateTime(2023, DateTime.january, 20);
      prayerTimes = pray.getPrayerTimes(date, pos.latitude, pos.longitude, 3);
    }, onError: (e) {
      debugPrint(e.toString());
    });
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

class MyLocation {
  final double lat;
  final double lng;

  const MyLocation({required this.lat, required this.lng});
}
