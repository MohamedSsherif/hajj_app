import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hajj_app/constants.dart';

import 'package:hajj_app/widgets/card_for_prayer_time.dart';
import 'package:intl/intl.dart';

class PrayerTimePage extends StatefulWidget {
  static String id = 'PrayerTimePage';
  final String? nextPrayer;
  final Duration? timeRemaining;

  const PrayerTimePage({super.key, this.nextPrayer, this.timeRemaining});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  final prayers = {
    "الفجر": "04:38",
    "الضهر": "12:53",
    "العصر": "16:29",
    "المغرب": "19:51",
    "العشاء": "21:07",
    "الفجر": "04:38",
  };
  String nextPrayer = '';
  late Timer _timer;
  late Duration _currentTimeRemaining;

  @override
  void initState() {
    super.initState();
    _calculateNextPrayer();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTimeRemaining.inSeconds > 0) {
          _currentTimeRemaining -= const Duration(seconds: 1);
        } else {
          _calculateNextPrayer();
        }
      });
    });
  }

  List<MapEntry<String, DateTime>>? prayerTimes;
  void _calculateNextPrayer() {
    DateTime now = DateTime.now().toUtc();

    // Convert prayer times to DateTime objects
    prayerTimes = prayers.entries.map((entry) {
      DateTime prayerTime = DateFormat("HH:mm").parse(entry.value);
      // Set prayer time to today's date
      return MapEntry(
        entry.key,
        DateTime(
          now.year,
          now.month,
          now.day,
          prayerTime.hour,
          prayerTime.minute,
        ),
      );
    }).toList();

    // Sort prayer times in ascending order
    prayerTimes!.sort((a, b) => a.value.compareTo(b.value));

    // Find the next prayer time
    DateTime? nextPrayerTime;
    String? nextPrayerName;
    for (var entry in prayerTimes!) {
      if (entry.value.isAfter(now)) {
        nextPrayerTime = entry.value;
        nextPrayerName = entry.key;
        break;
      }
    }

    // If no next prayer time is found, it means the next prayer is Fajr of the next day
    if (nextPrayerTime == null) {
      nextPrayerTime = prayerTimes!.first.value.add(const Duration(days: 1));
      nextPrayerName = prayerTimes!.first.key;
    }

    setState(() {
      nextPrayer = nextPrayerName!;
      _currentTimeRemaining = nextPrayerTime!.difference(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أوقات الصلاة',
          style: const TextStyle(color: KTextWhite),
        ),
        centerTitle: true,
        backgroundColor: KPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: prayers == null
            ? Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: const CircularProgressIndicator(
                  color: KTextBrown,
                ),
              )
            : CardPrayerTime(
                prayerTimes: prayers,
                nextPrayer: nextPrayer,
                timeRemaining: _currentTimeRemaining,
              ),
      ),
    );
  }
}
