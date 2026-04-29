import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/home_repository.dart';
import '../../data/repositories/home_repository_impl.dart';

part 'home_viewmodel.g.dart';

// Provides the repository. In a real app, you might inject this differently
// or place it in a core dependency injection file.
@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl();
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<String> build() async {
    return "Welcome to MVVM + Clean Architecture!";
  }

  Future<void> fetchData() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(homeRepositoryProvider);
      final message = await repository.getMessage();
      state = AsyncValue.data(message.text);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
