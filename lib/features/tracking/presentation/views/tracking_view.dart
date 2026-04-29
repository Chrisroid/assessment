import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/design_system.dart';
import '../viewmodels/tracking_viewmodel.dart';
import '../widgets/tracking_map.dart';
import '../widgets/bottom_info_sheet.dart';
import '../widgets/draggable_floating_sheet.dart';

final mapThemeProvider = StateProvider<bool>((ref) => false);

class TrackingView extends ConsumerWidget {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingState = ref.watch(trackingViewModelProvider);
    final isDarkMode = ref.watch(mapThemeProvider);
    final ds = ref.watch(designSystemProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: ds.colors.background,
              shape: BoxShape.circle,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18, color: ds.colors.textPrimary),
              onPressed: () {},
            ),
          ),
        ),
        title: Text(
          'Live Tracking',
          style: ds.typography.heading,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Map Layer
          trackingState.route.when(
            data: (route) => TrackingMap(
              route: route,
              currentLocation: trackingState.currentLocation,
              isDarkMode: isDarkMode,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error loading route: $err')),
          ),
          
          // Bottom Sheet Layer
          trackingState.deliveryState.when(
            data: (state) => DraggableFloatingSheet(
              child: BottomInfoSheet(state: state),
            ),
            loading: () => const SizedBox.shrink(),
            error: (err, stack) => const SizedBox.shrink(),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: FloatingActionButton(
          mini: true,
          backgroundColor: ds.colors.background,
          onPressed: () {
            ref.read(mapThemeProvider.notifier).state = !isDarkMode;
          },
          child: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: ds.colors.textPrimary,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
