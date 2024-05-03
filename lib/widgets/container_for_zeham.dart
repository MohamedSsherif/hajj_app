import 'package:flutter/material.dart';

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
              child: Divider(
                color: Colors.red,
                thickness: 3,
                indent: 20.0,
                endIndent: 20.0,
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
