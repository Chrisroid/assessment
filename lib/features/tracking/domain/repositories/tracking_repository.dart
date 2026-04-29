import '../entities/location_entity.dart';
import '../entities/delivery_state_entity.dart';

abstract class TrackingRepository {
  Stream<LocationEntity> getLiveLocationStream();
  Future<List<LocationEntity>> getRoutePath();
  Stream<DeliveryStateEntity> getDeliveryStateStream();
}
