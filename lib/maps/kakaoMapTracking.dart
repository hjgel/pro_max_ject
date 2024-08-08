import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(TestApp());

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: LocationPage(),);
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {

  final webViewController= WebViewController();
  final url = 'https://172.30.1.30:3000/kakao/map';
  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    this.webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(this.url))
          .then((value) => run());
    super.initState();
  }

  void run() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Future.error('Location services are disabled.');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) throw Future.error('Location permissions are denied');
    }
    if (permission == LocationPermission.deniedForever) throw Future.error('Location permissions are permanently denied, we cannot request permissions.');
    final LocationSettings locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 5,);
    this.positionStream = Geolocator
        .getPositionStream(locationSettings: locationSettings)
        .listen(
            (Position? position) {
          if(position == null) return;
          final Position(latitude:lat, longitude:long) = position;
          this.webViewController.runJavaScript("run(${lat},${long})");
        }
    );
  }

  @override
  void dispose() {
    this.webViewController.clearCache();
    this.positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("사용자 위치 추적"),),
    body: WebViewWidget(
      controller: this.webViewController,
    ),
  );
}