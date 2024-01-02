import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/modules/home/components/d.container.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';

class DaysPicker extends ConsumerWidget {
  const DaysPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = ref.watch(daysP);
    return DContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          items: List.generate(10, (index) => index + 1).map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (v) {
            //log('Days: $v');
            ref.read(daysP.notifier).state = v!;
          },
          value: days,
        ),
      ),
    );
  }
}
