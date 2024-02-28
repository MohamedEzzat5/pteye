import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:pteye/Features/auth/presentation/manger/register_cubit/register_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! features
  //Blocs
  sl.registerFactory(() => RegisterCubit(authRepo: sl(), networkInfo: sl()));
  sl.registerFactory(() => LoginCubit(authRepo: sl(), networkInfo: sl()));

  //use Cases
  // sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
  // Repository
    sl.registerLazySingleton<AuthRepo>(() => AuthRepoImplementation());
  //Data Sources
  // sl.registerLazySingleton<RandomQuoteLocalDataSource>(() => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  // sl.registerLazySingleton<RandomQuoteRemoteDataSource>(() => RandomQuoteRemoteDataSourceImpl(client:  sl()));

//!core
  //network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));


//! External
final sharedPreferences = await SharedPreferences.getInstance();
sl.registerLazySingleton(() => sharedPreferences);
sl.registerLazySingleton(() => InternetConnectionChecker());
}