import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:flicknova/routes/app_router.dart';
import 'package:flicknova/shared/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/extensions/context_theme_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/app_localizations.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_bottom_pointer_widget.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final s = S.of(context);
    final onBoardState = ref.watch(onboardingProvider);
    List<OnboardingEntity> onboardingList = [
      OnboardingEntity(
        title: s.onboarding_title1,
        content: s.onboarding_content1,
        image: Assets.images.onboarding.onboarding1.path,
      ),
      OnboardingEntity(
        title: s.onboarding_title2,
        content: s.onboarding_content2,
        image: Assets.images.onboarding.onboarding2.path,
      ),
      OnboardingEntity(
        title: s.onboarding_title3,
        content: s.onboarding_content3,
        image: Assets.images.onboarding.onboarding3.path,
      ),
    ];
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.onboardingBackground.path),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: onboardingList.length,
                  onPageChanged: (index) {
                    ref.read(onboardingProvider.notifier).onTapIndex(index);
                  },
                  itemBuilder: (context, index) {
                    final onboarding = onboardingList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          onboarding.image,
                          height: 335.h,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Column(
                          children: [
                            Text(
                              onboarding.title,
                              textAlign: TextAlign.center,
                              style: context.h1.copyWith(fontSize: 36),
                            ),
                            Text(
                              onboarding.content,
                              textAlign: TextAlign.center,
                              style: context.body.copyWith(
                                fontSize: 18,
                                color: AppColors.gullGrey,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            OnboardingBottomPointerWidget(
                              length: onboardingList.length,
                              index: index,
                            ),
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              PrimaryButton(
                text: s.continue_text,
                onPressed: () => context.push(AppRouter.signIn),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
