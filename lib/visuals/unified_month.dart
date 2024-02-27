import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/theme.dart';
import 'package:visuals/utils.dart';

enum MonthViewMode {
  calendar,
  bar,
}

class UnifiedMonthView extends StatelessWidget {
  final int year;
  final int month;
  final List<double> dayValues;
  final double size;
  final MonthViewMode viewMode;

  const UnifiedMonthView({
    Key? key,
    required this.year,
    required this.month,
    required this.dayValues,
    required this.size,
    this.viewMode = MonthViewMode.calendar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Fix this travesty
    return viewMode == MonthViewMode.bar
        ? CustomPaint(
            size: Size(size, size / 4), // Use a square shape for simplicity
            painter: _UnifiedMonthViewPainter(
              year: year,
              month: month,
              dayValues: dayValues,
              viewMode: viewMode,
              theme: Theme.of(context),
            ),
          )
        : CustomPaint(
            size: Size(size, size), // Use a square shape for simplicity
            painter: _UnifiedMonthViewPainter(
              year: year,
              month: month,
              dayValues: dayValues,
              viewMode: viewMode,
              theme: Theme.of(context),
            ));
  }
}

class _UnifiedMonthViewPainter extends CustomPainter {
  final int year;
  final int month;
  final List<double> dayValues;
  final MonthViewMode viewMode;
  final ThemeData theme;

  _UnifiedMonthViewPainter({
    required this.year,
    required this.month,
    required this.dayValues,
    required this.viewMode,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstWeekdayOfMonth = DateTime(year, month, 1).weekday;

    switch (viewMode) {
      case MonthViewMode.calendar:
        _drawCalendarView(canvas, size, daysInMonth, firstWeekdayOfMonth);
        break;
      case MonthViewMode.bar:
        _drawBarChartView(canvas, size, daysInMonth);
        break;
    }
  }

  void _drawCalendarView(
      Canvas canvas, Size size, int daysInMonth, int firstWeekdayOfMonth) {
    final double squareSize = size.width / 7;
    Paint paint = Paint()..style = PaintingStyle.fill;
    int dayCounter = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      final int column = (firstWeekdayOfMonth + dayCounter - 1) % 7;
      final int row = (firstWeekdayOfMonth + dayCounter - 1) ~/ 7;
      final double opacity = dayValues[day - 1];
      final x = column * squareSize;
      final y = row * squareSize;

      paint.color = uptimeGreen.withOpacity(opacity);
      canvas.drawRect(Rect.fromLTWH(x, y, squareSize, squareSize), paint);

      // Draw the day number
      final dayNumberText = TextSpan(
        text: '${day}',
        style: GoogleFonts.orbitron(
            color: theme.colorScheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      );
      final textPainter = TextPainter(
        text: dayNumberText,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final numberOffset = Offset(
          x + (squareSize * 1.3 - textPainter.width) / 2,
          y + (squareSize * 1.3 - textPainter.height) / 2);
      textPainter.paint(canvas, numberOffset);

      dayCounter++;
    }
  }

  void _drawBarChartView(Canvas canvas, Size size, int daysInMonth) {
    final double barWidth = size.width / daysInMonth;
    Paint paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < dayValues.length; i++) {
      final double barHeight = size.height * dayValues[i];
      final double xStart = i * barWidth;

      paint.color = uptimeColor(1 - dayValues[i], Colors.transparent);
      canvas.drawRect(
          Rect.fromLTWH(xStart, size.height - barHeight, barWidth, barHeight),
          paint);

      // Text style for labels
      final textPainter = TextPainter(
          textAlign: TextAlign.center, textDirection: TextDirection.ltr);

      // Add number labels for every 5 days
      if ((i + 1) % 5 == 0) {
        // Adjust condition as needed
        final String label = (i + 1).toString();
        textPainter.text = TextSpan(
            text: label,
            style: GoogleFonts.orbitron(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface));
        textPainter.layout();

        // Calculate label position
        final double labelX = xStart + (barWidth / 2) - (textPainter.width / 2);
        final double labelY =
            size.height; // Position label above the bottom edge

        // Draw the label
        textPainter.paint(canvas, Offset(labelX, labelY));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
