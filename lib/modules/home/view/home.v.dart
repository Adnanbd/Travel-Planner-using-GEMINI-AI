import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/modules/Painter/blurred.bg.dart';
import 'package:gemini_ai_testing/modules/home/view/components/bottm.banner.dart';
import 'package:gemini_ai_testing/modules/home/view/components/buttons/hit.api.button.dart';
import 'package:gemini_ai_testing/modules/home/view/components/days.picker.dart';
import 'package:gemini_ai_testing/modules/home/view/components/from.picker.dart';
import 'package:gemini_ai_testing/modules/home/view/components/result.v.dart';
import 'package:gemini_ai_testing/modules/home/view/components/to.picker.dart';
import 'package:gemini_ai_testing/modules/home/view/components/vehicle.picker.dart';
import 'package:gemini_ai_testing/modules/utils/background.dart';
import 'package:gemini_ai_testing/modules/utils/glass_container_v2.withSize.v1.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mq = MediaQuery.of(context).size;
    double pickerWidth = 350;
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
                      FromPicker(pickerWidth: pickerWidth),
                      ToPicker(pickerWidth: pickerWidth),
                      const DaysPicker(),
                      const VehiclePicker(),
                      const HitApiButton(),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const ResultView(),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            width: mq.width,
          ),
          const Positioned(
            bottom: 0,
            right: 100,
            child: BottomBanner(),
          ),
        ],
      ),
    );
  }
}
