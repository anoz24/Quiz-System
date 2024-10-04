import 'dart:io';

class Quiz {
  String title;
  List<Question> questions;

  Quiz(this.title, this.questions);
}

class Question {
  String questionText;
  List<String> answers;
  int correctAnswer;

  Question(this.questionText, this.answers, this.correctAnswer);
}

class TeacherMode {
  List<Quiz> quizzes = [];

  void addQuiz(Quiz quiz) {
    quizzes.add(quiz);
  }

  void removeQuiz(int index) {
    quizzes.removeAt(index);
  }

  void addQuestion(int quizIndex, Question question) {
    quizzes[quizIndex].questions.add(question);
  }

  void removeQuestion(int quizIndex, int questionIndex) {
    quizzes[quizIndex].questions.removeAt(questionIndex);
  }
}

class StudentMode {
  late Quiz currentQuiz;
  int currentQuestion = 0;
  int score = 0;

  void startQuiz(Quiz quiz) {
    currentQuiz = quiz;
    currentQuestion = 0;
    score = 0;
  }

  bool isQuizOver() {
    return currentQuestion >= currentQuiz.questions.length;
  }

  Question getCurrentQuestion() {
    return currentQuiz.questions[currentQuestion];
  }

  void submitAnswer(int selectedIndex) {
    if (selectedIndex == getCurrentQuestion().correctAnswer) {
      score++;
    }
    currentQuestion++;
  }

  bool hasPassed() {
    return score >= currentQuiz.questions.length / 2; 
  }
}



void main() {
  TeacherMode teacherMode = TeacherMode();
  StudentMode studentMode = StudentMode();

  
  Quiz quiz = Quiz(
    "Quiz",
    [
      Question("What is the capital of France?", ["Paris", "London", "Berlin"], 0),
      Question("What is 2 + 2?", ["3", "4", "5"], 1),
    ],
  );

  teacherMode.addQuiz(quiz);

  studentMode.startQuiz(quiz);

  while (!studentMode.isQuizOver()) {
    Question currentQuestion = studentMode.getCurrentQuestion();
    print(currentQuestion.questionText);
    for (int i = 0; i < currentQuestion.answers.length; i++) {
      print("${i + 1}. ${currentQuestion.answers[i]}");
    }
    int selectedIndex = int.parse(stdin.readLineSync()!);
    studentMode.submitAnswer(selectedIndex-1);
  }

  if (studentMode.hasPassed()) {
    print("you passed");
  } else {
    print("you failed");
  }
}