class Quiz {
  int responseCode;
  List<dynamic> results;

  Quiz({required this.responseCode, required this.results});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(responseCode: json['response_code'], results: json['results']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Results {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String>? allAnswers;

  Results(
      {required this.category,
      required this.type,
      required this.difficulty,
      required this.question,
      required this.correctAnswer,
      this.allAnswers});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
        category: json['category'],
        type: json['type'],
        difficulty: json['difficulty'],
        question: json['question'],
        correctAnswer: json['correct_answer'],
        allAnswers: json['incorrect_answers'].cast<String>().shuffle());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['category'] = category;
    data['type'] = type;
    data['difficulty'] = difficulty;
    data['question'] = question;
    data['correct_answer'] = correctAnswer;
    data['incorrect_answers'] = allAnswers;

    return data;
  }
}
