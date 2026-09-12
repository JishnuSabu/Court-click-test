import 'package:get_it/get_it.dart';
import '../services/api_service.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/search/search_bloc.dart';
import '../bloc/nav/nav_cubit.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<ApiService>(() => ApiService());

  sl.registerFactory<HomeBloc>(() => HomeBloc(apiService: sl<ApiService>()));

  sl.registerFactory<SearchBloc>(
    () => SearchBloc(apiService: sl<ApiService>()),
  );

  sl.registerFactory<NavCubit>(() => NavCubit());
}
