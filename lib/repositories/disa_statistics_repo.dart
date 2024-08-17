import 'package:dio/dio.dart';
import 'package:pro_max_ject/models/shelter.dart';
import 'package:xml/xml.dart';

class Disa_statistics_repository {
  late var _dio;
  Disa_statistics_repository() {
    _dio = Dio(
      BaseOptions(baseUrl: "http://apis.data.go.kr", queryParameters: {'ServiceKey' : '1zYB/ngXg5IA4xJz+XAziZjZlw+o6pN6WWO4KF++6oErmu9bJO9K1+AswpzHAAVwLUVNVwLSSLRSLygVXORA9w=='}),
    );
  }
  Future<Shelter> fetchDisaStatistics() async {
    var response = await _dio.get("http://apis.data.go.kr/1741000/EmergencyAssemblyArea_Earthquake5");
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');
    if (results.isNotEmpty) {
      return Shelter.fromXml(results.first);
    } else {
      return Future.value(null);
    }

  }
}