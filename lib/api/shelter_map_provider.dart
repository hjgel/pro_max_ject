import 'package:flutter/material.dart';
import '../models/disaster_message.dart';
import '../models/shelter_map.dart';
import '../services/disaster_service.dart'; // API 호출 서비스
import '../services/location_service.dart';
import '../services/shelter_service.dart'; // 위치 서비스

class ShelterMapProvider with ChangeNotifier {
  List<Shelter_map> _shelterMapService = [];
  bool _isLoading = false; // 로딩 상태를 추적하기 위한 변수
  final LocationService _locationService = LocationService(); // 위치 서비스 인스턴스

  List<Shelter_map> get shelterMapService => _shelterMapService;
  bool get isLoading => _isLoading;

  // 데이터를 로드하고 상태를 업데이트하는 메서드
  Future<void> loadShelterMapService() async {
    if (_isLoading) return; // 이미 로딩 중이면 중복 호출 방지

    _isLoading = true; // 로딩 시작
    // notifyListeners()를 빌드 완료 후 호출하기 위해 PostFrameCallback 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      final locationData = await _locationService.getCurrentLocation();
      if (locationData != null) {
        print('Current location: Latitude ${locationData.latitude}, Longitude ${locationData.longitude}');

        final addressData = await _locationService.getAddressFromCoordinates(
          locationData.latitude!,
          locationData.longitude!,
        );

        if (addressData != null) {
          final regionName = addressData['region1']; // 지역명 추출
          print('Region name: $regionName');

          if (regionName != null) {
            final List<Shelter_map> messages = await fetchShelterMapProviderFromApi(
              regionName,  // API 호출 시 필요한 파라미터로 전달
            );
            print('Fetched messages: $messages'); // 로그로 메시지 확인
            _shelterMapService = messages;
          } else {
            print('Failed to get region name');
          }
        } else {
          print('Failed to get address data');
        }
      } else {
        print('Failed to get location');
      }
    } catch (e) {
      print('Error in loadDisasterMessages: $e');
    } finally {
      _isLoading = false; // 로딩 완료
      // notifyListeners()를 빌드 완료 후 호출하기 위해 PostFrameCallback 사용
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  // 데이터를 비우고 상태를 리셋하는 메서드
  void clearShelterMapService() {
    _shelterMapService.clear();
    notifyListeners();
  }
}
