import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:iteach/core/services/network_info.dart';
import 'package:iteach/feature/data/repo/user_repo_impl.dart';
import 'package:iteach/feature/domain/repository/user_repo.dart';

final sl = GetIt.instance;

init() {
  //Repository
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl(networkInfo: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  //External
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}
