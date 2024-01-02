import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai_testing/connection/model/gemini.ai.reponse.model.dart';
import 'package:gemini_ai_testing/modules/home/provider/home.p.dart';
import 'package:gemini_ai_testing/modules/utils/utils.dart';
import 'package:http/http.dart' as http;

Future<GeminiAiResponseModel?> generateContent(WidgetRef ref) async {
  final days = ref.watch(daysP);
  final vType = ref.watch(vTypeP);
  final from = ref.watch(fromP);
  final to = ref.watch(toP);

  const String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey';

  final Map<String, dynamic> requestBody = {
    "contents": [
      {
        "parts": [
          {
            "text":
                "Please make a detailed custom travel plan for me based on following information. I want to travel from $from to $to by ${vType.name}. I have total for $days days for travel. Give me a detailed schedule with specific timeline. Please include the return trip. Please avoid additional stops before destination unless its a lunch or snacks break. And, List down the best places to visit there. Give me some tips and hacks based on my destination and vehicle type."
          }
        ]
      }
    ]
  };
  print('Request Body: $requestBody');

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    log('API Response: ${response.body}');
    final data = response.body;
    return GeminiAiResponseModel.fromJson(jsonDecode(data));
  } else {
    log('Error: ${response.statusCode}');
    log('API Response: ${response.body}');
    return null;
  }
}
