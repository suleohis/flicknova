import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/watchlist_item_entity.dart';
import 'empty_watchlist.dart';
import 'watchlist_card.dart';

class WatchlistGrid extends StatelessWidget {
  final List<WatchlistItemEntity> items;
  final bool isGridView;
  final Function(WatchlistItemEntity)? onItemTap;
  final Function(WatchlistItemEntity)? onItemRemove;

  const WatchlistGrid({
    super.key,
    required this.items,
    this.isGridView = true,
    this.onItemTap,
    this.onItemRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const EmptyWatchlist();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isGridView ? 2 : 1,
        childAspectRatio: isGridView ? 0.65 : 1.5,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return WatchlistCard(
          item: item,
          onTap: () => onItemTap?.call(item),
          onRemove: () => onItemRemove?.call(item),
        );
      },
    );
  }
}
