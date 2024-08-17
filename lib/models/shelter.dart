import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import '../utils/xml_utils.dart';

void main() {

}

class Shelter {
  String? ctprvn_nm; // 시도명
  String? sgg_nm; // 시군구명
  String? vt_acmdfclty_nm; // 시설명
  String? rdnmadr_cd; // 도로명 주소 코드.
  String? xcord; // 경도
  String? ycord; // 위도
  String? acmdfclty_se_nm; // 지진옥외대피장소 유형 구분
  String? rn_adres; // 도로명 주소
  // 생성자
  Shelter({
    this.ctprvn_nm,
    this.sgg_nm,
    this.vt_acmdfclty_nm,
    this.rdnmadr_cd,
    this.xcord,
    this.ycord,
    this.acmdfclty_se_nm,
    this.rn_adres,
  });

  factory Shelter.fromXml(XmlElement xml){
    return Shelter(
      ctprvn_nm: XmlUtils.searchResult(xml, 'ctprvn_nm'),
      sgg_nm: XmlUtils.searchResult(xml, 'sgg_nm'),
      vt_acmdfclty_nm: XmlUtils.searchResult(xml, 'vt_acmdfclty_nm'),
      rdnmadr_cd: XmlUtils.searchResult(xml, 'rdnmadr_cd'),
      xcord:XmlUtils.searchResult(xml, 'xcord'),
      ycord:XmlUtils.searchResult(xml, 'ycord'),
      acmdfclty_se_nm: XmlUtils.searchResult(xml, 'acmdfclty_se_nm'),
      rn_adres: XmlUtils.searchResult(xml, 'rn_adres'),
    );
  }

// @override
// String toString() {
//   return 'Shelter_map(ctprvn_nm: $ctprvn_nm, sgg_nm : $sgg_nm, vt_acmdfclty_nm : $vt_acmdfclty_nm, rdmadr_cd : $rdnmadr_cd, xcord : $xcord, ycord : $ycord, acmdfclty_se_nm : $acmdfclty_se_nm, rn_adres : $rn_adres';
// }
}
