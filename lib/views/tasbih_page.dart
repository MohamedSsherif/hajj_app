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
    return Scaffold(
      body: BackgroundWithCounter(),
    );
  }
}

class BackgroundWithCounter extends StatefulWidget {
  @override
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
        title: Text('التسبيح ', style: TextStyle(color: Colors.black, fontSize: 24),),
        centerTitle: true,
        backgroundColor: Color(0xff51B1E3),
        
        
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
                    style: ButtonStyle(),
                    onPressed: _resetCounter,
                    child: Text('Reset'),
                  ),
                  Text(
                    'Loop $_loops',
                    style: TextStyle(color: Colors.black),
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
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _incrementCounter,
                        child: Text('Tap here to begin tasbih'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                        ),
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