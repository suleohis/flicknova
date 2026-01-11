import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/models/movie_entity.dart';
import '../../../../core/models/person_entity.dart';
import '../../../../core/models/tv_show_entity.dart';
import '../../../../shared/app_loading.dart';
import '../../../home/presentation/widgets/movie_card.dart';
import '../../../home/presentation/widgets/person_card.dart';
import '../../../home/presentation/widgets/tv_card.dart';
import '../../../movie_detail/presentation/screens/movie_detail_screen.dart';
import '../../../person_detail/presentation/screens/person_detail_screen.dart';
import '../../../tv_detail/presentation/screens/tv_detail_screen.dart';
import '../providers/see_all_notifier.dart';

class SeeAllScreen extends ConsumerStatefulWidget {
  final String contentType; // 'movie', 'tv', 'person'
  final String category; // 'trending', 'popular', etc.
  final String title;

  const SeeAllScreen({
    super.key,
    required this.contentType,
    required this.category,
    required this.title,
  });

  @override
  ConsumerState<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends ConsumerState<SeeAllScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Initialize with content type and category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contentType = _parseContentType(widget.contentType);
      final category = _parseCategory(widget.category);
      ref.read(seeAllProvider.notifier).initialize(contentType, category);
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(seeAllProvider.notifier).loadMore();
    }
  }

  ContentType _parseContentType(String type) {
    switch (type.toLowerCase()) {
      case 'tv':
        return ContentType.tv;
      case 'person':
        return ContentType.person;
      default:
        return ContentType.movie;
    }
  }

  ContentCategory _parseCategory(String cat) {
    switch (cat.toLowerCase()) {
      case 'popular':
        return ContentCategory.popular;
      case 'top_rated':
      case 'toprated':
        return ContentCategory.topRated;
      case 'upcoming':
        return ContentCategory.upcoming;
      case 'now_playing':
      case 'nowplaying':
        return ContentCategory.nowPlaying;
      case 'on_air':
      case 'onair':
        return ContentCategory.onAir;
      default:
        return ContentCategory.trending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seeAllProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: state.error != null
          ? _buildError(state.error!)
          : state.items.isEmpty && state.isLoading
          ? const Center(child: AppLoading())
          : _buildGrid(state),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: Colors.white54),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(color: Colors.white70, fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              final contentType = _parseContentType(widget.contentType);
              final category = _parseCategory(widget.category);
              ref
                  .read(seeAllProvider.notifier)
                  .initialize(contentType, category);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(SeeAllState state) {
    final crossAxisCount = widget.contentType == 'person' ? 3 : 2;
    // final childAspectRatio = widget.contentType == 'person' ? 0.65: 0.6;

    return AlignedGridView.count(
      controller: _scrollController,
      padding: EdgeInsets.all(16.w),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 16.h,

      itemCount: state.items.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return const Center(child: AppLoading());
        }

        final item = state.items[index];
        return _buildGridItem(item);
      },
    );
  }

  Widget _buildGridItem(dynamic item) {
    if (item is MovieEntity) {
      return MovieCard(
        movie: item,
        width: double.infinity,
        height: 180.h,
        onTap: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                movieId: item.id,
                mediaType: item.mediaType,
              ),
            ),
          ),
      );
    } else if (item is TVShowEntity) {
      return TVCard(
        tvShow: item,
        width: double.infinity,
        height: 180.h,
        onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TVDetailScreen(
                    seriesId: item.id
                ),
              ),
            ),
      );
    } else if (item is PersonEntity) {
      return PersonCard(
        person: item,
        onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonDetailScreen(personId: item.id
                ),
              ),
            ),
      );
    }

    return const SizedBox.shrink();
  }
}
