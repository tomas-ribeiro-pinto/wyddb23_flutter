// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

List<Faq> faqFromJson(String str) => List<Faq>.from(json.decode(str).map((x) => Faq.fromJson(x)));

String faqToJson(List<Faq> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faq {
    int id;
    String questionEn;
    String answerEn;
    String questionPt;
    String answerPt;
    String questionEs;
    String answerEs;
    String questionIt;
    String answerIt;
    DateTime createdAt;
    DateTime updatedAt;

    Faq({
        required this.id,
        required this.questionEn,
        required this.answerEn,
        required this.questionPt,
        required this.answerPt,
        required this.questionEs,
        required this.answerEs,
        required this.questionIt,
        required this.answerIt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        id: json["id"],
        questionEn: json["question_en"],
        answerEn: json["answer_en"],
        questionPt: json["question_pt"],
        answerPt: json["answer_pt"],
        questionEs: json["question_es"],
        answerEs: json["answer_es"],
        questionIt: json["question_it"],
        answerIt: json["answer_it"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question_en": questionEn,
        "answer_en": answerEn,
        "question_pt": questionPt,
        "answer_pt": answerPt,
        "question_es": questionEs,
        "answer_es": answerEs,
        "question_it": questionIt,
        "answer_it": answerIt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };


    String getTranslatedQuestionAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          return questionEn;
        case 'pt':
          return questionPt;
        case 'es':
          return questionEs;
        case 'it':
          return questionIt;
      }

      return questionEn;
    }

    String getTranslatedAnswerAttribute(String locale)
    {
      switch (locale) {
        case 'en':
          return answerEn;
        case 'pt':
          return answerPt;
        case 'es':
          return answerEs;
        case 'it':
          return answerIt;
      }

      return answerEn;
    }
}
