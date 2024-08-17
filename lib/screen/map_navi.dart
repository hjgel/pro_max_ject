import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const Map_naviPage());
}

class Map_naviPage extends StatelessWidget {
  const Map_naviPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const TestView(),
    );
  }
}

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  double lat = 0;
  double lng = 0;
  Set<Marker> markers = {}; // 마커 변수


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F0), // 전체 배경 컬러
      appBar: AppBar(
        title: const Text(
          '이재난녕',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),
        backgroundColor: const Color(0xEF537052),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // 알림 버튼 클릭 시 동작

            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool isKakaoNaviInstalled = await NaviApi.instance.isKakaoNaviInstalled();

            if (isKakaoNaviInstalled) {
              await NaviApi.instance.navigate(
                destination: Location(
                  name: '카카오 판교오피스',
                  x: '127.108640',
                  y: '37.402056',
                ),
                option: NaviOption(
                  coordType: CoordType.wgs84,
                ),
              );
            } else {
              // 카카오내비 앱이 설치되지 않은 경우 설치 페이지로 이동
              final uri = Uri.parse(NaviApi.webNaviInstall);
              if (await canLaunch(uri.toString())) {
                await launch(uri.toString());
              } else {
                throw 'Could not launch $uri';
              }
            }
          },
          child: const Text('카카오내비 실행'),
        ),
      ),
    );
  }
}
