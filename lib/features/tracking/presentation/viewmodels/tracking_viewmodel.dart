import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/entities/delivery_state_entity.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../../data/repositories/tracking_repository_impl.dart';
import '../../domain/usecases/tracking_usecases.dart';

part 'tracking_viewmodel.g.dart';

@riverpod
TrackingRepository trackingRepository(TrackingRepositoryRef ref) {
  return TrackingRepositoryImpl();
}

class TrackingState {
  final AsyncValue<DeliveryStateEntity> deliveryState;
  final AsyncValue<List<LocationEntity>> route;
  final LocationEntity? currentLocation;

  TrackingState({
    required this.deliveryState,
    required this.route,
    this.currentLocation,
  });

  TrackingState copyWith({
    AsyncValue<DeliveryStateEntity>? deliveryState,
    AsyncValue<List<LocationEntity>>? route,
    LocationEntity? currentLocation,
  }) {
    return TrackingState(
      deliveryState: deliveryState ?? this.deliveryState,
      route: route ?? this.route,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}

@riverpod
class TrackingViewModel extends _$TrackingViewModel {
  StreamSubscription<LocationEntity>? _locationSub;

  @override
  TrackingState build() {
    _fetchInitialData();
    
    ref.onDispose(() {
      _locationSub?.cancel();
    });

    return TrackingState(
      deliveryState: const AsyncValue.loading(),
      route: const AsyncValue.loading(),
    );
  }

  Future<void> _fetchInitialData() async {
    // Fetch route
    try {
      final route = await ref.read(getRoutePathProvider).call();
      state = state.copyWith(route: AsyncValue.data(route));
    } catch (e, st) {
      state = state.copyWith(route: AsyncValue.error(e, st));
    }

    // Fetch delivery state stream
    ref.read(getDeliveryStateStreamProvider).call().listen(
      (data) {
        state = state.copyWith(deliveryState: AsyncValue.data(data));
      },
      onError: (e, st) {
        state = state.copyWith(deliveryState: AsyncValue.error(e, st));
      },
    );

    // Listen to live location
    _locationSub = ref.read(getLiveLocationStreamProvider).call().listen((location) {
      state = state.copyWith(currentLocation: location);
    });
  }
}
