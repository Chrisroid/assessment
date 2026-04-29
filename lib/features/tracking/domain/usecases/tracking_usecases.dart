import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/tracking_repository.dart';
import '../entities/location_entity.dart';
import '../entities/delivery_state_entity.dart';
import '../../presentation/viewmodels/tracking_viewmodel.dart'; // To access the repository provider

class GetRoutePath {
  final TrackingRepository _repository;
  GetRoutePath(this._repository);

  Future<List<LocationEntity>> call() => _repository.getRoutePath();
}

class GetLiveLocationStream {
  final TrackingRepository _repository;
  GetLiveLocationStream(this._repository);

  Stream<LocationEntity> call() => _repository.getLiveLocationStream();
}

class GetDeliveryStateStream {
  final TrackingRepository _repository;
  GetDeliveryStateStream(this._repository);

  Stream<DeliveryStateEntity> call() => _repository.getDeliveryStateStream();
}

final getRoutePathProvider = Provider((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return GetRoutePath(repository);
});

final getLiveLocationStreamProvider = Provider((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return GetLiveLocationStream(repository);
});

final getDeliveryStateStreamProvider = Provider((ref) {
  final repository = ref.watch(trackingRepositoryProvider);
  return GetDeliveryStateStream(repository);
});
