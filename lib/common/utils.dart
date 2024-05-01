import 'package:flutter/material.dart';

import 'package:visuals/common/theme.dart';
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

List<List<Measurement>> groupMeasurements(
    List<Measurement> measurements, String period) {
  Map<dynamic, List<Measurement>> grouped = {};

  for (Measurement measurement in measurements) {
    dynamic key;
    switch (period) {
      case 'd': // Group by Day
        key = DateTime(measurement.time.year, measurement.time.month,
            measurement.time.day);
        break;
      case 'w': // Group by Week
        // Using the week number might be complex due to varying standards. Here, we simplify by considering the week start date.
        final firstDayOfWeek = measurement.time
            .subtract(Duration(days: measurement.time.weekday - 1));
        key = DateTime(
            firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day);
        break;
      case 'm': // Group by Month
        key = DateTime(measurement.time.year, measurement.time.month);
        break;
      default:
        throw ArgumentError(
            'Period must be "d" (day), "w" (week), or "m" (month).');
    }

    if (!grouped.containsKey(key)) {
      grouped[key] = [];
    }
    grouped[key]!.add(measurement);
  }

  return grouped.values.toList();
}

List<Measurement> averageMeasurements(
    List<List<Measurement>> measurementLists) {
  final int numberOfLists = measurementLists.length;
  final int lengthOfEachList = measurementLists[0].length;

  // Initialize a list to store the averaged Measurements
  List<Measurement> averagedMeasurements = [];

  // Iterate over each index of the inner lists
  for (int i = 0; i < lengthOfEachList; i++) {
    // Sum up the values at this index across all lists
    double sum = 0.0;
    for (List<Measurement> list in measurementLists) {
      sum += list[i].value;
    }
    // Calculate the average
    final double averageValue = sum / numberOfLists;

    // Assume all measurements for the same index across lists share the same DateTime
    // This might not be the case in your actual application, and you might need a different approach if so
    final DateTime sharedTime = measurementLists[0][i].time;

    // Create a new Measurement with the averaged value
    averagedMeasurements
        .add(Measurement(time: sharedTime, value: averageValue));
  }

  return averagedMeasurements;
}
