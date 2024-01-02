import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/modules/home/components/d.container.dart';
import 'package:gemini_ai_testing/modules/home/components/location.picker.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';

class ToPicker extends ConsumerWidget {
  final double pickerWidth;
  const ToPicker({
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
              hinttext: 'To (Ex: Coxsbazar)',
              onSubmitted: (v) {
                //log('To : $v');
                ref.read(toP.notifier).state = v;
              },
              selelctedItem: ref.watch(toP),
            ),
          ),
          ref.watch(toValidate)
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
