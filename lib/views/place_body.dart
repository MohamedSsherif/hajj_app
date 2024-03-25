import 'package:flutter/material.dart';

class PlaceBody extends StatelessWidget {
  static const String id = 'place_body';
  const PlaceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text('Place Body'),
        )
    );
  }
}