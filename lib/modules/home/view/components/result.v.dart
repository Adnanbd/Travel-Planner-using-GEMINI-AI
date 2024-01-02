import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/connection/gemini.ai.dart';
import 'package:gemini_ai_testing/modules/home/components/d.container.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';
import 'package:gemini_ai_testing/modules/home/view/components/buttons/float.btn.dart';
import 'package:lottie/lottie.dart';

class ResultView extends ConsumerWidget {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mq = MediaQuery.of(context).size;
    final result = ref.watch(resultP);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: ref.watch(isConnectionButtonLoading)
          ? Padding(
              padding: const EdgeInsets.all(0.0),
              child: Lottie.asset(
                'assets/loader-new.json',
                height: mq.height * .6,
                fit: BoxFit.contain,
              ),
            )
          : result == null
              ? const SizedBox()
              : Stack(
                  children: [
                    SizedBox(
                      height: mq.height * .6,
                      child: DContainer(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: SelectableText(
                                result.candidates?.first.content?.parts?.first.text ?? 'No Result, Try Again Later!'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 30,
                      bottom: 60,
                      child: FloatButton(
                        icon: Icons.refresh,
                        onPressed: () async {
                          ref.read(isConnectionButtonLoading.notifier).state = true;
                          final res = await generateContent(ref);
                          ref.read(isConnectionButtonLoading.notifier).state = false;
                          ref.read(resultP.notifier).state = res;
                        },
                        tooltip: 'Another Result',
                      ),
                    ),
                    Positioned(
                      right: 30,
                      bottom: 10,
                      child: FloatButton(
                        icon: Icons.copy,
                        onPressed: () async {
                          await Clipboard.setData(
                                  ClipboardData(text: "${result.candidates?.first.content?.parts?.first.text}"))
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Copied!")));
                          });
                        },
                        tooltip: 'Copy Result',
                      ),
                    ),
                  ],
                ),
    );
  }
}
