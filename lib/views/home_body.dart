import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  static const String id = 'home_body';
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
          child: Text('Home Body'),
        )
    );
  }
}