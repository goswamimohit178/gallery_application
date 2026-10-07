import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart';
import '../bloc/gallery/gallery_bloc.dart';
import '../bloc/gallery/gallery_event.dart';
import '../bloc/gallery/gallery_state.dart';
import '../widgets/category_filter.dart';
import '../widgets/error_view.dart';
import '../widgets/image_card.dart';
import '../widgets/search_bar.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController =
  ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(
      _onScroll,
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >=
        position.maxScrollExtent - 500) {
      context.read<GalleryBloc>().add(
        const GalleryLoadMore(),
      );
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appName,
        ),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const FavoritesScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: GallerySearchBar(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: CategoryFilter(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<GalleryBloc, GalleryState>(
              builder: (context, state) {
                if (state.status ==
                    GalleryStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.status ==
                    GalleryStatus.failure &&
                    state.images.isEmpty) {
                  return ErrorView(
                    message:
                    state.errorMessage ??
                        'Unable to load images.',
                    onRetry: () {
                      context.read<GalleryBloc>().add(
                        const GalleryStarted(),
                      );
                    },
                  );
                }

                if (state.images.isEmpty) {
                  return const Center(
                    child: Text(
                      'No images found.',
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<GalleryBloc>().add(
                      const GalleryRefreshRequested(),
                    );
                  },
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    physics:
                    const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: state.images.length +
                        (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.images.length) {
                        return const Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }

                      return ImageCard(
                        image: state.images[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}