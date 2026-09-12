import 'package:court_click_task/bloc/home/home_bloc.dart';
import 'package:court_click_task/bloc/home/home_event.dart';
import 'package:court_click_task/bloc/nav/nav_cubit.dart';
import 'package:court_click_task/bloc/search/search_bloc.dart';
import 'package:court_click_task/bloc/search/search_event.dart';
import 'package:court_click_task/screens/widget/custom_bottom_nav_bar.dart';
import 'package:court_click_task/utils/constants.dart';
import 'package:court_click_task/utils/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'coming_soon_screen.dart';
import 'downloads_screen.dart';
import 'more_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  late final HomeBloc _homeBloc;
  late final SearchBloc _searchBloc;
  late final NavCubit _navCubit;

  @override
  void initState() {
    super.initState();
    _homeBloc = sl<HomeBloc>()..add(const FetchHomeMovies());
    _searchBloc = sl<SearchBloc>()..add(const FetchTopSearches());
    _navCubit = sl<NavCubit>();
  }

  @override
  void dispose() {
    _homeBloc.close();
    _searchBloc.close();
    _navCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeBloc),
        BlocProvider.value(value: _searchBloc),
        BlocProvider.value(value: _navCubit),
      ],
      child: BlocBuilder<NavCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: IndexedStack(
              index: currentIndex,
              children: const [
                HomeScreen(),
                SearchScreen(),
                ComingSoonScreen(),
                DownloadsScreen(),
                MoreScreen(),
              ],
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<NavCubit>().changeTab(index);
              },
            ),
          );
        },
      ),
    );
  }
}
