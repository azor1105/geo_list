import 'dart:io';
import 'package:dio/dio.dart';
import 'package:geo_list/constants/yandex_map_constants.dart';

class OpenApiServices {
  final Dio _dio = Dio();

  Future<String> getAddressFromYandexMap(
      {required double lat, required double long}) async {
    String geoCode = "$long,$lat";

    try {
      Response response = await _dio.get(
        YandexMapConstants.instance.baseUrl,
        queryParameters: {
          "apikey": YandexMapConstants.instance.apiKey,
          "geocode": geoCode,
          "format": "json",
          "kind": "house",
          "rspn": 1,
          "results": 1,
          "lang": YandexMapConstants.instance.lang,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.data['response']["GeoObjectCollection"]["featureMember"]
            [0]["GeoObject"]['description'];
      } else {
        return "";
      }
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
