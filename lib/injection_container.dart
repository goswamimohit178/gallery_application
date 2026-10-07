import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image/repositories/favorites_repository_impl.dart';
import 'package:image/repositories/gallery_repository_impl.dart';
import 'data/favorites_local_data.dart';
import 'data/pixabay_remote_data.dart';
import 'presentation/bloc/download/download_bloc.dart';
import 'presentation/bloc/favorites/favorites_bloc.dart';
import 'presentation/bloc/gallery/gallery_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupDependencies() async {
  var SharedPreferences;
  final preferences =
  await SharedPreferences.getInstance();



  final dio = Dio();

  locator.registerLazySingleton<Dio>(
        () => dio,
  );

  locator.registerLazySingleton<PixabayRemoteDataSource>(
        () => PixabayRemoteDataSource(
      locator<Dio>(),
    ),
  );

  locator.registerLazySingleton<GalleryRepository>(
        () => GalleryRepository(
      locator<PixabayRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton<FavoritesLocalDataSource>(
        () => FavoritesLocalDataSource(
      preferences,
    ),
  );

  locator.registerLazySingleton<FavoritesRepository>(
        () => FavoritesRepository(
      locator<FavoritesLocalDataSource>(),
    ),
  );

  locator.registerFactory<GalleryBloc>(
        () => GalleryBloc(
      locator<GalleryRepository>(),
    ),
  );

  locator.registerFactory<FavoritesBloc>(
        () => FavoritesBloc(
      locator<FavoritesRepository>(),
    ),
  );

  locator.registerFactory<DownloadBloc>(
        () => DownloadBloc(
      locator<Dio>(),
    ),
  );
}