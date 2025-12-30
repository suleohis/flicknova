import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'FlickNova'**
  String get app_name;

  /// No description provided for @app_name_title.
  ///
  /// In en, this message translates to:
  /// **'Your Cinematic Universe'**
  String get app_name_title;

  /// No description provided for @loading_library.
  ///
  /// In en, this message translates to:
  /// **'Loading Library'**
  String get loading_library;

  /// No description provided for @welcome_text.
  ///
  /// In en, this message translates to:
  /// **'Your Universe of Cinema\nAwaits'**
  String get welcome_text;

  /// No description provided for @welcome_button.
  ///
  /// In en, this message translates to:
  /// **'Start Exploring'**
  String get welcome_button;

  /// No description provided for @onboarding_title1.
  ///
  /// In en, this message translates to:
  /// **'Personalized\nRecommendations'**
  String get onboarding_title1;

  /// No description provided for @onboarding_content1.
  ///
  /// In en, this message translates to:
  /// **'Our smart engine finds gems tailored\nto your unique taste.'**
  String get onboarding_content1;

  /// No description provided for @onboarding_title2.
  ///
  /// In en, this message translates to:
  /// **'Curated Collections'**
  String get onboarding_title2;

  /// No description provided for @onboarding_content2.
  ///
  /// In en, this message translates to:
  /// **'Explore expertly crafted lists and embark on personal film journeys.'**
  String get onboarding_content2;

  /// No description provided for @onboarding_title3.
  ///
  /// In en, this message translates to:
  /// **'Save to Watchlist'**
  String get onboarding_title3;

  /// No description provided for @onboarding_content3.
  ///
  /// In en, this message translates to:
  /// **'Never forget a film! Organize your favorites and build your ultimate watchlist.'**
  String get onboarding_content3;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @sign_in_note.
  ///
  /// In en, this message translates to:
  /// **'Join FlickNova to discover your\nnext favorite film.'**
  String get sign_in_note;

  /// No description provided for @sign_in_with_google.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get sign_in_with_google;

  /// No description provided for @sign_in_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get sign_in_with_apple;

  /// No description provided for @agreeTo.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to FlickNova\'s'**
  String get agreeTo;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get and;

  /// No description provided for @no_id_token.
  ///
  /// In en, this message translates to:
  /// **'No ID Token'**
  String get no_id_token;

  /// No description provided for @sign_in_failed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed'**
  String get sign_in_failed;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
