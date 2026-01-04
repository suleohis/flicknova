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

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @sign_in_success.
  ///
  /// In en, this message translates to:
  /// **'Sign in successful'**
  String get sign_in_success;

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

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @choose_favorite_genres.
  ///
  /// In en, this message translates to:
  /// **'Choose your favorite\ngenres'**
  String get choose_favorite_genres;

  /// No description provided for @choose_favorite_genres_content.
  ///
  /// In en, this message translates to:
  /// **'Select at least 3 to personalize your\nrecommendations.'**
  String get choose_favorite_genres_content;

  /// No description provided for @trending_now.
  ///
  /// In en, this message translates to:
  /// **'Trending Now'**
  String get trending_now;

  /// No description provided for @popular_on_flcik_nova.
  ///
  /// In en, this message translates to:
  /// **'Popular on FlickNova'**
  String get popular_on_flcik_nova;

  /// No description provided for @for_you.
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get for_you;

  /// No description provided for @top_10_in_your_country.
  ///
  /// In en, this message translates to:
  /// **'Top 10 in Your Country'**
  String get top_10_in_your_country;

  /// No description provided for @new_releases.
  ///
  /// In en, this message translates to:
  /// **'New Releases'**
  String get new_releases;

  /// No description provided for @play_trailer.
  ///
  /// In en, this message translates to:
  /// **'Play Trailer'**
  String get play_trailer;

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get see_all;

  /// No description provided for @tv.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get tv;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @anime.
  ///
  /// In en, this message translates to:
  /// **'Anime'**
  String get anime;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get cast;

  /// No description provided for @you_may_also_like.
  ///
  /// In en, this message translates to:
  /// **'You May Also Like'**
  String get you_may_also_like;

  /// No description provided for @add_to_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Add to Watchlist'**
  String get add_to_watchlist;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @director.
  ///
  /// In en, this message translates to:
  /// **'Director'**
  String get director;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @runtime_minutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String runtime_minutes(Object minutes);

  /// No description provided for @no_overview.
  ///
  /// In en, this message translates to:
  /// **'No overview available'**
  String get no_overview;

  /// No description provided for @synopsis.
  ///
  /// In en, this message translates to:
  /// **'Synopsis'**
  String get synopsis;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @search_movies_shows_actors.
  ///
  /// In en, this message translates to:
  /// **'Search movies, shows, actors...'**
  String get search_movies_shows_actors;

  /// No description provided for @recently_viewed.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get recently_viewed;

  /// No description provided for @trending_searches.
  ///
  /// In en, this message translates to:
  /// **'Trending Searches'**
  String get trending_searches;

  /// No description provided for @browse_by_genre.
  ///
  /// In en, this message translates to:
  /// **'Browse by Genre'**
  String get browse_by_genre;

  /// No description provided for @top_results.
  ///
  /// In en, this message translates to:
  /// **'Top Results'**
  String get top_results;

  /// No description provided for @top.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get top;

  /// No description provided for @shows.
  ///
  /// In en, this message translates to:
  /// **'Shows'**
  String get shows;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @sci_fi.
  ///
  /// In en, this message translates to:
  /// **'Sci-Fi'**
  String get sci_fi;

  /// No description provided for @comedy.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get comedy;

  /// No description provided for @thriller.
  ///
  /// In en, this message translates to:
  /// **'Thriller'**
  String get thriller;

  /// No description provided for @adventure.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventure;

  /// No description provided for @horror.
  ///
  /// In en, this message translates to:
  /// **'Horror'**
  String get horror;

  /// No description provided for @romance.
  ///
  /// In en, this message translates to:
  /// **'Romance'**
  String get romance;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @watchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get watchlist;

  /// No description provided for @my_watchlist.
  ///
  /// In en, this message translates to:
  /// **'My Watchlist'**
  String get my_watchlist;

  /// No description provided for @hours_saved.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours saved'**
  String hours_saved(Object hours);

  /// No description provided for @episodes_watched.
  ///
  /// In en, this message translates to:
  /// **'{watched} of {total} episodes watched'**
  String episodes_watched(Object total, Object watched);

  /// No description provided for @remove_from_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Remove from Watchlist'**
  String get remove_from_watchlist;

  /// No description provided for @watchlist_empty.
  ///
  /// In en, this message translates to:
  /// **'Your watchlist is empty'**
  String get watchlist_empty;

  /// No description provided for @watchlist_empty_message.
  ///
  /// In en, this message translates to:
  /// **'Add movies and shows to start building your collection'**
  String get watchlist_empty_message;

  /// No description provided for @grid_view.
  ///
  /// In en, this message translates to:
  /// **'Grid View'**
  String get grid_view;

  /// No description provided for @list_view.
  ///
  /// In en, this message translates to:
  /// **'List View'**
  String get list_view;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @movies_watched.
  ///
  /// In en, this message translates to:
  /// **'{count} Movies Watched'**
  String movies_watched(Object count);

  /// No description provided for @total_hours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h Total'**
  String total_hours(Object hours);

  /// No description provided for @avg_rating.
  ///
  /// In en, this message translates to:
  /// **'{rating}★ Avg Rating'**
  String avg_rating(Object rating);

  /// No description provided for @favorite_genres.
  ///
  /// In en, this message translates to:
  /// **'Favorite Genres'**
  String get favorite_genres;

  /// No description provided for @year_in_review.
  ///
  /// In en, this message translates to:
  /// **'{year} in Review'**
  String year_in_review(Object year);

  /// No description provided for @cinematic_journey.
  ///
  /// In en, this message translates to:
  /// **'Your cinematic journey of the year'**
  String get cinematic_journey;

  /// No description provided for @recent_ratings.
  ///
  /// In en, this message translates to:
  /// **'Recent Ratings'**
  String get recent_ratings;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @logout_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logout_confirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
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
