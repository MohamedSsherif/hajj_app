import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class CardPrayerTime extends StatelessWidget {
   CardPrayerTime({super.key,required this.prayerName,required this.prayerTime,required this.prayerIcon});
String prayerName;
String prayerTime;
IconData prayerIcon;
  @override
  Widget build(BuildContext context) {

    return Container(
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 50,
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Card(
          color: Colors.white,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(prayerIcon, color: Colors.orange, size: 35),
                  ),
               
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Column(
                      children: [
                        Text(
                          prayerName,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          prayerTime,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}