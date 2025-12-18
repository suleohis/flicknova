import 'package:flicknova/core/shared/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/extensions/context_theme_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/app_localizations.dart';
import '../../../../routes/app_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final GoRouter _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _router = GoRouter.of(context);
  }

  @override
  void initState() {
    super.initState();

    // Show splash for 3 seconds, THEN trigger redirect
    Future.delayed(const Duration(seconds: 3), () {
      // This re-triggers the redirect in app_router.dart
      context.replace(AppRouter.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.splashBackground.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.branding.logo.svg(height: 110, fit: BoxFit.fill),
                SizedBox(height: 5),
                Assets.branding.logoName.svg(height: 48, width: 228),
                Text(
                  S.of(context).app_name_title,
                  style: context.caption.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
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
