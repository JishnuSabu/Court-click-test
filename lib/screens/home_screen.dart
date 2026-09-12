import 'package:cached_network_image/cached_network_image.dart';
import 'package:court_click_task/bloc/home/home_bloc.dart';
import 'package:court_click_task/bloc/home/home_event.dart';
import 'package:court_click_task/bloc/home/home_state.dart';
import 'package:court_click_task/screens/widget/custom_movie_image.dart';
import 'package:court_click_task/screens/widget/cm_horizontal_list_view_widget.dart';
import 'package:court_click_task/utils/constants.dart';
import 'package:court_click_task/utils/image_path/img_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const SafeArea(
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 18,
                  color: AppColors.white,
                ),
              ),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.wifi_off_rounded,
                      size: 64,
                      color: AppColors.netflixRed,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Oops! Unable to load movies',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.greyText,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.netflixRed,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        context.read<HomeBloc>().add(const FetchHomeMovies());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is HomeLoaded) {
            final trendingList = state.trendingMoviesModel.results ?? [];
            final popularList = state.popularMoviesModel.results ?? [];
            final topRatedList = state.topRatedMovieModel.results ?? [];
            final nowPlayingList = state.nowPlayingMovieModel.results ?? [];
            final upcomingList = state.upComingMovieModel.results ?? [];

            final heroMovie = trendingList.isNotEmpty
                ? trendingList.first
                : (popularList.isNotEmpty ? popularList.first : null);

            final previewsList = topRatedList;
            final continueWatchingList = nowPlayingList;
            final top10List = topRatedList;
            final myList = nowPlayingList;
            final africanMovies = popularList;
            final nollywoodMovies = trendingList;
            final netflixOriginals = upcomingList;
            final watchItAgain = topRatedList;
            final newReleases = upcomingList;
            final tvThrillers = popularList;
            final usTvShows = nowPlayingList;

            return RefreshIndicator(
              color: AppColors.netflixRed,
              backgroundColor: AppColors.darkCard,
              onRefresh: () async {
                context.read<HomeBloc>().add(const RefreshHomeMovies());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (heroMovie != null) _HeroBanner(movie: heroMovie),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _MyListIconButton(
                            icon: Icons.add,
                            label: 'My List',
                            onTap: () {},
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.play_arrow, size: 26),
                            label: const Text(
                              'Play',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          _MyListIconButton(
                            icon: Icons.info_outline,
                            label: ' Info ',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    _MovieSection(
                      title: 'Previews',
                      movies: previewsList,
                      customRail: _PreviewsRail(movies: previewsList),
                    ),
                    _MovieSection(
                      title: 'Continue Watching for Emenalo',
                      movies: continueWatchingList,
                      customRail: _ContinueWatchingRail(
                        movies: continueWatchingList,
                      ),
                    ),
                    _MovieSection(
                      title: 'Popular on Netflix',
                      movies: popularList,
                    ),
                    _MovieSection(title: 'Trending Now', movies: trendingList),
                    _MovieSection(
                      title: 'Top 10 in Nigeria Today',
                      movies: top10List,
                    ),
                    _MovieSection(title: 'My List', movies: myList),
                    _MovieSection(
                      title: 'African Movies',
                      movies: africanMovies,
                    ),
                    _MovieSection(
                      title: 'Nollywood Movies & TV',
                      movies: nollywoodMovies,
                    ),
                    _MovieSection(
                      title: 'Netflix Originals',
                      movies: netflixOriginals,
                      cardWidth: 154,
                      cardHeight: 251,
                    ),
                    _MovieSection(
                      title: 'Watch It Again',
                      movies: watchItAgain,
                    ),
                    _MovieSection(title: 'New Releases', movies: newReleases),
                    _MovieSection(
                      title: 'TV Thrillers & Mysteries',
                      movies: tvThrillers,
                    ),
                    _MovieSection(title: 'US TV Shows', movies: usTvShows),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final dynamic movie;

  const _HeroBanner({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 490,
            width: double.infinity,
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black87,
                  Colors.black26,
                  Colors.transparent,
                  Colors.black54,
                  Colors.black,
                ],
                stops: [0.0, 0.15, 0.45, 0.8, 1.0],
              ),
            ),
            child: movie.posterUrl != null && movie.posterUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, url) =>
                        Container(color: AppColors.darkCard),
                    errorWidget: (_, url, error) =>
                        Container(color: AppColors.darkCard),
                  )
                : Container(color: AppColors.darkCard),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(ImagePaths.netflixIcon, height: 57, width: 53),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'TV Shows',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Movies',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'My List',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: const Text(
                      'TOP\n10',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 6,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white,
                        height: 0.9,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '#2 in Nigeria Today',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ],
    );
  }
}

class _MyListIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MyListIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionRailHeader extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionRailHeader({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _MovieSection extends StatelessWidget {
  final String title;
  final List<dynamic> movies;
  final double cardWidth;
  final double cardHeight;
  final Widget? customRail;

  const _MovieSection({
    required this.title,
    required this.movies,
    this.cardWidth = 103,
    this.cardHeight = 161,
    this.customRail,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return _SectionRailHeader(
      title: title,
      child:
          customRail ??
          _MovieCardRail(
            movies: movies,
            cardWidth: cardWidth,
            cardHeight: cardHeight,
          ),
    );
  }
}

class _PreviewsRail extends StatelessWidget {
  final List<dynamic> movies;

  const _PreviewsRail({required this.movies});

  @override
  Widget build(BuildContext context) {
    return CmHorizontalListViewWidget<dynamic>(
      items: movies,
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      itemBuilder: (context, movie, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: 102,
            height: 102,
            margin: const EdgeInsets.only(right: 10),
            child: CustomMovieImage(
              movie: movie,
              width: 102,
              height: 102,
              isCircle: true,
            ),
          ),
        );
      },
    );
  }
}

class _ContinueWatchingRail extends StatelessWidget {
  final List<dynamic> movies;

  const _ContinueWatchingRail({required this.movies});

  @override
  Widget build(BuildContext context) {
    return CmHorizontalListViewWidget<dynamic>(
      items: movies,
      height: 161,
      itemBuilder: (context, movie, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: 103,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: Column(
              children: [
                Expanded(
                  child: CustomMovieImage(
                    movie: movie,
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: 4,
                  ),
                ),
                LinearProgressIndicator(
                  value: ((index % 4) + 3) / 10.0,
                  backgroundColor: Colors.grey[800],
                  color: AppColors.netflixRed,
                  minHeight: 3,
                ),
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.info_outline,
                          color: AppColors.white,
                          size: 25,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Options for ${movie.displayTitle}',
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.more_vert,
                          color: AppColors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MovieCard extends StatelessWidget {
  final dynamic movie;
  final double width;
  final double height;

  const _MovieCard({required this.movie, this.width = 103, this.height = 161});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            CustomMovieImage(movie: movie, width: width, height: height),
          ],
        ),
      ),
    );
  }
}

class _MovieCardRail extends StatelessWidget {
  final List<dynamic> movies;
  final double cardWidth;
  final double cardHeight;

  const _MovieCardRail({
    required this.movies,
    this.cardWidth = 103,
    this.cardHeight = 161,
  });

  @override
  Widget build(BuildContext context) {
    return CmHorizontalListViewWidget<dynamic>(
      items: movies,
      height: cardHeight,
      itemBuilder: (context, movie, index) {
        return _MovieCard(movie: movie, width: cardWidth, height: cardHeight);
      },
    );
  }
}
