import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/connection/gemini.ai.dart';
import 'package:gemini_ai_testing/modules/Painter/blurred.bg.dart';
import 'package:gemini_ai_testing/modules/home/components/d.container.dart';
import 'package:gemini_ai_testing/modules/home/components/location.picker.dart';
import 'package:gemini_ai_testing/modules/home/model/data.dart';
import 'package:gemini_ai_testing/modules/home/provider/connection.p.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';
import 'package:gemini_ai_testing/modules/home/view/helper/is.validate.dart';
import 'package:gemini_ai_testing/modules/utils/background.dart';
import 'package:gemini_ai_testing/modules/utils/glass_container_v2.withSize.v1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mq = MediaQuery.of(context).size;
    final days = ref.watch(daysP);
    final vType = ref.watch(vTypeP);
    final result = ref.watch(resultP);
    // final days = ref.watch(daysP);
    // final days = ref.watch(daysP);
    double pickerWidth = 350;
    print(mq.width);
    if (mq.width <= 400) {
      pickerWidth = 150;
    } else if (mq.width <= 500) {
      pickerWidth = 200;
    } else if (mq.width <= 800) {
      pickerWidth = 250;
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 76, 156),
      body: Stack(
        children: [
          CustomPaint(
            painter: CirclePainter(),
            child: SizedBox(
              height: mq.height,
              width: mq.width,
            ),
          ),
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/bg.png',
          //     repeat: ImageRepeat.repeat,
          //   ),
          // ),
          const BackgroundContainer(),
          FrostedGlassBoxV2WithSize(
            theChild: Container(
              alignment: Alignment.center,
              height: mq.height,
              width: mq.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PLAN MY TRIP',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 55,
                      shadows: [
                        const Shadow(
                          color: Color.fromARGB(255, 57, 56, 56), // Choose the color of the shadow
                          blurRadius: 2.0, // Adjust the blur radius for the shadow effect
                          offset: Offset(2.0, 2.0), // Set the horizontal and vertical offset for the shadow
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 20,
                    children: [
                      SizedBox(
                        width: pickerWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DContainer(
                              child: LocationPicker(
                                hinttext: 'From (Ex: Dhaka)',
                                onSubmitted: (v) {
                                  log('From : $v');
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
                      ),
                      SizedBox(
                        width: pickerWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DContainer(
                              child: LocationPicker(
                                hinttext: 'To (Ex: Coxsbazar)',
                                onSubmitted: (v) {
                                  log('To : $v');
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
                      ),
                      DContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: List.generate(10, (index) => index + 1).map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value'),
                              );
                            }).toList(),
                            onChanged: (v) {
                              log('Days: $v');
                              ref.read(daysP.notifier).state = v!;
                            },
                            value: days,
                          ),
                        ),
                      ),
                      DContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<VehicleType>(
                            items: VehicleType.values.map((VehicleType value) {
                              return DropdownMenuItem<VehicleType>(
                                value: value,
                                child: Text(value.name.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (v) {
                              log('Days: $v');

                              ref.read(vTypeP.notifier).state = v!;
                            },
                            value: vType,
                          ),
                        ),
                      ),
                      IconButton.filled(
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
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  AnimatedSwitcher(
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
                                          child: SelectableText(result.candidates?.first.content?.parts?.first.text ??
                                              'No Result, Try Again Later!'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    bottom: 60,
                                    child: Tooltip(
                                      message: 'Another Result',
                                      preferBelow: false,
                                      child: IconButton.filled(
                                        style: IconButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(255, 88, 199, 160)),
                                        onPressed: () async {
                                          ref.read(isConnectionButtonLoading.notifier).state = true;
                                          final res = await generateContent(ref);
                                          ref.read(isConnectionButtonLoading.notifier).state = false;
                                          ref.read(resultP.notifier).state = res;
                                        },
                                        icon: const Icon(
                                          Icons.refresh_outlined,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    bottom: 10,
                                    child: Tooltip(
                                      message: 'Copy Result',
                                      child: IconButton.filled(
                                        style: IconButton.styleFrom(
                                            backgroundColor: const Color.fromARGB(255, 88, 199, 160)),
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                                  text: "${result.candidates?.first.content?.parts?.first.text}"))
                                              .then((value) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(content: Text("Copied!")));
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.copy,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            width: mq.width,
          ),
          Positioned(
            bottom: 0,
            right: 100,
            child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
