import 'package:equatable/equatable.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class GalleryStarted extends GalleryEvent {
  const GalleryStarted();
}

class GalleryLoadMore extends GalleryEvent {
  const GalleryLoadMore();
}

class GallerySearchChanged extends GalleryEvent {
  final String query;

  const GallerySearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class GalleryCategoryChanged extends GalleryEvent {
  final String? category;

  const GalleryCategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class GalleryRefreshRequested extends GalleryEvent {
  const GalleryRefreshRequested();
}