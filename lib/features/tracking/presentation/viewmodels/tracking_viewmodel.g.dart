// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trackingRepositoryHash() =>
    r'e81c05b559ca57993d3445b59fa5a187429e60c7';

/// See also [trackingRepository].
@ProviderFor(trackingRepository)
final trackingRepositoryProvider =
    AutoDisposeProvider<TrackingRepository>.internal(
      trackingRepository,
      name: r'trackingRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$trackingRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TrackingRepositoryRef = AutoDisposeProviderRef<TrackingRepository>;
String _$trackingViewModelHash() => r'7cade93de52fc5bc4e6cb6b06157944d8efe81de';

/// See also [TrackingViewModel].
@ProviderFor(TrackingViewModel)
final trackingViewModelProvider =
    AutoDisposeNotifierProvider<TrackingViewModel, TrackingState>.internal(
      TrackingViewModel.new,
      name: r'trackingViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$trackingViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TrackingViewModel = AutoDisposeNotifier<TrackingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
