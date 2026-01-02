import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/app_localizations.dart';
import '../../../home/presentation/widgets/section_header.dart';
import '../../domain/entities/cast_entity.dart';
import 'cast_card.dart';

class CastList extends StatelessWidget {
  final List<CastEntity> cast;

  const CastList({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (cast.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: s.cast),
        SizedBox(
          height: 160.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: cast.length,
            itemBuilder: (context, index) {
              return CastCard(cast: cast[index]);
            },
          ),
        ),
      ],
    );
  }
}
