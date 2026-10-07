import 'package:equatable/equatable.dart';


import '../../../models/pixabay_image.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesStarted extends FavoritesEvent {
  const FavoritesStarted();
}

class FavoriteToggled extends FavoritesEvent {
  final PixabayImage image;

  const FavoriteToggled(this.image);

  @override
  List<Object?> get props => [image];
}