class YandexMapConstants {
  YandexMapConstants._init();
  static final YandexMapConstants _instance = YandexMapConstants._init();
  static YandexMapConstants get instance => _instance;

  String baseUrl = "https://geocode-maps.yandex.ru/1.x";

  String apiKey = "05e0e6fb-55b6-4a64-a6c0-2d2641e1e051";
  String lang = "uz_UZ";
}
