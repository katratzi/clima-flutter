import 'dart:io';

void main() {
  // performTasks();
  exceptionHandlingTest();
}

void exceptionHandlingTest() {
  String text = 'abc';
  double number;
  try {
    number = double.parse(text);
  } catch (e) {
    // short for exception
    print('Bad programmer...no biscuit');
  }

  // handy shortcut - if number is null...use alternative
  // null aware operator
  print(number ?? 123);
}

void performTasks() async {
  task1();
  String task2result = await task2();
  task3(task2result);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async {
  Duration threeSeconds = Duration(seconds: 3);

  String result;
  // sleep(threeSeconds);
  await Future.delayed(threeSeconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });

  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2Data');
}
