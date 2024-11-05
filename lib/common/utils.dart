import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:uptime/common/theme.dart';
import 'package:uptime/models/ModelProvider.dart';
import 'dart:convert';

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
  Device device,
  List<Measurement> measurements,
) {
  // Normalize each measurement value in the list
  return measurements.map((measurement) {
    // Clamp the result to ensure it falls within the 0-1 range, in case of outliers
    /*
    final normalizedValue = ((measurement.value - device.idleCurrent) /
            (device.runCurrent - device.idleCurrent))
        .clamp(0.0, 1.0);
    */
    final normalizedValue =
        ((measurement.value - 0) / (device.runCurrent ?? 0 - 0))
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
        key = DateTime(
            measurement.time.getDateTimeInUtc().year,
            measurement.time.getDateTimeInUtc().month,
            measurement.time.getDateTimeInUtc().day);
        break;
      case 'w': // Group by Week
        // Using the week number might be complex due to varying standards. Here, we simplify by considering the week start date.
        final DateTime firstDayOfWeek = measurement.time
            .getDateTimeInUtc()
            .subtract(Duration(
                days: measurement.time.getDateTimeInUtc().weekday - 1));
        key = DateTime(
            firstDayOfWeek.year, firstDayOfWeek.month, firstDayOfWeek.day);
        break;
      case 'm': // Group by Month
        key = DateTime(measurement.time.getDateTimeInUtc().year,
            measurement.time.getDateTimeInUtc().month);
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
    final TemporalDateTime sharedTime = measurementLists[0][i].time;

    // Create a new Measurement with the averaged value
    averagedMeasurements
        .add(Measurement(time: sharedTime, value: averageValue));
  }

  return averagedMeasurements;
}

// This function parses out a timestamp in the format "MM/dd hh:mm"
String parseTime(String time) {
  DateTime dateTime = DateTime.parse(time);
  return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
}

String getUrl(String email) {
  List<String> parts = email.split('@');

  // Ensure the email was split into two parts
  if (parts.length != 2) {
    safePrint('Invalid email');
    return "";
  }
  return "https://${parts[1]}";
}

void navigateToPage(BuildContext context, String routeName) {
  bool isNewRouteSameAsCurrent = false;

  Navigator.popUntil(context, (route) {
    if (route.settings.name == routeName) {
      isNewRouteSameAsCurrent = true;
    }
    return true;
  });

  if (!isNewRouteSameAsCurrent) {
    Navigator.pushNamed(context, routeName);
  }
}

Future<String?> uptimeLambdaQuery(String query) async {
  final GraphQLRequest request = GraphQLRequest<String>(
    document: '''
    query MyQuery {
      $query
    }
  ''',
  );

  try {
    final GraphQLResponse<dynamic> response =
        await Amplify.API.query(request: request).response;

    if (response.data == null) {
      safePrint("Errors: ${response.errors}");
      throw FormatException;
    }

    final decodedData = json.decode(response.data.toString());

    return decodedData[query.split('(').first].toString();
  } on FormatException catch (e) {
    safePrint('Format incorrect: $e');
  }
  return null;
}

Future<String?> uptimeLambdaMutation(String mutation) async {
  final GraphQLRequest request = GraphQLRequest<String>(
    document: '''
        mutation UpdateCustomer(\$customer: CustomerInput!) {
      $mutation
    }
  ''',
  );

  try {
    final GraphQLResponse<dynamic> response =
        await Amplify.API.mutate(request: request).response;

    // response.data = {"query":"{\"field\": \"value\"}"}

    if (response.data == null) {
      safePrint("Errors: ${response.errors}");
      throw FormatException;
    }

    final decodedData = json.decode(response.data.toString());
    // decodedData = {query: {"field": "value"}}

    // Use query argument to extract data
    // query.split('(').first = "query"
    // Returns {"field": "value"}
    return decodedData[mutation.split('(').first].toString();
  } on FormatException catch (e) {
    safePrint('Format incorrect: $e');
  }
  return null;
}

List<List<Measurement>> convertStringToListOfMeasurements(String jsonString) {
  List<dynamic> decodedJson = json.decode(jsonString);
  return decodedJson.map<List<Measurement>>((innerList) {
    return (innerList as List).map<Measurement>((item) {
      return Measurement.fromJson(item);
    }).toList();
  }).toList();
}

final List<DropdownMenuItem<String>> states = [
  'AL',
  'AK',
  'AZ',
  'AR',
  'CA',
  'CO',
  'CT',
  'DE',
  'FL',
  'GA',
  'HI',
  'ID',
  'IL',
  'IN',
  'IA',
  'KS',
  'KY',
  'LA',
  'ME',
  'MD',
  'MA',
  'MI',
  'MN',
  'MS',
  'MO',
  'MT',
  'NE',
  'NV',
  'NH',
  'NJ',
  'NM',
  'NY',
  'NC',
  'ND',
  'OH',
  'OK',
  'OR',
  'PA',
  'RI',
  'SC',
  'SD',
  'TN',
  'TX',
  'UT',
  'VT',
  'VA',
  'WA',
  'WV',
  'WI',
  'WY'
].map<DropdownMenuItem<String>>((String value) {
  return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
  );
}).toList();
