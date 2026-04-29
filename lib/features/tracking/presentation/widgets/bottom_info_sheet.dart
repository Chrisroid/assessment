import 'package:flutter/material.dart';
import '../../domain/entities/delivery_state_entity.dart';

class BottomInfoSheet extends StatelessWidget {
  final DeliveryStateEntity state;

  const BottomInfoSheet({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
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
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 18 / 12,
                      // line-height: 18px
                      color: Color(0xE51B1C1E),
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
              color: Color(0xffd1d2d2).withAlpha(26),
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
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xFF1B1C1E),
                            ),
                          ),
                          Text(
                            state.courierRole,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFFB3B3B4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF4500),
                        // Bright Orange
                        foregroundColor: Colors.white,
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
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.phone_outlined,
                              size: 16,
                              color: Color(0xFFFF4500),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Call',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
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
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFFB3B3B4),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.orderId,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFF1B1C1E),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffF5811F).withAlpha(12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Color(0xfff5811f),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'On Delivery',
                                  style: TextStyle(
                                    color: Color(0xfff5811f),
                                    fontSize: 12,
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
                        isActive: true,
                        title: 'On Delivery',
                        subtitle: 'Courier is delivering the package',
                        time: '10:47 AM',
                        date: '18 Jan, 2026',
                        isLast: false,
                      ),
                      _buildTimelineStep(
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

  Widget _buildTimelineStep({
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
              Container(width: 2, height: 40, color: Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color:  const Color(0xFFB3B3B4),
                  fontWeight: FontWeight.w400,
                  fontSize:  12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Inter',
                  color:  const Color(0xFF1B1C1E) ,
                  fontWeight: FontWeight.w500 ,
                  fontSize: 14,
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
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFFB3B3B4),
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight:  FontWeight.w500 ,
                fontSize: isActive ? 14 : 12,
                color:  const Color(0xFF1B1C1E) ,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
