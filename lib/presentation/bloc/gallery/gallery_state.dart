import 'package:equatable/equatable.dart';

import '../../../models/pixabay_image.dart';



enum GalleryStatus {
  initial,
  loading,
  success,
  failure,
}

class GalleryState extends Equatable {
  final GalleryStatus status;
  final List<PixabayImage> images;
  final String? errorMessage;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final String query;
  final String? category;

  const GalleryState({
    this.status = GalleryStatus.initial,
    this.images = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.query = '',
    this.category,
  });

  static const _noValue = Object();

  GalleryState copyWith({
    GalleryStatus? status,
    List<PixabayImage>? images,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    String? query,
    Object? category = _noValue,
    String? errorMessage,
    bool clearCategory = false,
  }) {
    return GalleryState(
      status: status ?? this.status,
      images: images ?? this.images,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,

      query: query ?? this.query,


      category: category == _noValue
          ? this.category
          : category as String?,

      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    images,
    errorMessage,
    currentPage,
    hasMore,
    isLoadingMore,
    query,
    category,
  ];
}