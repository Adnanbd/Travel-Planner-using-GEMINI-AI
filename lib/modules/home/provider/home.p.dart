import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/connection/model/gemini.ai.reponse.model.dart';
import 'package:gemini_ai_testing/modules/home/model/data.dart';

final daysP = StateProvider<int>((ref) => 1);
final fromP = StateProvider<String?>((ref) => null);
final toP = StateProvider<String?>((ref) => null);
final vTypeP = StateProvider<VehicleType>((ref) => VehicleType.bus);

final resultP = StateProvider<GeminiAiResponseModel?>((ref) => null);

final toValidate = StateProvider<bool>((ref) => true);
final fromValidate = StateProvider<bool>((ref) => true);

final isConnectionButtonLoading = StateProvider.autoDispose((_) => false);

