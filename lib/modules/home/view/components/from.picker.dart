import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/modules/home/components/d.container.dart';
import 'package:gemini_ai_testing/modules/home/components/location.picker.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';

class FromPicker extends ConsumerWidget {
  final double pickerWidth;
  const FromPicker({
    super.key,
    required this.pickerWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: pickerWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DContainer(
            child: LocationPicker(
              hinttext: 'From (Ex: Dhaka)',
              onSubmitted: (v) {
                //log('From : $v');
                ref.read(fromP.notifier).state = v;
              },
              selelctedItem: ref.watch(fromP),
            ),
          ),
          ref.watch(fromValidate)
              ? const SizedBox()
              : const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    'Please select a location',
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
