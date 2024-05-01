import 'dart:math';
import 'package:visuals/common/models.dart';
import 'package:visuals/common/utils.dart';

Map<Machine, List<Measurement>> createMachinesHistoryMap(
    String timeUnit, int timeAmount, List<Machine> machines) {
  // Initialize an empty map to store the association between Machine and List<Measurement>
  Map<Machine, List<Measurement>> machineMeasurementsMap = {};

  // Iterate through the list of machines
  for (int i = 0; i < machines.length; i++) {
    machineMeasurementsMap[machines[i]] =
        averageMeasurements(generateMeasurements(timeUnit, timeAmount));
  }

  return machineMeasurementsMap;
}

List<List<Measurement>> generateMeasurements(String timeUnit, int samples) {
  List<List<Measurement>> history = [];
  final Random random = Random();

  List<Measurement> measurements;
  switch (timeUnit.toLowerCase()[0]) {
    case 's':
      const int shiftLength = 8;
      DateTime currentTime = DateTime(2024, 3, 1, 8, 0, 0);

      for (int i = 0; i < samples; i++) {
        measurements = [];
        for (int hour = 0; hour < shiftLength; hour++) {
          for (int minute = 0; minute < 60; minute += 12) {
            // Generate a random value between 1 and 5
            double value = random.nextDouble() * 4 +
                1; // random.nextDouble() generates a value between 0.0 and 1.0
            // Increment currentTime
            measurements.add(Measurement(
                time: currentTime
                    .add(Duration(hours: hour, minutes: 12 * minute)),
                value: value));
          }
        }
        history.add(measurements);
        currentTime = currentTime.subtract(Duration(days: i));
      }
    case 'w':
      DateTime currentTime = DateTime.now().subtract(const Duration(days: 7));

      for (int i = 0; i < samples; i++) {
        measurements = [];
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
        history.add(measurements);
        currentTime = currentTime.subtract(Duration(days: 7 * i));
      }
    case 'm':
      DateTime firstOfMonth = DateTime.now().subtract(const Duration(days: 30));

      for (int i = 0; i < samples; i++) {
        measurements = [];
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
        history.add(measurements);
        firstOfMonth = firstOfMonth.subtract(Duration(days: 30 * i));
      }
  }

  return history;
}
