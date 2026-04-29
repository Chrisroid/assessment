import '../entities/message.dart';

abstract class HomeRepository {
  Future<Message> getMessage();
}
