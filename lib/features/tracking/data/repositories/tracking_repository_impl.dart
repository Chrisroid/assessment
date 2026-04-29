import 'dart:async';
import 'dart:math' as math;
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/delivery_state_entity.dart';
import '../../domain/repositories/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  // A realistic street route fetched from OSRM (Open Source Routing Machine)
  // Perfectly follows I-70, I-695, and I-97 from Frederick to Annapolis.
  final List<LocationEntity> _route = [
    LocationEntity(latitude: 39.414149, longitude: -77.410515, heading: 0),
    LocationEntity(latitude: 39.401149, longitude: -77.403227, heading: 0),
    LocationEntity(latitude: 39.404511, longitude: -77.350121, heading: 0),
    LocationEntity(latitude: 39.388633, longitude: -77.312638, heading: 0),
    LocationEntity(latitude: 39.380482, longitude: -77.275274, heading: 0),
    LocationEntity(latitude: 39.38152, longitude: -77.259445, heading: 0),
    LocationEntity(latitude: 39.369434, longitude: -77.217978, heading: 0),
    LocationEntity(latitude: 39.370474, longitude: -77.205236, heading: 0),
    LocationEntity(latitude: 39.359071, longitude: -77.172057, heading: 0),
    LocationEntity(latitude: 39.360944, longitude: -77.146825, heading: 0),
    LocationEntity(latitude: 39.354279, longitude: -77.133478, heading: 0),
    LocationEntity(latitude: 39.336041, longitude: -77.041799, heading: 0),
    LocationEntity(latitude: 39.309324, longitude: -76.957287, heading: 0),
    LocationEntity(latitude: 39.302125, longitude: -76.908489, heading: 0),
    LocationEntity(latitude: 39.305301, longitude: -76.884334, heading: 0),
    LocationEntity(latitude: 39.295668, longitude: -76.850185, heading: 0),
    LocationEntity(latitude: 39.297002, longitude: -76.808741, heading: 0),
    LocationEntity(latitude: 39.306995, longitude: -76.787604, heading: 0),
    LocationEntity(latitude: 39.30659, longitude: -76.75195, heading: 0),
    LocationEntity(latitude: 39.271748, longitude: -76.72311, heading: 0),
    LocationEntity(latitude: 39.250719, longitude: -76.680013, heading: 0),
    LocationEntity(latitude: 39.216048, longitude: -76.656384, heading: 0),
    LocationEntity(latitude: 39.20083, longitude: -76.632426, heading: 0),
    LocationEntity(latitude: 39.181962, longitude: -76.633137, heading: 0),
    LocationEntity(latitude: 39.154953, longitude: -76.645844, heading: 0),
    LocationEntity(latitude: 39.131986, longitude: -76.643076, heading: 0),
    LocationEntity(latitude: 39.086062, longitude: -76.624996, heading: 0),
    LocationEntity(latitude: 39.064916, longitude: -76.640921, heading: 0),
    LocationEntity(latitude: 39.040247, longitude: -76.613884, heading: 0),
    LocationEntity(latitude: 39.00953, longitude: -76.611301, heading: 0),
    LocationEntity(latitude: 38.995042, longitude: -76.583383, heading: 0),
    LocationEntity(latitude: 38.984165, longitude: -76.573986, heading: 0),
    LocationEntity(latitude: 38.982568, longitude: -76.55136, heading: 0),
    LocationEntity(latitude: 38.993731, longitude: -76.513966, heading: 0),
    LocationEntity(latitude: 38.978412, longitude: -76.492302, heading: 0),
  ];

  @override
  Future<List<LocationEntity>> getRoutePath() async {
    return _route;
  }

  @override
  Stream<LocationEntity> getLiveLocationStream() async* {
    if (_route.isEmpty) return;

    // Yield initial position immediately
    yield _route.first;

    for (int i = 0; i < _route.length - 1; i++) {
      final start = _route[i];
      final end = _route[i + 1];

      final heading = _calculateBearing(
        start.latitude,
        start.longitude,
        end.latitude,
        end.longitude,
      );

      // Interpolate over 5 seconds per segment at ~30 fps (150 steps)
      // This slows down the marker to a comfortable crawling pace.
      const int steps = 150;
      const stepDuration = Duration(milliseconds: 33);

      for (int step = 1; step <= steps; step++) {
        final t = step / steps;
        final currentLat = start.latitude + (end.latitude - start.latitude) * t;
        final currentLng = start.longitude + (end.longitude - start.longitude) * t;

        yield LocationEntity(
          latitude: currentLat,
          longitude: currentLng,
          heading: heading,
        );
        await Future.delayed(stepDuration);
      }
    }
  }

  @override
  Stream<DeliveryStateEntity> getDeliveryStateStream() async* {
    yield DeliveryStateEntity(
      orderId: 'ORD-682834513',
      courierName: 'Presley Williams',
      courierRole: 'Courier',
      courierAvatarUrl: 'assets/images/courier.jpg',
      etaMessage: 'The package is estimated to arrive within the next 25 minutes.',
      status: DeliveryStatus.onDelivery,
      estimatedTime: DateTime.now().add(const Duration(minutes: 25)),
      destinationAddress: 'Akobo, Ibadan', // Retaining mockup's text
    );
  }

  double _calculateBearing(double startLat, double startLng, double destLat, double destLng) {
    var startLatRad = startLat * (math.pi / 180);
    var startLngRad = startLng * (math.pi / 180);
    var destLatRad = destLat * (math.pi / 180);
    var destLngRad = destLng * (math.pi / 180);

    var y = math.sin(destLngRad - startLngRad) * math.cos(destLatRad);
    var x = math.cos(startLatRad) * math.sin(destLatRad) -
        math.sin(startLatRad) * math.cos(destLatRad) * math.cos(destLngRad - startLngRad);

    var brng = math.atan2(y, x);
    return (brng * 180 / math.pi + 360) % 360;
  }
}
