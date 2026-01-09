import 'package:flicknova/shared/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_theme_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/app_localizations.dart';
import '../providers/splash_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashNotifier.notifier).getCurrentProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: .infinity,
        height: .infinity,
        padding: .zero,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.splashBackground.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            SizedBox(),
            Column(
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Assets.branding.logo.svg(height: 110.h, fit: BoxFit.fill),
                SizedBox(height: 5),
                Assets.branding.logoName.svg(height: 48.h, width: 228.w),
                Text(
                  S.of(context).app_name_title,
                  style: context.caption.copyWith(
                    fontSize: 14.sp,
                    fontWeight: .w300,
                  ),
                ),
              ],
            ),
            AppLoading(message: S.of(context).loading_library),
          ],
        ),
      ),
    );
  }
}
