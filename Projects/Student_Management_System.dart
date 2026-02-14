import "dart:io";

// --- Helper Functions ---
// ------------------------

// 1. Welcome Message
void printWelcomeMessage() {
  print("\n===== Welcome to the Student Management System! =====");
  print("======================================================\n");
}

// 2. Main Menu
void mainMenu() {
  print("\n===== Main Menu =====");
  print("1. Save Students");
  print("0. Exit");
  print("=====================\n");
}

// 3. Sub Menu
void subMenu() {
  print("\n===== Sub Menu =====");
  print("=========================\n");
  print("1. Print All Students");
  print("2. Filter by Percentage");
  print("3. Save More Students");
  print("0. Exit");
  print("============================\n");
}

// 4. Handle Sub Menu
void handleSubMenu(Map<String, dynamic> students) {
  while (true) {
    print("\nEnter your choice: ");
    String? choice = stdin.readLineSync();

    if (choice == "1") {
      printAllStudents(students);
    } else if (choice == "2") {
      print("\nEnter the percentage to filter students: ");
      double mark;

      try {
        mark = double.parse(stdin.readLineSync()!);
      } catch (e) {
        print(
          "\nInvalid input. Please enter a valid percentage (between 0 and 100).",
        );
        continue;
      }

      filterStudents(mark, students);
    } else if (choice == "3") {
      int additionalNumber;
      print("\nEnter the number of additional students you want to save: ");
      try {
        additionalNumber = int.parse(stdin.readLineSync()!);
      } catch (e) {
        print(
          "\nInvalid input. Please enter a valid number of students (positive integer).",
        );
        continue;
      }
      saveStudents(additionalNumber, students);
    } else if (choice == "0") {
      print("\nExiting the student management system. Goodbye:)\n");
      exit(0);
    } else {
      print(
        "\nInvalid choice. Please enter 1 to filter students, 2 to save more students, or 0 to exit.",
      );
    }
  }
}

// 5. Menu Loop
void menuLoop(Map<String, dynamic> students) {
  while (true) {
    mainMenu();
    print("\nEnter your choice: ");
    String? choice = stdin.readLineSync();

    if (choice == "1") {
      int number;
      while (true) {
        print("\nEnter the number of students you want to save: ");
        try {
          number = int.parse(stdin.readLineSync()!);
          if (number <= 0) {
            print("Number must be positive. Try again.");
            continue;
          }
          break;
        } catch (e) {
          print("Invalid input. Try again.");
        }
      }

      saveStudents(number, students);

      while (true) {
        subMenu();
        print("\nEnter your choice: ");
        String? subChoice = stdin.readLineSync();

        if (subChoice == "1") {
          printAllStudents(students);
        } else if (subChoice == "2") {
          print("\nEnter the percentage to filter students: ");
          try {
            double mark = double.parse(stdin.readLineSync()!);
            if (mark < 0 || mark > 100) {
              print("Percentage must be between 0 and 100. Try again.");
              continue;
            }
            filterStudents(mark, students);
          } catch (e) {
            print("Invalid input. Try again.");
            continue;
          }
        } else if (subChoice == "3") {
          print("How many more students? ");
          try {
            int more = int.parse(stdin.readLineSync()!);
            saveStudents(more, students);
          } catch (e) {
            print("Invalid input. Try again.");
          }
        } else if (subChoice == "0") {
          print("Exiting the student management system. Goodbye:)\n");
          exit(0);
        } else {
          print("Invalid choice. Try again.");
        }
      }
    } else if (choice == "0") {
      print("Exiting the student management system. Goodbye:)\n");
      exit(0);
    } else {
      print("Invalid choice. Try again.");
    }
  }
}

// 5. Calculate Grade
String getGrade(double percentage) {
  if (percentage >= 90) {
    return "Excellent";
  } else if (percentage >= 80) {
    return "Very Good";
  } else if (percentage >= 70) {
    return "Good";
  } else {
    return "Needs Improvement";
  }
}

// --- Main Functions ---
// ----------------------

// 1. Save Students
void saveStudents(int number, Map<String, dynamic> students) {
  int age;
  double percentage;
  String? grade, name;

  for (int i = 1; i <= number; i++) {
    List<String> interests = [];
    print("\n--- Enter details for student $i ---");

    // Name input with validation
    while (true) {
      print("\nEnter the Name of the student: ");
      name = stdin.readLineSync()!;
      if (name != null && name.trim().isNotEmpty) {
        break;
      }

      print("\nName cannot be empty. Please enter a valid name.");
    }

    // Age input with validation
    while (true) {
      print("\nEnter the Age of the student: ");
      try {
        age = int.parse(stdin.readLineSync()!);

        if (age <= 0) {
          print("\nAge must be a positive integer. Please enter a valid age.");
          continue;
        }
        break;
      } catch (e) {
        print("\nInvalid input. Try again.");
      }
    }

    // Percentage input with validation
    while (true) {
      print("\nEnter the percentage of the student: ");
      try {
        percentage = double.parse(stdin.readLineSync()!);
        if (percentage < 0 || percentage > 100) {
          print(
            "\nPercentage must be between 0 and 100. Please enter a valid percentage.",
          );
          continue;
        }
        break;
      } catch (e) {
        print("\nInvalid input. Try again.");
      }
    }

    // Interests input with validation
    while (true) {
      print(
        "\nEnter Interest of the student (at least 3) seperated by commas: ",
      );
      String? interest = stdin.readLineSync();

      if (interest == null ||
          interest.trim().isEmpty ||
          interest.split(",").length < 3) {
        print(
          "\nInterests cannot be empty or less than 3 interests. Please enter at least 3 interests.",
        );
        continue;
      } else {
        interests = interest.split(",").map((e) => e.trim()).toList();
        break;
      }
    }

    // Save student details in the map
    students[name] = {
      "name": name,
      "age": age,
      "grade": getGrade(percentage),
      "percentage": percentage,
      "interests": interests,
    };
  }

  print("\n--------------------------------");
  print("Students saved successfully!");
  print("--------------------------------\n");
}

// 2. Print All Students
void printAllStudents(Map<String, dynamic> students) {
  if (students.isEmpty) {
    print("\nNo students to display. Please save some students first.");
    return;
  }

  print("\n\n===== List of Students =====");
  print("============================\n");

  students.forEach((key, value) {
    print("Name      : ${value['name']}");
    print("Age       : ${value['age']}");
    print("Grade     : ${value['grade']}");
    print("Percentage: ${value['percentage']}");
    print("Interests : ${value['interests'].join(', ')}");
    print("===================================\n");
  });
}

// 3. Filter by Percentage
void filterStudents(double mark, Map<String, dynamic> students) {
  bool found = false;
  if (students.isEmpty) {
    print("\nNo students to filter.\n");
    return;
  }

  if (mark < 0 || mark > 100) {
    print(
      "\nPercentage must be between 0 and 100. Please enter a valid percentage.",
    );
    return;
  }

  print("\n===== Filtered Students (Grade: $mark) =====");
  print("=============================================\n");

  students.forEach((key, value) {
    if (value['percentage'] == mark) {
      found = true;
      print("Name      : ${value?['name']}");
      print("Age       : ${value?['age']}");
      print("Grade     : ${value?['grade']}");
      print("Percentage: ${value?['percentage']}");
      print("Interests : ${value?['interests'].join(', ')}");
      print("===================================\n");
    }
  });

  if (!found) {
    print("\nNo students found with the specified percentage: $mark.");
  }
}

// --- Main Program ---
void main() {
  printWelcomeMessage();
  Map<String, dynamic> students = {};
  menuLoop(students);
}