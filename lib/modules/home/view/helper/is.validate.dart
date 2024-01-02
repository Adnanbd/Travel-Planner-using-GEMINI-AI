import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';
import 'package:gemini_ai_testing/utls/bd.location.dart';

bool isValidate(WidgetRef ref) {
  final from = ref.read(fromP);
  final to = ref.read(toP);
  if (allLocations.contains(from) && allLocations.contains(to)) {
    ref.read(fromValidate.notifier).state = true;
    ref.read(toValidate.notifier).state = true;
    return true;
  } else if (!allLocations.contains(from) && !allLocations.contains(to)) {
    ref.read(fromValidate.notifier).state = false;
    ref.read(toValidate.notifier).state = false;
    return false;
  } else if (!allLocations.contains(from)) {
    ref.read(fromValidate.notifier).state = false;
    ref.read(toValidate.notifier).state = true;
    return false;
  } else if (!allLocations.contains(to)) {
    ref.read(toValidate.notifier).state = false;
     ref.read(fromValidate.notifier).state = true;
    return false;
  }
  return false;
}
