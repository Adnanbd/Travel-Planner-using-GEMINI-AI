import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/connection/gemini.ai.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';
import 'package:gemini_ai_testing/modules/home/view/helper/is.validate.dart';

class HitApiButton extends ConsumerWidget {
  const HitApiButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton.filled(
      color: Colors.white,
      style: IconButton.styleFrom(backgroundColor: const Color.fromARGB(255, 88, 199, 160)),
      onPressed: !ref.watch(isConnectionButtonLoading)
          ? () async {
              if (isValidate(ref)) {
                ref.read(isConnectionButtonLoading.notifier).state = true;
                final res = await generateContent(ref);
                ref.read(isConnectionButtonLoading.notifier).state = false;
                ref.read(resultP.notifier).state = res;
              }
            }
          : null,
      icon: ref.watch(isConnectionButtonLoading)
          ? const Padding(
              padding: EdgeInsets.all(10.0),
              child: SizedBox(
                height: 14.0,
                width: 14.0,
                child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white),
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.arrow_forward_ios_rounded),
            ),
    );
  }
}
