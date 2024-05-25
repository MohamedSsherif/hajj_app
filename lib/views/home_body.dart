import 'package:flutter/material.dart';
import 'package:hajj_app/helpers/read_ayat_forhomebody.dart';
import 'package:hajj_app/services/prayer_times_service.dart';
import 'package:hajj_app/widgets/container_for_next_prayer_home_body.dart';
import 'package:hajj_app/widgets/container_for_zeham.dart';

class HomeBody extends StatefulWidget {
  static const String id = 'home_body';
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late PrayerTimeService prayerTimeService;

  @override
  void initState() {
    super.initState();
    prayerTimeService = PrayerTimeService.instance;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/zeham3.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 80, bottom: 25, right: 60),
                      child: Text(
                        'تنبؤات حالات الزحام ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    CustomContainerForZeham(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 1),
            const ReadAyatForHomeBody(path: 'assets/json/ayat.json'),
            const SizedBox(height: 1),
            FutureBuilder(
                  future: prayerTimeService.getCurrentPrayerTime(),
                  builder: (context, snapshot) => CustomContainer(
                      image: 'assets/images/NextPrayer2.jpg',
                      text: '~الصلاه القادمهّ~',
                      // prayerName: 'العصر',
                      prayerName: snapshot.hasData
                          ? snapshot.data?.name ?? ""
                          : "",
                      remainingTime: 'الوقت المتبقي ${snapshot.data?.timeDifference}',
                       text2: ' اضغط هنا لمعرفه مواقيت الصلاه'),
           ),
            const SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 15),
  //           child: Container(
  //             width: MediaQuery.of(context)
  //                 .size
  //                 .width, // Set container width to match the screen width
  //             // height: MediaQuery.of(context).size.height * 0.3,
  //             decoration: const BoxDecoration(
  //               image: DecorationImage(
  //                 image: AssetImage('assets/images/zeham3.jpg'),
  //                 fit: BoxFit.fill,
  //               ),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 SizedBox(height: MediaQuery.of(context).size.height * .1),
  //                 const Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 25),
  //                   child: Text(
  //                     'تنبؤات حالات الزحام ',
  //                     style: TextStyle(
  //                         fontSize: 20,
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //                 CustomContainerForZeham(),
                
  //               ],
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         const ReadAyatForHomeBody(path: 'assets/json/ayat.json'),
  //         const SizedBox(height: 10),
  //          FutureBuilder(
  //                 future: prayerTimeService.getCurrentPrayerTime(),
  //                 builder: (context, snapshot) => CustomContainer(
  //                     image: 'assets/images/NextPrayer2.jpg',
  //                     text: '~الصلاه القادمهّ~',
  //                     // prayerName: 'العصر',
  //                     prayerName: snapshot.hasData
  //                         ? snapshot.data?.name ?? ""
  //                         : "",
  //                     remainingTime: 'الوقت المتبقي ${snapshot.data?.timeDifference}',
  //                     text2: ' اضغط هنا لمعرفه مواقيت الصلاه'),
  //               ),
  //             // : CustomContainer(
  //             //     image: 'assets/images/NextPrayer2.jpg',
  //             //     text: '~الصلاه القادمهّ~',
  //             //     // prayerName: 'العصر',
  //             //     prayerName: prayerTimeService.prayerTimes[0],
  //             //     remainingTime: 'الوقت المتبقي 2:30',
  //             //     text2: ' اضغط هنا لمعرفه مواقيت الصلاه'),
  //         const SizedBox(
  //           width: 5,
  //         )
  //       ],
  //     ),
  //   ));
  // }
}
