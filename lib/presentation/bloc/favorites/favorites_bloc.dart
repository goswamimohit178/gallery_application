import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../repositories/favorites_repository_impl.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc
    extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository repository;

  FavoritesBloc(this.repository)
      : super(const FavoritesState()) {
    on<FavoritesStarted>(_onStarted);
    on<FavoriteToggled>(_onToggled);
  }

  Future<void> _onStarted(
      FavoritesStarted event,
      Emitter<FavoritesState> emit,
      ) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final favorites = await repository.getFavorites();

    emit(
      state.copyWith(
        favorites: favorites,
        isLoading: false,
      ),
    );
  }

  Future<void> _onToggled(
      FavoriteToggled event,
      Emitter<FavoritesState> emit,
      ) async {
    final favorites = [
      ...state.favorites,
    ];

    final index = favorites.indexWhere(
          (item) => item?.id == event.image.id,
    );

    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      favorites.add(event.image);
    }

    await repository.saveFavorites(favorites);

    emit(
      state.copyWith(
        favorites: favorites,
      ),
    );
  }
}