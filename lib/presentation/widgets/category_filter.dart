import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_constants.dart';
import '../bloc/gallery/gallery_bloc.dart';
import '../bloc/gallery/gallery_event.dart';
import '../bloc/gallery/gallery_state.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      buildWhen: (previous, current) {
        return previous.category != current.category;
      },
      builder: (context, state) {
        return SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: AppConstants.categories.length,
            separatorBuilder: (_, __) {
              return const SizedBox(width: 8);
            },
            itemBuilder: (context, index) {
              final category =
              AppConstants.categories[index];

              final isSelected = category == 'All'
                  ? state.category == null
                  : state.category == category;

              return FilterChip(
                selected: isSelected,
                label: Text(
                  category[0].toUpperCase() +
                      category.substring(1),
                ),
                onSelected: (_) {
                  context.read<GalleryBloc>().add(
                    GalleryCategoryChanged(
                      category == 'All'
                          ? null
                          : category,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}