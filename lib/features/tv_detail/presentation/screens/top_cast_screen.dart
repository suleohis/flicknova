import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/context_theme_extension.dart';
import '../../../../core/models/common_detail_entities.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/app_localizations.dart';
import '../../../../shared/app_loading.dart';
import '../../../home/presentation/widgets/person_card.dart';
import '../../../person_detail/presentation/screens/person_detail_screen.dart';
import '../providers/tv_detail_notifier.dart';

class TopCastScreen extends ConsumerStatefulWidget {

const TopCastScreen({
super.key,
});

@override
ConsumerState<TopCastScreen> createState() => _TopCastScreenState();
}

class _TopCastScreenState extends ConsumerState<TopCastScreen> {


  @override
  build (context,) {
    final state = ref.watch(tvDetailProvider);

    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.top_cast),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AlignedGridView.count(
        padding: EdgeInsets.all(16.w),
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,

        itemCount: state.series?.credits?.cast.length ?? 0,
        itemBuilder: (context, index) {

          final item = state.series?.credits?.cast[index];
          return _TopCastCard(
            cast: item!,
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonDetailScreen(personId: item!.id
                    ),
                  ),
                ),
          );;
        },
      ),
    );
  }
}

class _TopCastCard extends StatelessWidget {
  final CastMemberEntity cast;
  final VoidCallback? onTap;

  const _TopCastCard({super.key, required this.cast, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100.w,
        child: Column(
          children: [
            // Circular photo
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white400.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: cast.profilePath != null
                    ? CachedNetworkImage(
                  imageUrl: context.tmdbPosterUrl(cast.profilePath),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: AppColors.cardBackground),
                  errorWidget: (context, url, error) => Icon(
                    Icons.person,
                    color: AppColors.white400,
                    size: 40.sp,
                  ),
                )
                    : Icon(
                  Icons.person,
                  color: AppColors.white400,
                  size: 40.sp,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            // Name
            Text(
              cast.name,
              style: context.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
