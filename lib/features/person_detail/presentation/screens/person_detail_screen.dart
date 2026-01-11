import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/core/services/firebase_analytics_service.dart';
import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/features/person_detail/presentation/providers/person_detail_notifier.dart';
import 'package:flicknova/features/person_detail/presentation/widgets/biography_section.dart';
import 'package:flicknova/features/person_detail/presentation/widgets/birth_info_row.dart';
import 'package:flicknova/features/person_detail/presentation/widgets/circular_profile_photo.dart';
import 'package:flicknova/features/person_detail/presentation/widgets/filmography_list.dart';
import 'package:flicknova/features/person_detail/presentation/widgets/known_for_section.dart';
import 'package:flicknova/shared/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonDetailScreen extends ConsumerStatefulWidget {
  final int personId;

  const PersonDetailScreen({super.key, required this.personId});

  @override
  ConsumerState<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends ConsumerState<PersonDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load person details when screen initializes
    Future.microtask(() {
      ref.read(personDetailProvider.notifier).loadPersonDetail(widget.personId);

      // Track screen view
      FirebaseAnalyticsService.instance.logScreenView('person_detail_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(personDetailProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.share, color: AppColors.white),
          //   onPressed: () {
          //     // TODO: Share person
          //   },
          // ),
        ],
      ),
      body: detailState.isLoading
          ? const Center(child: AppLoading())
          : detailState.person == null
          ? Center(
              child: Text(
                detailState.error ?? 'Failed to load person details',
                style: const TextStyle(color: AppColors.white),
              ),
            )
          : CustomScrollView(
              slivers: [
                // Hero section with profile photo and info
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.background,
                          AppColors.background.withValues(alpha: 0.8),
                          AppColors.background,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 100.h),
                        // Circular profile photo
                        CircularProfilePhoto(
                          profilePath: detailState.person!.profilePath,
                          size: 150,
                        ),
                        SizedBox(height: 20.h),
                        // Name
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            detailState.person!.name,
                            style: context.h1.copyWith(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Known for department
                        Text(
                          detailState.person!.knownForDepartment,
                          style: context.bodyLarge.copyWith(
                            color: AppColors.linkColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        // Birth info
                        BirthInfoRow(
                          birthday: detailState.person!.birthday,
                          placeOfBirth: detailState.person!.placeOfBirth,
                        ),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),

                // Biography section
                SliverToBoxAdapter(
                  child: BiographySection(
                    biography: detailState.person!.biography,
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 32.h)),

                // Known For section
                SliverToBoxAdapter(
                  child: KnownForSection(movies: detailState.knownFor),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 32.h)),

                // Filmography section
                SliverToBoxAdapter(
                  child: FilmographyList(filmography: detailState.filmography),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 40.h)),
              ],
            ),
    );
  }
}
