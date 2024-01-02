import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/modules/home/components/d.container.dart';
import 'package:gemini_ai_testing/modules/home/model/data.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';

class VehiclePicker extends ConsumerWidget {
  const VehiclePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vType = ref.watch(vTypeP);
    return DContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<VehicleType>(
          items: VehicleType.values.map((VehicleType value) {
            return DropdownMenuItem<VehicleType>(
              value: value,
              child: Text(value.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (v) {
            //log('Days: $v');

            ref.read(vTypeP.notifier).state = v!;
          },
          value: vType,
        ),
      ),
    );
  }
}
