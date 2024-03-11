import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekView extends StatelessWidget {
  final List<double> weekValues; // Expects a list of 7 doubles between 0 and 1
  final double width; // User-provided width

  const WeekView({
    Key? key,
    required this.weekValues,
    required this.width,
  })  : assert(weekValues.length == 7),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate square size based on width and determine height dynamically
    final double squareSize = width / 7;
    final double height = squareSize + 20; // Adding additional space for text

    return CustomPaint(
      size:
          Size(width, height), // Dynamically set size to maintain square shape
      painter: WeekViewPainter(
          weekValues: weekValues, colorScheme: Theme.of(context).colorScheme),
    );
  }
}

class WeekViewPainter extends CustomPainter {
  final List<double> weekValues;
  final List<String> daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final ColorScheme colorScheme;

  WeekViewPainter({
    required this.weekValues,
    required this.colorScheme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double squareSize =
        size.width / 7; // Divide canvas width into 7 parts
    const double textHeight = 20; // Height allocated for text, adjust if needed

    for (int i = 0; i < weekValues.length; i++) {
      // Set the color opacity based on the week value for each day
      paint.color = Colors.green.withOpacity(weekValues[i]);

      final Rect rect = Rect.fromLTWH(
        i * squareSize, // X position
        0, // Y position adjusted to leave space for the text
        squareSize, // Width of each square
        size.height -
            textHeight, // Adjust height for squares to leave space for text
      );

      canvas.drawRect(rect, paint);

      // Draw the day of the week text, centered within the square
      final textSpan = TextSpan(
        text: daysOfWeek[i],
        style: GoogleFonts.orbitron(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: squareSize / 4, // Adjust font size based on square size
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textX = rect.left + (squareSize - textPainter.width) / 1.2;
      final textY = rect.top +
          (size.height - textHeight - textPainter.height) /
              1.2; // Center text vertically in the square
      final offset = Offset(textX, textY);

      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
