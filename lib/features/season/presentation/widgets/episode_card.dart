import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/season_entity.dart';
import '../../../../core/network/tmdb_service.dart';
import '../../../../core/theme/app_colors.dart';
import 'guest_star_avatar.dart';

class EpisodeCard extends StatefulWidget {
  final EpisodeEntity episode;
  final VoidCallback? onTap;

  const EpisodeCard({super.key, required this.episode, this.onTap});

  @override
  State<EpisodeCard> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends State<EpisodeCard> {
  bool _isExpanded = false;

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('MMM d, yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
        widget.onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Episode thumbnail and title row
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail
                  _buildThumbnail(),
                  SizedBox(width: 12.w),

                  // Episode info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EPISODE ${widget.episode.episodeNumber}',
                          style: TextStyle(
                            color: AppColors.trendingBadge,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.episode.name,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            if (widget.episode.airDate != null) ...[
                              Icon(
                                Icons.calendar_today,
                                size: 12.sp,
                                color: AppColors.white600,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _formatDate(widget.episode.airDate),
                                style: TextStyle(
                                  color: AppColors.white600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                            ],
                            if (widget.episode.voteAverage > 0) ...[
                              Icon(
                                Icons.star,
                                size: 12.sp,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                widget.episode.voteAverage.toStringAsFixed(1),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Expand icon
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.white600,
                    size: 24.sp,
                  ),
                ],
              ),
            ),

            // Expandable content
            if (_isExpanded) ...[
              Divider(color: AppColors.white100, height: 1),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.episode.overview.isNotEmpty) ...[
                      Text(
                        widget.episode.overview,
                        style: TextStyle(
                          color: AppColors.white600,
                          fontSize: 13.sp,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],

                    // Guest stars
                    if (widget.episode.guestStars.isNotEmpty) ...[
                      Text(
                        'GUEST STARS',
                        style: TextStyle(
                          color: AppColors.white600,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 90.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.episode.guestStars.length.clamp(
                            0,
                            10,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: GuestStarAvatar(
                                guestStar: widget.episode.guestStars[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 100.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.episode.stillPath != null)
            CachedNetworkImage(
              imageUrl:
                  '${TmdbService.baseImageUrl}${TmdbService.backdropSize}${widget.episode.stillPath}',
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: AppColors.cardBackground),
              errorWidget: (context, url, error) =>
                  Icon(Icons.movie, size: 32.sp, color: AppColors.white600),
            )
          else
            Icon(Icons.movie, size: 32.sp, color: AppColors.white600),

          // Play button overlay
          Center(
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: AppColors.white,
                size: 20.sp,
              ),
            ),
          ),

          // Runtime badge
          if (widget.episode.runtime != null)
            Positioned(
              bottom: 4.h,
              right: 4.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  '${widget.episode.runtime}m',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
