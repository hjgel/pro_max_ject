import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/shelter_map_provider.dart';
import '../models/disaster_message.dart'; // 모델 파일 경로를 올바르게 지정
import 'package:intl/intl.dart';

import '../models/shelter_map.dart'; // 날짜 포맷팅 패키지

Future<List<Shelter_map>> fetchShelterMapProviderFromApi(String regionName) async {
  final String serviceKey = '1zYB%2FngXg5IA4xJz%2BXAziZjZlw%2Bo6pN6WWO4KF%2B%2B6oErmu9bJO9K1%2BAswpzHAAVwLUVNVwLSSLRSLygVXORA9w%3D%3D'; // 서비스키

  // 현재 날짜와 2일 전 날짜 계산
  final now = DateTime.now();
  final twoDaysAgo = now.subtract(Duration(days: 2));

  // 날짜를 'YYYYMMDD' 형식으로 변환
  final DateFormat formatter = DateFormat('yyyyMMdd');
  final String endDate = formatter.format(now);
  final String crtDt = formatter.format(twoDaysAgo);

  // URL 쿼리 파라미터에 날짜 추가
  final String url = 'http://apis.data.go.kr/1741000/EmergencyAssemblyArea_Earthquake5?serviceKey=$serviceKey&crtDt=$crtDt&rgnNm=$regionName';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);  // UTF-8로 디코딩
      final Map<String, dynamic> data = jsonDecode(responseBody);
      print('API Response Data: $data');  // 응답 데이터 로그

      // 'body'가 리스트 형태가 아니라면 적절히 수정
      final List<dynamic> items = data['body'] ?? [];
      print('Fetched items:');
      for (var item in items) {
        // 각 item이 JSON 객체인지 확인 후 변환
        final shelter = Shelter_map.fromJson(item);
        print('ctprvn_nm: ${shelter.ctprvn_nm}');
        print('sgg_nm: ${shelter.sgg_nm}');
        print('vt_acmdfclty_nm: ${shelter.vt_acmdfclty_nm}');
        print('rdnmadr_cd: ${shelter.rdnmadr_cd}');
        print('xcord: ${shelter.xcord}');
        print('ycord: ${shelter.ycord}');
        print('acmdfclty_se_nm: ${shelter.acmdfclty_se_nm}');
        print('acmdfclty_se_nm: ${shelter.acmdfclty_se_nm}');
      }

      return items.map((json) => Shelter_map.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
