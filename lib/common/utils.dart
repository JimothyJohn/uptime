import 'package:flutter/material.dart';
import 'package:visuals/ui/theme.dart';
import 'package:visuals/common/models.dart';
import 'package:visuals/common/constants.dart';

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

Map<Machine, List<Measurement>> dayMeasurementMap =
    createMachineMeasurementsMap(const [
  perfecto,
  downBoy,
  upMan,
  upMon,
], [
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
  generateDayMeasurements(DateTime(2024, 3, 4, 8, 0, 0), 8),
]);

Map<Machine, List<Measurement>> weekMeasurementMap =
    createMachineMeasurementsMap(const [
  perfecto,
  downBoy,
  upMan,
  upMon,
], [
  generateWeekMeasurements(),
  generateWeekMeasurements(),
  generateWeekMeasurements(),
  generateWeekMeasurements(),
]);

Map<Machine, List<Measurement>> monthMeasurementMap =
    createMachineMeasurementsMap(const [
  perfecto,
  downBoy,
  upMan,
  upMon,
], [
  generateMonthMeasurements(),
  generateMonthMeasurements(),
  generateMonthMeasurements(),
  generateMonthMeasurements(),
]);
