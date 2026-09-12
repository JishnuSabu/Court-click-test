import '../utils/constants.dart';

class TrendingMoviesModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  TrendingMoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  TrendingMoviesModel.fromJson(Map<String, dynamic> json) {
    page = (json['page'] as num?)?.toInt();
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v as Map<String, dynamic>));
      });
    }
    totalPages = (json['total_pages'] as num?)?.toInt();
    totalResults = (json['total_results'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? softcore;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Results({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.softcore,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    id = (json['id'] as num?)?.toInt();
    title = json['title'] as String? ??
        json['name'] as String? ??
        json['original_title'] as String? ??
        json['original_name'] as String? ??
        'Untitled';
    originalTitle =
        json['original_title'] as String? ?? json['original_name'] as String?;
    overview = json['overview'] as String? ?? '';
    posterPath = json['poster_path'] as String?;
    mediaType = json['media_type'] as String?;
    originalLanguage = json['original_language'] as String?;
    if (json['genre_ids'] != null) {
      genreIds = (json['genre_ids'] as List)
          .map((e) => (e as num).toInt())
          .toList();
    }
    popularity = (json['popularity'] as num?)?.toDouble();
    releaseDate =
        json['release_date'] as String? ?? json['first_air_date'] as String?;
    softcore = json['softcore'] as bool?;
    video = json['video'] as bool?;
    voteAverage = (json['vote_average'] as num?)?.toDouble();
    voteCount = (json['vote_count'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['title'] = title;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['original_language'] = originalLanguage;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['release_date'] = releaseDate;
    data['softcore'] = softcore;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }

  String get displayTitle => title ?? originalTitle ?? 'Untitled';

  String get posterUrl => AppConstants.getPosterUrl(posterPath);
  String get backdropUrl =>
      AppConstants.getBackdropUrl(backdropPath ?? posterPath);

  String get formattedReleaseDate {
    if (releaseDate == null || releaseDate!.isEmpty) return 'Coming Soon';
    try {
      final parts = releaseDate!.split('-');
      if (parts.length >= 3) {
        final months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        final monthIdx = int.tryParse(parts[1]) ?? 1;
        final monthName = (monthIdx >= 1 && monthIdx <= 12)
            ? months[monthIdx - 1]
            : parts[1];
        return 'Season 1 Coming $monthName ${parts[2]}';
      }
      return releaseDate!;
    } catch (_) {
      return releaseDate!;
    }
  }

  List<String> get genreNames {
    final Map<int, String> genreMap = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Sci-Fi',
      53: 'Thriller',
    };
    final names = (genreIds ?? [])
        .map((id) => genreMap[id] ?? 'Drama')
        .take(4)
        .toList();
    return names.isEmpty ? ['Steamy', 'Suspenseful', 'Drama'] : names;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Results &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
