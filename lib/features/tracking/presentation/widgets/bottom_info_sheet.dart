import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/design_system.dart';
import '../../domain/entities/delivery_state_entity.dart';

class BottomInfoSheet extends ConsumerWidget {
  final DeliveryStateEntity state;

  const BottomInfoSheet({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ds = ref.watch(designSystemProvider);
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ETA Message
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: Colors.black54, size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    state.etaMessage,
                    style: ds.typography.caption.copyWith(
                      color: ds.colors.textPrimary.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Courier Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
            decoration: BoxDecoration(
              color: ds.colors.textSecondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(state.courierAvatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.courierName,
                            style: ds.typography.heading,
                          ),
                          Text(
                            state.courierRole,
                            style: ds.typography.subtitle,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ds.colors.activeIndicator,
                        foregroundColor: ds.colors.background,
                        elevation: 0,
                        padding: const EdgeInsets.only(
                          left: 6,
                          right: 16,
                          top: 4,
                          bottom: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: ds.colors.background,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.phone_outlined,
                              size: 16,
                              color: ds.colors.activeIndicator,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Call',
                            style: ds.typography.title.copyWith(
                              color: ds.colors.background,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Timeline
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ID',
                                style: ds.typography.caption,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.orderId,
                                style: ds.typography.title,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: ds.colors.badgeBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor: ds.colors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'On Delivery',
                                  style: ds.typography.body.copyWith(
                                    color: ds.colors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Timeline steps
                      _buildTimelineStep(
                        ds,
                        isActive: true,
                        title: 'On Delivery',
                        subtitle: 'Courier is delivering the package',
                        time: '10:47 AM',
                        date: '18 Jan, 2026',
                        isLast: false,
                      ),
                      _buildTimelineStep(
                        ds,
                        isActive: false,
                        title: 'Delivered',
                        subtitle: state.destinationAddress,
                        time: '---------',
                        date: '---------',
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            height: 4,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    DesignSystem ds, {
    required bool isActive,
    required String title,
    required String subtitle,
    required String time,
    required String date,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Image.asset(
              isActive ? 'assets/images/isActive.png' : 'assets/images/notActive.png',
              width: 24,
              height: 24,
            ),
            if (!isLast)
              Container(width: 2, height: 40, color: ds.colors.inactiveIndicator),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: ds.typography.caption.copyWith(
                  color: isActive ? ds.colors.textPrimary : ds.colors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: ds.typography.title.copyWith(
                  color: isActive ? ds.colors.textPrimary : ds.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: ds.typography.caption,
            ),
            Text(
              date,
              style: ds.typography.title.copyWith(
                fontSize: isActive ? 14 : 12,
                color: isActive ? ds.colors.textPrimary : ds.colors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
