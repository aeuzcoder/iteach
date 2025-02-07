import 'package:get_it/get_it.dart';
import 'package:iteach/feature/data/repo/user_repo_impl.dart';
import 'package:iteach/feature/domain/repository/user_repo.dart';

final sl = GetIt.instance;

init() {
  //Repository
  sl.registerLazySingleton<UserRepo>(() => UserRepoImpl());
}
