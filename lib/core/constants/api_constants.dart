class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://pixabay.com/api/';

  static const String apiKey = String.fromEnvironment(
    'PIXABAY_API_KEY',
  );

  static const int perPage = 30;
}