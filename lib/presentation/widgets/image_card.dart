import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/pixabay_image.dart';
import '../bloc/favorites/favorites_bloc.dart';
import '../bloc/favorites/favorites_event.dart';
import '../bloc/favorites/favorites_state.dart';
import '../screens/detail_screen.dart';

class ImageCard extends StatelessWidget {
  final PixabayImage image;

  const ImageCard({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(
              image: image,
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: image.webFormatUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorWidget: (_, __, ___) {
                  return const Icon(
                    Icons.broken_image,
                  );
                },
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  final isFavorite =
                  state.isFavorite(image.id);

                  return CircleAvatar(
                    backgroundColor:
                    Colors.black.withValues(alpha: 0.55),
                    child: IconButton(
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
                            : Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}