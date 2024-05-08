import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomContainerForZeham extends StatelessWidget {
   CustomContainerForZeham({super.key, required this.text1, required this.text2});
String text1;
String text2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Container(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text2,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
              Expanded(
             child: LinearPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        width: MediaQuery.of(context).size.width * 0.25,
                        lineHeight: 5.0,
                        percent: 0.4 ,
                        //center: Text("100%"),
                        progressColor: Color(0xff56A8A9),
                      ),
            ),
            Text(
              text1,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
