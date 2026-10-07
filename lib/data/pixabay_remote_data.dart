import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';

import '../error/app_exception.dart';
import '../models/pixabay_response.dart';

class PixabayRemoteDataSource {
  final Dio dio;

  PixabayRemoteDataSource(this.dio);

  Future<PixabayResponse> searchImages({
    required int page,
    String query = '',
    String? category,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.baseUrl,
        queryParameters: {
          'key': ApiConstants.apiKey,

          // Search text
          if (query.trim().isNotEmpty)
            'q': query.trim(),

          // Pagination
          'page': page,
          'per_page': ApiConstants.perPage,

          // Pixabay filters
          'image_type': 'photo',
          'safesearch': true,
          'order': 'popular',

          // Category
          if (category != null &&
              category.isNotEmpty)
            'category': category,
        },
      );

      return PixabayResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw const AppException(
          'Invalid Pixabay API request.',
        );
      }

      if (e.response?.statusCode == 401) {
        throw const AppException(
          'Invalid Pixabay API key.',
        );
      }

      if (e.response?.statusCode == 429) {
        throw const AppException(
          'Too many API requests. Please try again later.',
        );
      }

      throw AppException(
        e.message ?? 'Unable to load images.',
      );
    } catch (e) {
      throw const AppException(
        'Something went wrong while loading images.',
      );
    }
  }
}