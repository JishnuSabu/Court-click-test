import 'package:cached_network_image/cached_network_image.dart';
import 'package:court_click_task/bloc/search/search_bloc.dart';
import 'package:court_click_task/bloc/search/search_event.dart';
import 'package:court_click_task/bloc/search/search_state.dart';
import 'package:court_click_task/screens/widget/search_list_item.dart';
import 'package:court_click_task/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Container(
              height: 52,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 8),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: AppColors.white),
                  onChanged: (query) {
                    context.read<SearchBloc>().add(SearchQueryChanged(query));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for a show, movie, genre, etc.',
                    hintStyle: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.greyText,
                      size: 24,
                    ),
                    suffixIcon: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _searchController,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (value.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColors.greyText,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<SearchBloc>().add(
                                    const ClearSearch(),
                                  );
                                },
                              ),
                            const Icon(
                              Icons.mic,
                              color: AppColors.greyText,
                              size: 20,
                            ),
                          ],
                        );
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 18,
                        color: AppColors.white,
                      ),
                    );
                  }

                  if (state is SearchInitial) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Text(
                            'Top Searches',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.topSearches.length,
                            itemBuilder: (context, index) {
                              final movie = state.topSearches[index];
                              return SearchListItem(movie: movie);
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is SearchEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: AppColors.greyText,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Oh, we don\'t have that title.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Try searching for another movie or show.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyText,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline_rounded,
                              size: 64,
                              color: AppColors.netflixRed,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.greyText,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.netflixRed,
                              ),
                              onPressed: () {
                                context.read<SearchBloc>().add(
                                  SearchQueryChanged(_searchController.text),
                                );
                              },
                              child: const Text(
                                'Retry Search',
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is SearchLoaded) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: movie.posterUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, url) =>
                                  Container(color: AppColors.darkCard),
                              errorWidget: (_, url, error) => Container(
                                color: AppColors.darkCard,
                                child: const Icon(
                                  Icons.movie,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
