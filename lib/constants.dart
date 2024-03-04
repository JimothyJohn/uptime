import 'dart:math';

import 'package:visuals/utils.dart';

final DateTime dateTime = DateTime(2024, 2, 27, 10, 0, 0);

List<Measurement> generateMeasurements(DateTime startTime, int durationHours) {
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

final List<Measurement> perfectMeasurements = normalizeMeasurements(
    const Machine(
        name: "Perfecto", runCurrent: 2, idleCurrent: 0.5, targetUptime: 0.9),
    generateMeasurements(dateTime, 8));

final List<Measurement> upMeasurements = normalizeMeasurements(
    const Machine(
        name: "Goodboy", runCurrent: 3, idleCurrent: 1, targetUptime: 0.9),
    generateMeasurements(dateTime, 8));

final List<Measurement> downMeasurements = normalizeMeasurements(
    const Machine(
        name: "Bobby", runCurrent: 4, idleCurrent: 2, targetUptime: 0.9),
    generateMeasurements(dateTime, 8));

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

const List<double> sampleDay = downDay;

final List<double> dayValues = List.generate(31, (_) => Random().nextDouble());
