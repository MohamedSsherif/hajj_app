import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hajj_app/constants.dart';
import 'package:hajj_app/helpers/read_ayat_forhomebody.dart';
import 'package:hajj_app/views/azkar_page.dart';
import 'package:hajj_app/views/prayer_time.dart';
import 'package:hajj_app/views/quibla.dart';
import 'package:hajj_app/widgets/List_title_drawer.dart';
import 'package:hajj_app/widgets/container_for_next_prayer_home_body.dart';
import 'package:hajj_app/widgets/container_for_zeham.dart';

class HomeBody extends StatefulWidget {
  static const String id = 'home_body';
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
                children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set container width to match the screen width
              height: MediaQuery.of(context).size.height *
                  0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/zeham3.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80,bottom: 25,right: 60),
                    child: Text(
                      'تنبؤات حالات الزحام ',
                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomContainerForZeham(
                    text1: 'الصحن ',
                    text2: 'خفيف ',
                  ),
                   CustomContainerForZeham(
                    text1: 'الصحن ',
                    text2: 'خفيف ',
                  ),
                   CustomContainerForZeham(
                    text1: 'الصحن ',
                    text2: 'خفيف ',
                  ),
                   CustomContainerForZeham(
                    text1: 'الصحن ',
                    text2: 'خفيف ',
                  ),
                ],
              ),
            ),
          ),
          ReadAyatForHomeBody(path: 'assets/json/ayat.json'),
      
          SizedBox(
            height: 10,
          ),
          CustomContainer(image: 'assets/images/NextPrayer2.jpg',text: '~الصلاه القادمهّ~',prayerName: 'العصر',remainingTime: 'الوقت المتبقي 2:30',text2: ' اضغط هنا لمعرفه مواقيت الصلاه' ),
          const SizedBox(
            width: 5,
          )
                ],
              ),
        ));
  }
}
