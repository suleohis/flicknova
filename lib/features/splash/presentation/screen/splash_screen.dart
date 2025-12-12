import 'package:flicknova/core/shared/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/extensions/context_theme_extension.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/app_localizations.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
          height: double.infinity,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.images.background.path), fit: BoxFit.fill)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Assets.branding.logo.svg(
                  height: 110,
                  fit: BoxFit.fill
                ),
                SizedBox(height: 5,),
                Assets.branding.logoName.svg(
                    height: 48,
                    width: 228
                ),
                Text(
                  S.of(context).app_name_title,
                  style: context.caption.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
            AppLoading(
              message: S.of(context).loading_library,
            )
          ],
        ),
      ),
    );
  }
}