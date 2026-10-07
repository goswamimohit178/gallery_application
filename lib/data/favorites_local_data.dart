import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/pixabay_image.dart';

class FavoritesLocalDataSource {
  static const String _key = 'favorite_images';

  final SharedPreferences preferences;

  FavoritesLocalDataSource(this.preferences);

  Future<List<PixabayImage>> getFavorites() async {
    final data = preferences.getStringList(_key) ?? [];

    return data
        .map(
          (item) => PixabayImage.fromJson(
        jsonDecode(item) as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<void> saveFavorites(
      List<PixabayImage> favorites,
      ) async {
    final data = favorites
        .map(
          (image) => jsonEncode(image.toJson()),
    )
        .toList();

    await preferences.setStringList(_key, data);
  }
}