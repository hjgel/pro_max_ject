import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:location/location.dart';

void main() {
  runApp(SosWidget());
}

class SosWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SosPage(),
    );
  }
}

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  _SosPageState createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  double lat = 0;
  double lng = 0;
  Location location = Location();
  Set<Marker> markers = {};
  late KakaoMapController mapController;

  @override
  void initState() {
    super.initState();
    _locateMe();
  }

  Future<void> _locateMe() async {
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    setState(() {
      lat = locationData.latitude!;
      lng = locationData.longitude!;
      LatLng currentLatLng = LatLng(lat, lng);

      markers.add(
        Marker(
          markerId: UniqueKey().toString(),
          latLng: currentLatLng,
        ),
      );

      if (mapController != null) {
        mapController.setCenter(currentLatLng);
      }
    });
  }


  int _selectedIndex = 0; // 현재 선택된 인덱스

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 업데이트
    });
  }

  void _onMedicalInfoTapped() {
    // 여기에 버튼 클릭 시 실행될 동작을 정의합니다.
    print('Medical info button tapped');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SOS',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BM_HANNA_TTF',
          ),
        ),

        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.account_box, color: Colors.white),
        //     onPressed: () {
        //       // Handle notification action
        //     },
        //   ),
        // ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF5A4C), // FF5A4C
                Color(0xFFFFA55F), // FFA55F
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: KakaoMap(
                  onMapCreated: (controller) {
                    mapController = controller;

                    // 지도 생성 후 현재 위치 가져오기
                    _locateMe();
                  },
                  markers: markers.toList(),
                  center: LatLng(lat, lng), // 초기 위치는 현재 위치

                ),
              ),
              Container(
                width: double.infinity,
                height: 99,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, -4), // 그림자
                    )
                  ],
                ),
              ),
            ],
          ),

          //////////////    sos 버튼   /////////////////
          Positioned(
            bottom: 45, // 하얀 박스 위에 조금 겹치도록 조정
            left: MediaQuery.of(context).size.width / 2 - 65.5, // 버튼을 중앙에 배치
            child: Group78(),
          ),

          // 흰색 작은 박스 (의료정보 버튼)
          Positioned(
            bottom: 10, // sos 버튼 밑으로 조정
            left: MediaQuery.of(context).size.width / 2 - 57, // 중앙 정렬
            child: GestureDetector(
              onTap: _onMedicalInfoTapped,
              child: Container(
                width: 114,
                height: 31,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.50),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 2,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    '* 의료정보',
                    style: TextStyle(
                        color: Color(0xFFD32E24),
                        fontSize: 15,
                        fontFamily: "BM_HANNA_TTF"
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Group78 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 131,
      height: 130,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 131,
              height: 130,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 5.0,
                      offset: Offset(0, -4),
                    )
                  ]),
            ),
          ),
          Positioned(
            left: 11,
            top: 10,
            child: Container(
              width: 109,
              height: 109,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 109,
                      height: 109,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF5F5FA),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 13.63,
                    top: 13.63,
                    child: Container(
                      width: 81.75,
                      height: 81.75,
                      decoration: ShapeDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0, 1),
                          radius: 0,
                          colors: [Color(0xFFFFAD59), Color(0xFFFF7E7B)],
                        ),
                        shape: OvalBorder(),
                        shadows: [
                          BoxShadow(
                            color: Color(0xFFFFFFFF),
                            blurRadius: 47.37,
                            offset: Offset(-23.68, -23.68),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x7FAAAACC),
                            blurRadius: 47.37,
                            offset: Offset(23.68, 23.68),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x3FAAAACC),
                            blurRadius: 23.68,
                            offset: Offset(11.84, 11.84),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x7FFFFFFF),
                            blurRadius: 23.68,
                            offset: Offset(-11.84, -11.84),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


