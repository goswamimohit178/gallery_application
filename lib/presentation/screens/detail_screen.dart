import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../injection_container.dart';
import '../../models/pixabay_image.dart';
import '../bloc/download/download_bloc.dart';
import '../bloc/download/download_event.dart';
import '../bloc/download/download_state.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';

class DetailScreen extends StatelessWidget {
  final PixabayImage image;

  const DetailScreen({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadBloc>(
      create: (_) => locator<DownloadBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Image Details'),
          actions: [
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                final isFavorite =
                state.isFavorite(image.id);

                return IconButton(
                  onPressed: () {
                    context.read<FavoritesBloc>().add(
                      FavoriteToggled(image),
                    );
                  },
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavorite
                        ? Colors.red
                        : null,
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'image-${image.id}',
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: image.largeImageUrl,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    placeholder: (_, __) {
                      return const AspectRatio(
                        aspectRatio: 1,
                        child: Center(
                          child:
                          CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorWidget: (_, __, ___) {
                      return const Icon(
                        Icons.broken_image,
                        size: 80,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Description',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                image.tags.isEmpty
                    ? 'No description available.'
                    : image.tags,
              ),
              const SizedBox(height: 20),
              Text(
                'Uploaded by',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),
              const SizedBox(height: 4),
              Text(image.user),
              const SizedBox(height: 20),
              _ImageStatistics(image: image),
              const SizedBox(height: 24),
              BlocConsumer<DownloadBloc, DownloadState>(
                listener: (context, state) {
                  if (state.status ==
                      DownloadStatus.success) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message ??
                              'Image saved.',
                        ),
                      ),
                    );
                  }

                  if (state.status ==
                      DownloadStatus.failure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message ??
                              'Download failed.',
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final downloading =
                      state.status ==
                          DownloadStatus.downloading;

                  return SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: downloading
                          ? null
                          : () {
                        context
                            .read<DownloadBloc>()
                            .add(
                          DownloadRequested(
                            image.largeImageUrl,
                          ),
                        );
                      },
                      icon: Icon(
                        downloading
                            ? Icons.downloading
                            : Icons.download,
                      ),
                      label: Text(
                        downloading
                            ? 'Downloading ${(state.progress * 100).toStringAsFixed(0)}%'
                            : 'Download Image',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Image source: Pixabay',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageStatistics extends StatelessWidget {
  final PixabayImage image;

  const _ImageStatistics({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceAround,
      children: [
        _Stat(
          icon: Icons.favorite,
          label: 'Likes',
          value: image.likes,
        ),
        _Stat(
          icon: Icons.visibility,
          label: 'Views',
          value: image.views,
        ),
        _Stat(
          icon: Icons.download,
          label: 'Downloads',
          value: image.downloads,
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;

  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(value.toString()),
        Text(label),
      ],
    );
  }
}