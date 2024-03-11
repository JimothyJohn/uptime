import 'dart:math';
import 'package:visuals/common/models.dart';

final DateTime dateTime = DateTime(2024, 2, 27, 10, 0, 0);

List<Measurement> generateDayMeasurements(
    DateTime startTime, int durationHours) {
  final List<Measurement> measurements = [];
  final Random random = Random();

  DateTime currentTime = startTime;
  for (int hour = 0; hour < durationHours; hour++) {
    for (int minute = 0; minute < 60; minute += 12) {
      // Generate a random value between 1 and 5
      double value = random.nextDouble() * 4 +
          1; // random.nextDouble() generates a value between 0.0 and 1.0
      measurements.add(Measurement(time: currentTime, value: value));

      // Increment currentTime by 12 minutes
      currentTime = currentTime.add(const Duration(minutes: 12));
    }
  }

  return measurements;
}

List<Measurement> generateWeekMeasurements() {
  final List<Measurement> measurements = [];
  final Random random = Random();

  DateTime currentTime = DateTime.now().subtract(const Duration(days: 7));
  for (int day = 0; day < 7; day++) {
    for (int hour = 0; hour < 24; hour += 2) {
      // Generate a random value between 1 and 5
      double value = random.nextDouble() * 4 +
          1; // random.nextDouble() generates a value between 0.0 and 1.0
      measurements.add(Measurement(time: currentTime, value: value));

      // Increment currentTime by 2 hours
      currentTime = currentTime.add(const Duration(hours: 2));
    }
  }

  return measurements;
}

List<Measurement> generateMonthMeasurements() {
  final List<Measurement> measurements = [];
  final Random random = Random();

  DateTime firstOfMonth =
      DateTime.now().copyWith(day: 0, hour: 0, minute: 0, second: 0);

  for (int day = 0; day < DateTime.now().day; day++) {
    for (int shift = 0; shift < 2; shift++) {
      // Generate a random value between 1 and 5
      double value = random.nextDouble() * 4 +
          1; // random.nextDouble() generates a value between 0.0 and 1.0
      measurements.add(Measurement(time: firstOfMonth, value: value));

      // Increment currentTime by 2 hours
      firstOfMonth = firstOfMonth.add(const Duration(hours: 12));
    }
  }

  return measurements;
}

List<Measurement> generateMeasurements(
    DateTime startTime, int duration, String timeUnit) {
  final List<Measurement> measurements = [];
  final Random random = Random();

  DateTime currentTime = DateTime.now();

  switch (timeUnit) {
    case "day":
      currentTime = DateTime(
          currentTime.year, currentTime.month, currentTime.day, 0, 0, 0);
      for (int hour = 0; hour < 24; hour++) {
        for (int minute = 0; minute < 60; minute += 12) {
          // Generate a random value between 1 and 5
          double value = random.nextDouble() * 4 +
              1; // random.nextDouble() generates a value between 0.0 and 1.0
          measurements.add(Measurement(time: currentTime, value: value));

          // Increment currentTime by 12 minutes
          currentTime = currentTime.add(const Duration(minutes: 12));
        }
      }
      break;
    case "week":
      currentTime = currentTime.subtract(const Duration(days: 7));
      for (int day = 0; day < 7; day++) {
        for (int hour = 0; hour < 24; hour += 2) {
          // Generate a random value between 1 and 5
          double value = random.nextDouble() * 4 +
              1; // random.nextDouble() generates a value between 0.0 and 1.0
          measurements.add(Measurement(time: currentTime, value: value));

          // Increment currentTime by 2 hours
          currentTime = currentTime.add(const Duration(hours: 2));
        }
      }
      break;
    default:
      break;
  }

  return measurements;
}

const Machine perfecto = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Perfecto",
    runCurrent: 2,
    idleCurrent: 0.5,
    targetUptime: 0.9);

const Machine downBoy = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Bobby",
    runCurrent: 4,
    idleCurrent: 2,
    targetUptime: 0.9);

const Machine upMan = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Goodboy",
    runCurrent: 3,
    idleCurrent: 1,
    targetUptime: 0.9);

const Machine upMon = Machine(
    id: "",
    process: "Addition",
    hourlyValue: 100,
    cycleTime: 10,
    active: true,
    name: "Goodish",
    runCurrent: 3,
    idleCurrent: 1.5,
    targetUptime: 0.8);
