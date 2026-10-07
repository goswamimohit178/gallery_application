import 'package:equatable/equatable.dart';

import '../../../models/pixabay_image.dart';


class FavoritesState extends Equatable {
  final List<PixabayImage> favorites;
  final bool isLoading;

  const FavoritesState({
    this.favorites = const [],
    this.isLoading = false,
  });

  FavoritesState copyWith({
    List<PixabayImage>? favorites,
    bool? isLoading,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool isFavorite(int id) {
    return favorites.any((image) => image.id == id);
  }

  @override
  List<Object?> get props => [
    favorites,
    isLoading,
  ];
}