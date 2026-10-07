import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image/presentation/bloc/favorites/favorites_event.dart';
import 'package:image/presentation/bloc/gallery/gallery_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/favorites_local_data.dart';
import 'data/pixabay_remote_data.dart';

import 'repositories/favorites_repository_impl.dart';
import 'repositories/gallery_repository_impl.dart';

import 'presentation/bloc/download/download_bloc.dart';
import 'presentation/bloc/favorites/favorites_bloc.dart';
import 'presentation/bloc/gallery/gallery_bloc.dart';

import 'presentation/screens/home_screen.dart';

final GetIt locator = GetIt.instance;

Future<void> setupDependencies() async {

  final preferences = await SharedPreferences.getInstance();


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

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const PixabayGalleryApp());
}

class PixabayGalleryApp extends StatelessWidget {
  const PixabayGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GalleryBloc>(
          create: (_) => locator<GalleryBloc>()
            ..add(
              const GalleryStarted(),
            ),
        ),

        BlocProvider<FavoritesBloc>(
          create: (_) => locator<FavoritesBloc>()
            ..add(
              const FavoritesStarted(),
            ),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pixabay Gallery',

        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),

        home: const HomeScreen(),
      ),
    );
  }
}