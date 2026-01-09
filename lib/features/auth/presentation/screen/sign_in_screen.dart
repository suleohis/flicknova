import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/generated/app_localizations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/assets.gen.dart';
import '../providers/auth_notifier.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final authState = ref.watch(authProvider);
    if (authState.isLoading) {
      return Container(
        width: .infinity,
        height: .infinity,
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.authBackground.path),
            fit: .fill,
          ),
        ),
        child: Scaffold(body: const Center(child: CircularProgressIndicator())),
      );
    }

    return Container(
      width: .infinity,
      height: .infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.authBackground.path),
          fit: .fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisSize: .min,
            children: [
              Assets.branding.logoNoB.svg(height: 31.h, width: 24.w),
              SizedBox(width: 6.w),
              Text(s.app_name, style: context.h4),
            ],
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(24.w),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                SizedBox(height: 20.h),
                Column(
                  mainAxisAlignment: .center,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      s.get_started,
                      style: context.body.copyWith(fontSize: 33.sp),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      s.sign_in_note,
                      textAlign: TextAlign.center,
                      style: context.body.copyWith(
                        fontSize: 17.sp,
                        color: AppColors.white600,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    GestureDetector(
                      onTap: () => ref
                          .read(authProvider.notifier)
                          .signInWithGoogle(context),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: .circular(24.r),
                            color: AppColors.white.withValues(alpha: .15),
                            border: Border.all(
                              color: AppColors.white.withValues(alpha: .2), )
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: .min,
                            children: [
                              Assets.icons.googleIcon.svg(
                                height: 24.h,
                                width: 24.w,
                              ),
                              SizedBox(width: 12.w),
                              Text(s.sign_in_with_google, style: context.bodyLarge),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    // Container(
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     borderRadius: .circular(24.r),
                    //     color: AppColors.white.withValues(alpha: .15),
                    //     border: Border.all(
                    //         color: AppColors.white.withValues(alpha: .2), )
                    //   ),
                    //   child: Center(
                    //     child: Row(
                    //       mainAxisSize: .min,
                    //       children: [
                    //         Assets.icons.appleIcon.svg(
                    //           height: 24.h,
                    //           width: 24.w,
                    //         ),
                    //         SizedBox(width: 12.w),
                    //         Text(s.sign_in_with_apple, style: context.bodyLarge),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      s.agreeTo,
                      style: context.bodySmall.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.white.withValues(alpha: .5),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: s.termsOfService,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: context.bodySmall.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.white.withValues(alpha: .8),
                            ),
                          ),
                          TextSpan(
                            text: s.and,
                            style: context.bodySmall.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.white.withValues(alpha: .5),
                            ),
                          ),
                          TextSpan(
                            text: s.privacyPolicy,
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            style: context.bodySmall.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.white.withValues(alpha: .8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
