import 'dart:math';

import 'package:visuals/utils.dart';

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

final List<Measurement> upWeekMeasurements = normalizeMeasurements(
    const Machine(
        name: "Goodboy", runCurrent: 3, idleCurrent: 1, targetUptime: 0.9),
    generateWeekMeasurements());

final List<Measurement> downWeekMeasurements = normalizeMeasurements(
    const Machine(
        name: "Bobby", runCurrent: 4, idleCurrent: 2, targetUptime: 0.9),
    generateWeekMeasurements());

const List<double> upDay = [
  0.9,
  0.8,
  0.98,
  0.99,
  0.98,
  0.97,
  0.99,
  0.9,
  0.58,
  0.77,
  0.95,
  0.95,
  0.95,
  0.9,
  0.8,
  0.8,
  0.9,
  0.7,
  0.2,
  0.1,
  0.0,
  0.0,
  0.6,
  0.9,
  0.9,
  0.95,
  0.96,
  0.96,
  0.97,
  0.9,
  0.98,
  0.9,
  0.9,
  0.94,
  0.96,
  0.98,
  0.98,
  0.98,
  0.97,
  0.9,
  0.85,
  0.9,
  0.95,
];

const List<double> downDay = [
  0.1,
  0.1,
  0.1,
  0.15,
  0.18,
  0.17,
  0.19,
  0.1,
  0.18,
  0.17,
  0.15,
  0.15,
  0.15,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.1,
  0.15,
  0.16,
  0.16,
  0.17,
  0.1,
  0.18,
  0.1,
  0.1,
  0.14,
  0.16,
  0.18,
  0.18,
  0.18,
  0.17,
  0.1,
  0.15,
  0.1,
  0.15,
];

const List<double> perfectDay = [
  0.99,
  0.99,
  0.99,
  0.99,
  0.98,
  0.97,
  0.99,
  0.99,
  0.99,
  0.99,
  0.95,
  0.95,
  0.95,
  0.99,
  0.99,
  0.99,
  0.99,
  0.99,
  0.99,
  0.99,
  0.90,
  0.90,
  0.96,
  0.99,
  0.99,
  0.995,
  0.996,
  0.996,
  0.997,
  0.99,
  0.998,
  0.99,
  0.99,
  0.994,
  0.996,
  0.998,
  0.998,
  0.998,
  0.997,
  0.99,
  0.985,
  0.99,
  0.995,
];

final List<double> dayValues = List.generate(31, (_) => Random().nextDouble());

const Machine perfecto = Machine(
    name: "PERFECTO", runCurrent: 2, idleCurrent: 0.5, targetUptime: 0.9);

const Machine downBoy =
    Machine(name: "BOBBY", runCurrent: 4, idleCurrent: 2, targetUptime: 0.9);

const Machine upMan =
    Machine(name: "GOODBOY", runCurrent: 3, idleCurrent: 1, targetUptime: 0.9);
