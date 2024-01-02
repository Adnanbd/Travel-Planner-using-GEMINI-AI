import 'dart:convert';

class GeminiAiResponseModel {
    final List<Candidate>? candidates;
    final PromptFeedback? promptFeedback;

    GeminiAiResponseModel({
        this.candidates,
        this.promptFeedback,
    });

    GeminiAiResponseModel copyWith({
        List<Candidate>? candidates,
        PromptFeedback? promptFeedback,
    }) => 
        GeminiAiResponseModel(
            candidates: candidates ?? this.candidates,
            promptFeedback: promptFeedback ?? this.promptFeedback,
        );

    factory GeminiAiResponseModel.fromRawJson(String str) => GeminiAiResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GeminiAiResponseModel.fromJson(Map<String, dynamic> json) => GeminiAiResponseModel(
        candidates: json["candidates"] == null ? [] : List<Candidate>.from(json["candidates"]!.map((x) => Candidate.fromJson(x))),
        promptFeedback: json["promptFeedback"] == null ? null : PromptFeedback.fromJson(json["promptFeedback"]),
    );

    Map<String, dynamic> toJson() => {
        "candidates": candidates == null ? [] : List<dynamic>.from(candidates!.map((x) => x.toJson())),
        "promptFeedback": promptFeedback?.toJson(),
    };
}

class Candidate {
    final Content? content;
    final String? finishReason;
    final int? index;
    final List<SafetyRating>? safetyRatings;

    Candidate({
        this.content,
        this.finishReason,
        this.index,
        this.safetyRatings,
    });

    Candidate copyWith({
        Content? content,
        String? finishReason,
        int? index,
        List<SafetyRating>? safetyRatings,
    }) => 
        Candidate(
            content: content ?? this.content,
            finishReason: finishReason ?? this.finishReason,
            index: index ?? this.index,
            safetyRatings: safetyRatings ?? this.safetyRatings,
        );

    factory Candidate.fromRawJson(String str) => Candidate.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        content: json["content"] == null ? null : Content.fromJson(json["content"]),
        finishReason: json["finishReason"],
        index: json["index"],
        safetyRatings: json["safetyRatings"] == null ? [] : List<SafetyRating>.from(json["safetyRatings"]!.map((x) => SafetyRating.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "content": content?.toJson(),
        "finishReason": finishReason,
        "index": index,
        "safetyRatings": safetyRatings == null ? [] : List<dynamic>.from(safetyRatings!.map((x) => x.toJson())),
    };
}

class Content {
    final List<Part>? parts;
    final String? role;

    Content({
        this.parts,
        this.role,
    });

    Content copyWith({
        List<Part>? parts,
        String? role,
    }) => 
        Content(
            parts: parts ?? this.parts,
            role: role ?? this.role,
        );

    factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: json["parts"] == null ? [] : List<Part>.from(json["parts"]!.map((x) => Part.fromJson(x))),
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "parts": parts == null ? [] : List<dynamic>.from(parts!.map((x) => x.toJson())),
        "role": role,
    };
}

class Part {
    final String? text;

    Part({
        this.text,
    });

    Part copyWith({
        String? text,
    }) => 
        Part(
            text: text ?? this.text,
        );

    factory Part.fromRawJson(String str) => Part.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Part.fromJson(Map<String, dynamic> json) => Part(
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
    };
}

class SafetyRating {
    final String? category;
    final String? probability;

    SafetyRating({
        this.category,
        this.probability,
    });

    SafetyRating copyWith({
        String? category,
        String? probability,
    }) => 
        SafetyRating(
            category: category ?? this.category,
            probability: probability ?? this.probability,
        );

    factory SafetyRating.fromRawJson(String str) => SafetyRating.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SafetyRating.fromJson(Map<String, dynamic> json) => SafetyRating(
        category: json["category"],
        probability: json["probability"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "probability": probability,
    };
}

class PromptFeedback {
    final List<SafetyRating>? safetyRatings;

    PromptFeedback({
        this.safetyRatings,
    });

    PromptFeedback copyWith({
        List<SafetyRating>? safetyRatings,
    }) => 
        PromptFeedback(
            safetyRatings: safetyRatings ?? this.safetyRatings,
        );

    factory PromptFeedback.fromRawJson(String str) => PromptFeedback.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PromptFeedback.fromJson(Map<String, dynamic> json) => PromptFeedback(
        safetyRatings: json["safetyRatings"] == null ? [] : List<SafetyRating>.from(json["safetyRatings"]!.map((x) => SafetyRating.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "safetyRatings": safetyRatings == null ? [] : List<dynamic>.from(safetyRatings!.map((x) => x.toJson())),
    };
}
