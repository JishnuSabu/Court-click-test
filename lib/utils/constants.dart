import 'package:flutter/material.dart';

class AppConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String backdropBaseUrl = 'https://image.tmdb.org/t/p/w780';

  static const String _defaultApiKey = '96566a11e4c95d5df9b523843fb32fca';

  static String get apiKey {
    return _defaultApiKey;
  }

  static String getPosterUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return path.startsWith('http') ? path : '$imageBaseUrl$path';
  }

  static String getBackdropUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return path.startsWith('http') ? path : '$backdropBaseUrl$path';
  }
}

class AppColors {
  static const Color netflixRed = Color(0xFFE50914);
  static const Color black = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF141414);
  static const Color darkCard = Color(0xFF1A1A1A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyText = Color(0xFFC4C4C4);
  static const Color darkGrey = Color(0xFF2C2C2E);
  static const Color lightGrey = Color(0xFF424242);
  static const Color mediumGrey = Color(0xFF8C8787);
  static const Color goldStar = Color(0xFFFFC107);
  static const Color blue = Color(0xFF0071EB);
}
