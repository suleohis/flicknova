// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'FlickNova';

  @override
  String get app_name_title => 'Your Cinematic Universe';

  @override
  String get loading_library => 'Loading Library';

  @override
  String get welcome_text => 'Your Universe of Cinema\nAwaits';

  @override
  String get welcome_button => 'Start Exploring';

  @override
  String get onboarding_title1 => 'Personalized\nRecommendations';

  @override
  String get onboarding_content1 =>
      'Our smart engine finds gems tailored\nto your unique taste.';

  @override
  String get continue_text => 'Continue';
}
