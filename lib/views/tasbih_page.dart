import 'package:flutter/material.dart';

class TasbihPage extends StatefulWidget {
  static const String id = 'TasbihPage';
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundWithCounter(),
    );
  }
}

class BackgroundWithCounter extends StatefulWidget {
  const BackgroundWithCounter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BackgroundWithCounterState createState() => _BackgroundWithCounterState();
}

class _BackgroundWithCounterState extends State<BackgroundWithCounter> {
  int _counter = 0;
  int _loops = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter % 99 == 0) {
        _loops++;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _loops = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('التسبيح ', style: TextStyle(color: Colors.black, fontSize: 24),),
        centerTitle: true,
        backgroundColor: const Color(0xff51B1E3),
        
        
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/HD-wallpaper-ramadan-mosque.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: _resetCounter,
                    child: const Text('Reset'),
                  ),
                  Text(
                    'Loop $_loops',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 12,
                ),
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          '$_counter',
                          style: const TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _incrementCounter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Tap here to begin tasbih'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}