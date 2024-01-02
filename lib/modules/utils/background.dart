import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackgroundContainer extends ConsumerWidget {
  const BackgroundContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height,
      width: mq.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Color.fromARGB(101, 198, 198, 198),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
