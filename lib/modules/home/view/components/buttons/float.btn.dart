import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatButton extends ConsumerWidget {
  final Function()? onPressed;
  final String tooltip;
  final IconData icon;
  const FloatButton({
    super.key,
    required this.onPressed,
    required this.tooltip,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: tooltip,
      child: IconButton.filled(
        style: IconButton.styleFrom(backgroundColor: const Color.fromARGB(255, 88, 199, 160)),
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
