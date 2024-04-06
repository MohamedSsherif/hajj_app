// import 'dart:async';

// import 'package:flutter/services.dart';

// class VideoPlayer360 {
//   static const MethodChannel _channel =
//       const MethodChannel('innov.lab/video_player_360');

//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }

//   ///
//   /// Set spherical mesh for the texture. The mesh does not have be closed.
//   ///
//   /// @param radius Size of the sphere in meters. Must be > 0.
//   /// @param verticalFov Total latitudinal degrees that are covered by the sphere. Must be in (0, 180].
//   /// @param horizontalFov Total longitudinal degrees that are covered by the sphere.Must be in (0, 360].
//   /// @param rows Number of rows that make up the sphere. Must be >= 1.
//   /// @param columns Number of columns that make up the sphere. Must be >= 1.
//   ///

//   static Future<Future<Map?>> playVideoURL(
//     String url, {
//     int radius = 50,
//     int verticalFov = 180,
//     int horizontalFov = 360,
//     int rows = 50,
//     int columns = 50,
//     bool showPlaceholder = false,
//   }) async {
//     return _channel.invokeMapMethod("playvideo", <String, dynamic>{
//       'video_url': url,
//       'radius': radius,
//       'verticalFov': verticalFov,
//       'horizontalFov': horizontalFov,
//       'rows': rows,
//       'columns': columns,
//       'showPlaceholder': showPlaceholder,
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:video_360/video_360.dart';

class View360 extends StatefulWidget {
  const View360({Key? key}) : super(key: key);

  @override
  State<View360> createState() => _View360State();
}

class _View360State extends State<View360> {
  late Video360Controller controller;
  String durationText = '';
  String totalText = '';
  @override
  Widget build(BuildContext context) {
    var statusBar = MediaQuery.of(context).padding.top;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: width,
              height: height,
              child: Video360View(
                onVideo360ViewCreated: _onVideo360ViewCreated,
                url:
              
                    'https://codetricity.github.io/flutter_video_display/ageda.MP4',
                onPlayInfo: (Video360PlayInfo info) {
                  setState(() {
                    durationText = info.duration.toString();
                    totalText = info.total.toString();
                  });
                },
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      controller.play();
                    },
                    color: Colors.grey[100],
                    child: Text('Play'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.stop();
                    },
                    color: Colors.grey[100],
                    child: Text('Stop'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.reset();
                    },
                    color: Colors.grey[100],
                    child: Text('Reset'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _onVideo360ViewCreated(Video360Controller controller) {
    this.controller = controller;
  }
}