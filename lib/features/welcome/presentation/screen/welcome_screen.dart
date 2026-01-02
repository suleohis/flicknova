import 'package:flicknova/core/theme/app_colors.dart';
import 'package:flicknova/core/extensions/context_theme_extension.dart';
import 'package:flicknova/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../generated/app_localizations.dart';
import '../../../../shared/widgets/buttons/secondary_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Container(
          width: .infinity,
          height: .infinity,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.images.welcomeBackground.path), fit: .fill)
          ),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Container(),
            Column(
              children: [
                Text(
                  S.of(context).app_name,
                  textAlign: .center,
                  style: context.h1.copyWith(
                    fontSize: 60.sp
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  S.of(context).welcome_text,
                  textAlign: .center,
                  style: context.h4.copyWith(
                      fontWeight: .w400
                  ),
                ),
              ],
            ),
            SecondaryButton(
              text: S.of(context).welcome_button,
              onPressed: () {
                context.push(AppRouter.onboarding);
              },
              height: 58.h,
              suffixIcon: Icon(Icons.arrow_forward, color: AppColors.secondary, size: 24.w,),
            )
          ],
      ),
    ));
  }
}
