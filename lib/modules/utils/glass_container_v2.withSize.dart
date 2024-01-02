import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FrostedGlassBoxV2WithSizeV1 extends ConsumerWidget {
  const FrostedGlassBoxV2WithSizeV1({
    Key? key,
    required this.child,
    required this.width,
  }) : super(key: key);

  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      //borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 100.0,
                sigmaY: 100.0,
              ),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2)),
                    gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.05),
                    ]),
                  ),
                  child: child),
            ),
          ],
        ),
      ),
    );
  }
}
