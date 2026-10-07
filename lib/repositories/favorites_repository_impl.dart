
import '../data/favorites_local_data.dart';
import '../models/pixabay_image.dart';

class FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepository(this.localDataSource);

  Future<List<PixabayImage>> getFavorites() {
    return localDataSource.getFavorites();
  }

  Future<void> saveFavorites(
      List<PixabayImage> favorites,
      ) {
    return localDataSource.saveFavorites(favorites);
  }
}