import '../data/pixabay_remote_data.dart';

import '../models/pixabay_response.dart';

class GalleryRepository {
  final PixabayRemoteDataSource remoteDataSource;

  GalleryRepository(this.remoteDataSource);

  Future<PixabayResponse> searchImages({
    required int page,
    String query = '',
    String? category,
  }) {
    return remoteDataSource.searchImages(
      page: page,
      query: query,
      category: category,
    );
  }
}