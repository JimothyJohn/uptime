import 'package:flutter/material.dart';
import 'dart:math';
import 'package:visuals/ui/theme.dart';
import 'package:visuals/common/models.dart';

double getUptime(List<double> states) {
  final double sum = states.reduce((a, b) => a + b);
  return sum / states.length;
}

double getUptimeMeasurements(List<Measurement> measurements) {
  if (measurements.isEmpty) {
    return 0.0; // Return 0 if the list is empty to avoid division by zero
  }
  final double sum = measurements.map((m) => m.value).reduce((a, b) => a + b);
  return sum / measurements.length;
}

Color uptimeColor(double fillExtent, Color color) {
  final List<double> rgbLevels = [
    uptimeRed.red.toDouble(),
    uptimeGreen.green.toDouble(),
    uptimeGreen.blue.toDouble(),
    0.9
  ];
  return fillExtent > 0
      ? Color.fromRGBO(
          (rgbLevels[0] * fillExtent).toInt(),
          (rgbLevels[1] * (1 - fillExtent)).toInt(),
          rgbLevels[2].toInt(),
          rgbLevels[3])
      : color; // As
}

List<Measurement> normalizeMeasurements(
  Machine machine,
  List<Measurement> measurements,
) {
  // Normalize each measurement value in the list
  return measurements.map((measurement) {
    // Clamp the result to ensure it falls within the 0-1 range, in case of outliers
    final double normalizedValue = ((measurement.value - machine.idleCurrent) /
            (machine.runCurrent - machine.idleCurrent))
        .clamp(0.0, 1.0);

    return Measurement(time: measurement.time, value: normalizedValue);
  }).toList();
}

Map<Machine, List<Measurement>> createMachineMeasurementsMap(
    List<Machine> machines, List<List<Measurement>> measurementsList) {
  // Initialize an empty map to store the association between Machine and List<Measurement>
  Map<Machine, List<Measurement>> machineMeasurementsMap = {};

  // Iterate through the list of machines
  for (int i = 0; i < machines.length; i++) {
    // Use the current index to associate the machine with the corresponding List<Measurement>
    // Check if the measurementsList has an entry at the current index to avoid out of range errors
    if (i < measurementsList.length) {
      machineMeasurementsMap[machines[i]] = measurementsList[i];
    } else {
      // If there's no corresponding List<Measurement>, associate with an empty list
      machineMeasurementsMap[machines[i]] = [];
    }
  }

  return machineMeasurementsMap;
}

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
