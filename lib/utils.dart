import 'package:flutter/material.dart';
import 'package:visuals/theme.dart';

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

class Measurement {
  final DateTime time;
  final double value;

  const Measurement({required this.time, required this.value});
}

class Machine {
  final String name;
  final double runCurrent;
  final double idleCurrent;
  final double targetUptime;

  const Machine(
      {required this.name,
      required this.runCurrent,
      required this.idleCurrent,
      required this.targetUptime});
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
