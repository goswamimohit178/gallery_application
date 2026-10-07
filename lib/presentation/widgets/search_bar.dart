import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gallery/gallery_bloc.dart';
import '../bloc/gallery/gallery_event.dart';

class GallerySearchBar extends StatefulWidget {
  const GallerySearchBar({
    super.key,
  });

  @override
  State<GallerySearchBar> createState() =>
      _GallerySearchBarState();
}

class _GallerySearchBarState
    extends State<GallerySearchBar> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        context.read<GalleryBloc>().add(
          GallerySearchChanged(value),
        );
      },
      decoration: InputDecoration(
        hintText: 'Search images...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clear();

            context.read<GalleryBloc>().add(
              const GallerySearchChanged(''),
            );
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}