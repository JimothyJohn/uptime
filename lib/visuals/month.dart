import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthView extends StatelessWidget {
  final int year;
  final int month;
  final List<double> dayValues;
  final double size; // User-defined size for the widget

  MonthView({
    Key? key,
    required this.year,
    required this.month,
    required this.dayValues,
    required this.size, // Include size in the constructor
  })  : assert(month > 0 && month < 13),
        // assert(dayValues.length == DateTime(year, month + 1, 0).day),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the provided size for the CustomPaint
    return CustomPaint(
      size: Size(size, size),
      painter: _MonthViewPainter(
        firstWeekdayOfMonth: DateTime(year, month, 1).weekday,
        daysInMonth: DateTime(year, month + 1, 0).day,
        dayValues: dayValues,
        colorScheme: Theme.of(context).colorScheme,
      ),
    );
  }
}

class _MonthViewPainter extends CustomPainter {
  final int firstWeekdayOfMonth;
  final int daysInMonth;
  final List<double> dayValues;
  final ColorScheme colorScheme;

  _MonthViewPainter({
    required this.firstWeekdayOfMonth,
    required this.daysInMonth,
    required this.dayValues,
    required this.colorScheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double squareSize = size.width / 7; // 7 days of the week

    // Calculate initial offset for the first square based on the starting weekday
    int column = firstWeekdayOfMonth - 1; // Adjust for zero-based index
    int row = 0;

    for (int i = 0; i < dayValues.length; i++) {
      final double x = column * squareSize;
      final double y = row * squareSize;

      // Draw the square for the day
      paint.color = Colors.green.withOpacity(dayValues[i]);
      canvas.drawRect(Rect.fromLTWH(x, y, squareSize, squareSize), paint);

      // Draw the day number
      final dayNumberText = TextSpan(
        text: '${i + 1}',
        style: GoogleFonts.orbitron(
            color: colorScheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      );
      final textPainter = TextPainter(
        text: dayNumberText,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final numberOffset = Offset(x + (squareSize - textPainter.width) / 2,
          y + (squareSize - textPainter.height) / 2);
      textPainter.paint(canvas, numberOffset);

      column++;
      if (column >= 7) {
        column = 0;
        row++;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
