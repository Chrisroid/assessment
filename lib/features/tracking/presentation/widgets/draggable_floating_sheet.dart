import 'package:flutter/material.dart';

class DraggableFloatingSheet extends StatefulWidget {
  final Widget child;

  const DraggableFloatingSheet({super.key, required this.child});

  @override
  State<DraggableFloatingSheet> createState() => _DraggableFloatingSheetState();
}

class _DraggableFloatingSheetState extends State<DraggableFloatingSheet> {
  Offset? position;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      left: position?.dx ?? 0,
      top: position?.dy,
      bottom: position == null ? 0 : null,
      width: screenSize.width,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            if (position == null) {
              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              position = renderBox.localToGlobal(Offset.zero) + details.delta;
            } else {
              position = position! + details.delta;
            }
          });
        },
        child: widget.child,
      ),
    );
  }
}
