import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/genre_model.dart';
import '../../../../generated/app_localizations.dart';
import '../../../../shared/widgets/buttons/genre_button.dart';
import '../../../../shared/widgets/buttons/shimmers/shimmer_genre_row.dart';
import '../providers/auth_notifier.dart';

class ChooseFavoriteGenresScreen extends ConsumerWidget {
  const ChooseFavoriteGenresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final authNotifier = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Text(
              s.choose_favorite_genres,
              textAlign: TextAlign.center,
              style: context.h1,
            ),
            SizedBox(height: 15.h),
            Text(
              s.choose_favorite_genres_content,
              textAlign: TextAlign.center,
              style: context.body.copyWith(color: AppColors.white600),
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: ref
                  .watch(movieGenresProvider)
                  .when(
                    data: (genres) => SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Wrap(
                        runSpacing: 15.w,
                        spacing: 15.h,
                        runAlignment: .center,
                        crossAxisAlignment: .center,
                        alignment: .center,
                        children: genres.map((g) {
                          GenreModel genre = GenreModel(id: g.id, name: g.name);
                          bool isSelected =
                              authNotifier.profile?.favoriteGenres?.any(
                                (fav) => fav.id == genre.id,
                              ) ??
                              false;
                          int index =
                              (authNotifier.profile?.favoriteGenres?.indexOf(
                                    genre,
                              ) ?? 0) %
                                  3;
                          return GenreButton(
                            label: genre.name,
                            isSelected: isSelected,
                            index: index,
                            onPressed: () => ref
                                .read(authProvider.notifier)
                                .toggleFavoriteGenre(genre),
                          );
                        }).toList(),
                      ),
                    ),
                    loading: () => ShimmerGenreRow(),
                    error: (error, stackTrace) => Center(
                      child: Text(s.something_went_wrong, style: context.h4),
                    ),
                  ),
            ),
            PrimaryButton(
              text: s.continue_text,
              onPressed: () =>  ref.read(authProvider.notifier).saveProfile(context, true),
              isLoading: authNotifier.isLoading,
              isEnabled:
                  authNotifier.profile?.favoriteGenres?.isNotEmpty ?? true,
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ),
    );
  }
}
