import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class Shelter_map {
  final String? ctprvn_nm; // 시도명
  final String? sgg_nm; // 시군구명
  final String? vt_acmdfclty_nm; // 시설명
  final String? rdnmadr_cd; // 도로명 주소 코드.
  final String? xcord; // 경도
  final String? ycord; // 위도
  final String? acmdfclty_se_nm; // 지진옥외대피장소 유형 구분
  final String? rn_adres; // 도로명 주소
  final String? pageNo;
  final String? numOfRows;
  final String? type;

  // 생성자
  Shelter_map({
    required this.ctprvn_nm,
    required this.sgg_nm,
    required this.vt_acmdfclty_nm,
    required this.rdnmadr_cd,
    required this.xcord,
    required this.ycord,
    required this.acmdfclty_se_nm,
    required this.rn_adres,
    required this.pageNo,
    required this.numOfRows,
    required this.type,
  });

  factory Shelter_map.fromXml(XmlElement xml) {
    // 헬퍼 함수 정의
    String? getValue(String tag) {
      final element = xml.findElements(tag).firstWhere(
        // 요소들 중 첫 번째로 innerText가 비어있지 않은 요소 찾기
              (e) => e.innerText.isNotEmpty, // 요소의 내용이 비어있지 않은지 확인
          orElse: () => XmlElement(XmlName(tag))); // 요소를 찾지 못하면 빈 요소를 반환
      return element.innerText.isNotEmpty
          ? element.innerText
          : null; // 요소의 내용이 비어있지 않으면 내용을 반환. 그렇지 않으면 null 반호
    }
    return Shelter_map(
      ctprvn_nm: getValue("ctpvn_nm"),
      sgg_nm: getValue("sgg_nm"),
      vt_acmdfclty_nm: getValue("vt_acmdfclty_nm"),
      rdnmadr_cd: getValue("rdnmadr_cd"),
      xcord: getValue("xcord"),
      ycord: getValue("ycord"),
      acmdfclty_se_nm: getValue("acmdfcity_se_nm"),
      rn_adres: getValue("rn_adres"),
      pageNo : getValue("pageNo"),
      numOfRows : getValue("numOfRows"),
      type : getValue("type"),
    );
  }
}
 

 /// User 객체를 JSON으로 변환
 // Map<String, dynamic> toJson() {
 //   return {
 //     'ctprvn_nm': ctprvn_nm,
 //     'sgg_nm': sgg_nm,
 //     'vt_acmdfclty_nm': vt_acmdfclty_nm,
 //     'rdnmadr_cd' : rdnmadr_cd,
 //     'xcord' : xcord,
 //     'ycord' : ycord,
 //     'acmdfclty_se_nm' : acmdfclty_se_nm,
 //     'rn_adres' : rn_adres,
 //   };
 // }

 /// JSON을 User 객체로 변환
 // factory Shelter_map.fromJson(Map<String, dynamic> json) {
 //   return Shelter_map(
 //     ctprvn_nm: json['ctprvn_nm'] ?? " ",
 //     sgg_nm: json['sgg_nm'] ?? " ",
 //     vt_acmdfclty_nm: json['vt_acmdfclty_nm'] ?? " ",
 //     rdnmadr_cd: json['rdnmadr_cd'] ?? " ",
 //     xcord: json['xcord'] ?? " ",
 //     ycord: json['ycord'] ?? " ",
 //     acmdfclty_se_nm: json['acmdfclty_se_nm'] ?? " ",
 //     rn_adres: json['rn_adres'] ?? " ",
 //   );
 // }
//   @override
//   String toString() {
//     return 'Shelter_map(ctprvn_nm: $ctprvn_nm, sgg_nm : $sgg_nm, vt_acmdfclty_nm : $vt_acmdfclty_nm, rdmadr_cd : $rdnmadr_cd, xcord : $xcord, ycord : $ycord, acmdfclty_se_nm : $acmdfclty_se_nm, rn_adres : $rn_adres';
//   }
// }