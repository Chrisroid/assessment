import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/location_entity.dart';

class TrackingMap extends StatelessWidget {
  final List<LocationEntity> route;
  final LocationEntity? currentLocation;
  final bool isDarkMode;

  const TrackingMap({
    super.key,
    required this.route,
    this.currentLocation,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    if (route.isEmpty) return const SizedBox.shrink();

    final polylinePoints = route.map((loc) => LatLng(loc.latitude, loc.longitude)).toList();
    final destination = polylinePoints.last;

    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(39.15, -77.0), // Approximate center of the route
        initialZoom: 9.5,
      ),
      children: [
        TileLayer(
          urlTemplate: isDarkMode
              ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png'
              : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: isDarkMode ? const ['a', 'b', 'c', 'd'] : const [],
          userAgentPackageName: 'com.chrisroid.assessment',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: polylinePoints,
              strokeWidth: 6.0,
              color: Colors.deepOrange,
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            // Destination Marker
            Marker(
              point: destination,
              width: 40,
              height: 40,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.location_on, color: Colors.red, size: 30),
              ),
            ),
            // Courier Marker (Animated smoothly via the ViewModel's 30fps stream)
            if (currentLocation != null)
              Marker(
                point: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                width: 50,
                height: 50,
                child: Transform.rotate(
                  angle: currentLocation!.heading * (3.14159 / 180),
                  child:  Image.asset(
                    'assets/images/marker.png',
                    fit: BoxFit.contain,
                    // Fallback icon in case the image isn't loaded yet or is missing
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.motorcycle, color: Colors.deepOrange, size: 24),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
