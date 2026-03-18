import 'dart:io';

void main() {
  List<String> students = [
    "Фредди Лаунс",
    "Эбигейл Хопс",
    "Фредерик Чилтон",
    "Алана Блум",
    "Ганнибал Лектор",
    "Уил Грэм"
  ];
  List<String> disciplines = [
    "Адм. право",
    "Уголовное право",
    "Уголовный процесс",
    "Психология"
  ];
  List<List<int>> grades = [
    [5, 5, 5, 2],
    [4, 3, 2, 3],
    [5, 5, 2, 3],
    [5, 5, 5, 5],
    [5, 5, 4, 5],
    [4, 4, 5, 5]
  ];

  void menu() {
    print("Меню: ");
    print("1. сводная таблица");
    print("2. оценки по фамилии");
    print("3. средний балл по предмету");
    print("4. средний балл студента");
    print("5. лучший студент по среднему баллу");
    print("6. предмет с наименьшим средним баллом");
    print("7. общий средний балл по всей группе");
    print("8. перечень всех предметов");
    print("9. имена студентов, у которых нет ни одной оценки 2");
    print("10. имена студентов, у которых все оценки не ниже 4");
  }

  void svodnayaTablica() {
    print("Студент         ${disciplines[0]}  ${disciplines[1]}  ${disciplines[2]}  ${disciplines[3]}");
    print("");

    for (int i = 0; i < students.length; i++) {
      String studentName = students[i];
      String stroka = "${i + 1}. $studentName";

      // пробелы до нужной длины
      while (stroka.length < 25) {
        stroka += " ";
      }

      // оценки
      for (int j = 0; j < grades[i].length; j++) {
        stroka += "${grades[i][j]}";

        // пробелы после каждой оценки
        if (j == 0) stroka += "         ";
        if (j == 1) stroka += "                ";
        if (j == 2) stroka += "                ";
      }

      print(stroka);
    }
  }

  void osenka() {
    stdout.write("Введите фамилию студента: ");
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print("Ошибка: ввод не может быть пустым!");
      return;
    }

    if (input == "Лектор") {
      print("\nСтудент: Ганнибал Лектор");
      for (int i = 0; i < disciplines.length; i++) {
        print("${disciplines[i]}: ${grades[4][i]}");
      }
    } else if (input == "Лаунс") {
      print("\nСтудент: Фредди Лаунс");
      for (int i = 0; i < disciplines.length; i++) {
        print("${disciplines[i]}: ${grades[0][i]}");
      }
    } else if (input == "Хопс") {
      print("\nСтудент: Эбигейл Хопс");
      for (int i = 0; i < disciplines.length; i++) {
        print("${disciplines[i]}: ${grades[1][i]}");
      }
    } else if (input == "Чилтон") {
      print("\nСтудент: Фредерик Чилтон");
      for (int i = 0; i < disciplines.length; i++) {
        print("${disciplines[i]}: ${grades[2][i]}");
      }
    } else if (input == "Блум") {
      print("\nСтудент: Алана Блум");
      for (int i = 0; i < disciplines.length; i++) {
        print("${disciplines[i]}: ${grades[3][i]}");
      }
    } else if (input == "Грэм") {
      print("\nСтудент: Уил Грэм");
      for (int i = 0; i < disciplines.length; i++) {
        print("${disciplines[i]}: ${grades[5][i]}");
      }
    } else {
      print("Студент с фамилией '$input' не найден!");
      print("Доступные фамилии: Лаунс, Хопс, Чилтон, Блум, Лектор, Грэм");
    }
  }

  // Вспомогательная функция для поиска индекса по фамилии (используется в новых пунктах)
  int? _findStudentIndex(String lastName) {
    String search = lastName.trim().toLowerCase();
    for (int i = 0; i < students.length; i++) {
      // Разделяем на имя и фамилию
      List<String> parts = students[i].split(' ');
      if (parts.length > 1) {
        if (parts[1].toLowerCase() == search) return i;
      } else {
        if (students[i].toLowerCase() == search) return i;
      }
    }
    return null;
  }

  // Пункт 3: средний балл по предмету
  void sredniyPoPredmetu() {
    stdout.write("Введите название предмета: ");
    String? input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print("Ошибка: ввод не может быть пустым!");
      return;
    }

    int? predmetIndex;
    String lowerInput = input.toLowerCase();
    for (int i = 0; i < disciplines.length; i++) {
      if (disciplines[i].toLowerCase().contains(lowerInput)) {
        predmetIndex = i;
        break;
      }
    }

    if (predmetIndex == null) {
      print("Предмет не найден!");
      return;
    }

    double sum = 0;
    for (int i = 0; i < students.length; i++) {
      sum += grades[i][predmetIndex];
    }
    double avg = sum / students.length;
    print("Средний балл по предмету '${disciplines[predmetIndex]}' = ${avg.toStringAsFixed(2)}");
  }

  // Пункт 4: средний балл студента
  void sredniyPoStudentu() {
    stdout.write("Введите фамилию студента: ");
    String? input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print("Ошибка: ввод не может быть пустым!");
      return;
    }

    int? studentIndex = _findStudentIndex(input);
    if (studentIndex == null) {
      print("Студент с фамилией '$input' не найден!");
      print("Доступные фамилии: Лаунс, Хопс, Чилтон, Блум, Лектор, Грэм");
      return;
    }

    double sum = 0;
    for (int i = 0; i < disciplines.length; i++) {
      sum += grades[studentIndex][i];
    }
    double avg = sum / disciplines.length;
    print("Средний балл студента ${students[studentIndex]} = ${avg.toStringAsFixed(2)}");
  }

  // Пункт 5: лучший студент по среднему баллу
  void luchshiyStudent() {
    double bestAvg = -1;
    List<int> bestIndices = [];

    for (int i = 0; i < students.length; i++) {
      double sum = 0;
      for (int j = 0; j < disciplines.length; j++) {
        sum += grades[i][j];
      }
      double avg = sum / disciplines.length;

      if (avg > bestAvg) {
        bestAvg = avg;
        bestIndices = [i];
      } else if (avg == bestAvg) {
        bestIndices.add(i);
      }
    }

    print("Лучший(ие) студент(ы) по среднему баллу (${bestAvg.toStringAsFixed(2)}):");
    for (int i in bestIndices) {
      print("  ${students[i]}");
    }
  }

  // Пункт 6: предмет с наименьшим средним баллом
  void naimenshiyPredmet() {
    double minAvg = double.infinity;
    List<int> minIndices = [];

    for (int j = 0; j < disciplines.length; j++) {
      double sum = 0;
      for (int i = 0; i < students.length; i++) {
        sum += grades[i][j];
      }
      double avg = sum / students.length;

      if (avg < minAvg) {
        minAvg = avg;
        minIndices = [j];
      } else if (avg == minAvg) {
        minIndices.add(j);
      }
    }

    print("Предмет(ы) с наименьшим средним баллом (${minAvg.toStringAsFixed(2)}):");
    for (int j in minIndices) {
      print("  ${disciplines[j]}");
    }
  }

  // Пункт 7: общий средний балл по всей группе
  void obshchiySredniy() {
    double totalSum = 0;
    int totalCount = 0;
    for (int i = 0; i < students.length; i++) {
      for (int j = 0; j < disciplines.length; j++) {
        totalSum += grades[i][j];
        totalCount++;
      }
    }
    double avg = totalSum / totalCount;
    print("Общий средний балл по всей группе = ${avg.toStringAsFixed(2)}");
  }

  // Пункт 8: перечень всех предметов
  void spisokPredmetov() {
    print("Перечень всех предметов:");
    for (int i = 0; i < disciplines.length; i++) {
      print("${i + 1}. ${disciplines[i]}");
    }
  }

  // Пункт 9: студенты без двоек
  void studentiBezDvoek() {
    List<String> result = [];
    for (int i = 0; i < students.length; i++) {
      bool hasTwo = false;
      for (int j = 0; j < disciplines.length; j++) {
        if (grades[i][j] == 2) {
          hasTwo = true;
          break;
        }
      }
      if (!hasTwo) {
        result.add(students[i]);
      }
    }

    if (result.isEmpty) {
      print("Нет студентов без двоек.");
    } else {
      print("Студенты, у которых нет ни одной оценки 2:");
      for (String name in result) {
        print("  $name");
      }
    }
  }

  // Пункт 10: студенты с оценками не ниже 4
  void studentiVseNeNizhe4() {
    List<String> result = [];
    for (int i = 0; i < students.length; i++) {
      bool allGood = true;
      for (int j = 0; j < disciplines.length; j++) {
        if (grades[i][j] < 4) {
          allGood = false;
          break;
        }
      }
      if (allGood) {
        result.add(students[i]);
      }
    }

    if (result.isEmpty) {
      print("Нет студентов, у которых все оценки не ниже 4.");
    } else {
      print("Студенты, у которых все оценки не ниже 4:");
      for (String name in result) {
        print("  $name");
      }
    }
  }

  void menu1() {
    int? choice;

    while (true) {
      stdout.write("Ваш выбор (1-10): ");
      String? input = stdin.readLineSync();

      if (input == null || input.isEmpty) {
        print("Ошибка: ввод не может быть пустым!");
        continue;
      }

      // Пробуем преобразовать в число
      try {
        choice = int.parse(input);
        if (choice < 1 || choice > 10) {
          print("Ошибка: число должно быть от 1 до 10!");
          continue;
        }
        break;
      } catch (e) {
        print("Ошибка: введите целое число!");
      }
    }

    switch (choice) {
      case 1:
        svodnayaTablica();
        break;
      case 2:
        osenka();
        break;
      case 3:
        sredniyPoPredmetu();
        break;
      case 4:
        sredniyPoStudentu();
        break;
      case 5:
        luchshiyStudent();
        break;
      case 6:
        naimenshiyPredmet();
        break;
      case 7:
        obshchiySredniy();
        break;
      case 8:
        spisokPredmetov();
        break;
      case 9:
        studentiBezDvoek();
        break;
      case 10:
        studentiVseNeNizhe4();
        break;
    }
  }

  menu();
  menu1();
}