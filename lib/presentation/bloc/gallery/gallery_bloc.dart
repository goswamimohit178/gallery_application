import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/gallery_repository_impl.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository repository;

  GalleryBloc(this.repository) : super(const GalleryState()) {
    on<GalleryStarted>(_onStarted);
    on<GalleryLoadMore>(_onLoadMore);
    on<GallerySearchChanged>(_onSearchChanged);
    on<GalleryCategoryChanged>(_onCategoryChanged);
    on<GalleryRefreshRequested>(_onRefresh);
  }

  Future<void> _onStarted(
      GalleryStarted event,
      Emitter<GalleryState> emit,
      ) async {
    await _fetchFirstPage(
      emit,
      query: state.query,
      category: state.category,
    );
  }

  Future<void> _onRefresh(
      GalleryRefreshRequested event,
      Emitter<GalleryState> emit,
      ) async {
    await _fetchFirstPage(
      emit,
      query: state.query,
      category: state.category,
    );
  }

  Future<void> _onSearchChanged(
      GallerySearchChanged event,
      Emitter<GalleryState> emit,
      ) async {
    await _fetchFirstPage(
      emit,
      query: event.query.trim(),
      category: state.category,
    );
  }

  Future<void> _onCategoryChanged(
      GalleryCategoryChanged event,
      Emitter<GalleryState> emit,
      ) async {
    await _fetchFirstPage(
      emit,
      query: state.query,
      category: event.category,
    );
  }

  Future<void> _onLoadMore(
      GalleryLoadMore event,
      Emitter<GalleryState> emit,
      ) async {
    if (state.isLoadingMore || !state.hasMore) {
      return;
    }

    emit(
      state.copyWith(
        isLoadingMore: true,
      ),
    );

    try {
      final nextPage = state.currentPage + 1;

      final response = await repository.searchImages(
        page: nextPage,
        query: state.query,
        category: state.category,
      );

      final allImages = [
        ...state.images,
        ...response.images,
      ];

      emit(
        state.copyWith(
          status: GalleryStatus.success,
          images: allImages,
          currentPage: nextPage,
          hasMore: response.images.isNotEmpty &&
              allImages.length < response.totalHits,
          isLoadingMore: false
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _fetchFirstPage(
      Emitter<GalleryState> emit, {
        required String query,
        required String? category,
      }) async {
    emit(
      state.copyWith(
        status: GalleryStatus.loading,
        images: const [],
        currentPage: 1,
        hasMore: true,
        isLoadingMore: false,
        query: query,
        category: category,
        clearCategory: category == null,
      ),
    );

    try {
      final response = await repository.searchImages(
        page: 1,
        query: query,
        category: category,
      );

      emit(
        state.copyWith(
          status: GalleryStatus.success,
          images: response.images,
          currentPage: 1,
          hasMore: response.images.isNotEmpty,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GalleryStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}