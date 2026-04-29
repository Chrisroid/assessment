import '../../domain/entities/message.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Message> getMessage() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return Message('Data fetched from Data Layer!');
  }
}
