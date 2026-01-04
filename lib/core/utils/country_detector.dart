import 'dart:io';
import 'package:flutter/foundation.dart';

class CountryDetector {
  /// Get the user's country code based on device locale
  /// Returns ISO-3166-1 two-letter country code (e.g., 'US', 'GB', 'NG')
  /// Defaults to 'US' if country cannot be determined
  static String getUserCountryCode() {
    try {
      // Try to get country from platform locale
      final locale = Platform.localeName; // e.g., 'en_US', 'fr_FR'

      if (locale.contains('_')) {
        // Extract country code from locale (e.g., 'en_US' -> 'US')
        final parts = locale.split('_');
        if (parts.length >= 2) {
          final countryCode = parts[1].toUpperCase();
          // Return only the country part (before any additional modifiers)
          if (countryCode.contains('.')) {
            return countryCode.split('.')[0];
          }
          return countryCode;
        }
      }

      // Fallback to US if locale format is unexpected
      if (kDebugMode) {
        print('Could not parse country from locale: $locale, defaulting to US');
      }
      return 'US';
    } catch (e) {
      // If anything goes wrong, default to US
      if (kDebugMode) {
        print('Error detecting country: $e, defaulting to US');
      }
      return 'US';
    }
  }

  /// Get a human-readable country name for display
  /// Maps common country codes to names
  static String getCountryName(String countryCode) {
    final countryNames = {
      'US': 'United States',
      'GB': 'United Kingdom',
      'CA': 'Canada',
      'AU': 'Australia',
      'IN': 'India',
      'NG': 'Nigeria',
      'KE': 'Kenya',
      'ZA': 'South Africa',
      'FR': 'France',
      'DE': 'Germany',
      'ES': 'Spain',
      'IT': 'Italy',
      'BR': 'Brazil',
      'MX': 'Mexico',
      'JP': 'Japan',
      'KR': 'South Korea',
      'CN': 'China',
    };

    return countryNames[countryCode.toUpperCase()] ?? countryCode;
  }
}
