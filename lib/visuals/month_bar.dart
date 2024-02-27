import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/utils.dart';

class MonthBarChartPainter extends CustomPainter {
  final int firstWeekdayOfMonth;
  final int daysInMonth;
  final List<double> dayValues;
  final ThemeData theme;
  final double
      startingHour; // Assuming you might need this for labeling or other purposes

  MonthBarChartPainter({
    required this.firstWeekdayOfMonth,
    required this.daysInMonth,
    required this.dayValues,
    required this.theme,
    required this.startingHour,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double barWidth =
        size.width / daysInMonth; // Adjust based on total days
    final double maxHeight = size.height; // Max height for a bar

    // Text style for labels
    final textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    for (int i = 0; i < dayValues.length; i++) {
      // Calculate each bar's height based on the day's value
      final double barHeight = maxHeight * dayValues[i];
      final double xStart = i * barWidth;
      final double yStart = maxHeight - barHeight; // Bars grow upwards

      // Set bar color - customize as needed
      paint.color = uptimeColor(1 - dayValues[i], theme.colorScheme.surface);

      // Draw the bar for the day
      canvas.drawRect(
          Rect.fromLTWH(xStart, yStart, barWidth, barHeight), paint);

      // Add number labels for every 5 days
      if ((i + 1) % 5 == 0) {
        // Adjust condition as needed
        final String label = (i + 1).toString();
        textPainter.text = TextSpan(
            text: label,
            style: GoogleFonts.orbitron(fontWeight: FontWeight.bold));
        textPainter.layout();

        // Calculate label position
        final double labelX = xStart + (barWidth / 2) - (textPainter.width / 2);
        final double labelY = maxHeight; // Position label above the bottom edge

        // Draw the label
        textPainter.paint(canvas, Offset(labelX, labelY));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MonthViewBar extends StatelessWidget {
  final int year;
  final int month;
  final List<double> dayValues;
  final double size; // User-defined size for the widget

  const MonthViewBar({
    Key? key,
    required this.year,
    required this.month,
    required this.dayValues,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, 100), // Adjust the height as needed
      painter: MonthBarChartPainter(
        firstWeekdayOfMonth: DateTime(year, month, 1).weekday,
        daysInMonth: DateTime(year, month + 1, 0).day,
        dayValues: dayValues,
        theme: Theme.of(context),
        startingHour: 0, // Adjust if needed
      ),
    );
  }
}
