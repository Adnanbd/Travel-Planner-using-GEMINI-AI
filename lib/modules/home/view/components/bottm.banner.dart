import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBanner extends ConsumerWidget {
  const BottomBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              decoration: const BoxDecoration(
                color: Color.fromARGB(122, 255, 255, 255),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              child: const Text(
                'Made with 🩵 Flutter & Gemini AI',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            );
  }
}