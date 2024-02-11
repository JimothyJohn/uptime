import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/theme.dart';

class ProductivityClock extends StatelessWidget {
  final List<double> machineStates; // List of up to 60 boolean values
  final double size; // List of up to 60 boolean values
  final double startingHour; // Example starting time

  const ProductivityClock(
      {Key? key,
      required this.size,
      required this.machineStates,
      required this.startingHour})
      : assert(machineStates.length <= 60),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size), // Adjust the size as needed
      painter: ProductivityClockPainter(machineStates, startingHour),
    );
  }
}

class ProductivityClockPainter extends CustomPainter {
  final List<double> machineStates;
  final double startingHour; // Example starting time

  ProductivityClockPainter(this.machineStates, this.startingHour);

  @override
  void paint(Canvas canvas, Size size) {
    // Convert hours to radians (15 degrees per hour, π/12 radians per hour)

    final Paint paint = Paint()..style = PaintingStyle.fill;
    final Offset center = Offset(size.width / 2, size.height / 2);
    // Reduce the radius for the sections so they don't touch the outer edges
    final double radius = size.width / 2 * 0.9; // 90% of the full radius

    // Draw clock numbers
    for (int i = 1; i <= 12; i++) {
      final double angle = 2 * math.pi / 12 * i - math.pi / 2;
      final String number = i.toString();

      final textSpan = TextSpan(
          text: number,
          style: GoogleFonts.orbitron(
            color: Colors.black,
            fontSize: 20,
          ));
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final numberPosition = Offset(
        center.dx + (radius + 20) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius + 20) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, numberPosition);
    }

    // Optional: Draw a circle outline to complete the clock look
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, outlinePaint);

    // Draw the 60 12-minute sections to fill the clock
    for (int i = 0; i < 60; i++) {
      final double startingAngleOffset = startingHour * (math.pi / 6);
      final startAngle =
          (2 * math.pi / 60 * i) - math.pi / 2 + startingAngleOffset;
      const sweepAngle = 2 * math.pi / 60;

      // Adjust path drawing to fill based on the machine state value
      if (i < machineStates.length) {
        double fillExtent = 1 - machineStates[i]; // Value between 0 and 1

        // Calculate the inner radius to start the fill based on the fillExtent
        double innerRadius = radius * (1 - fillExtent);

        // Define the filled section as a path
        Path filledPath = Path()
          ..moveTo(center.dx + innerRadius * math.cos(startAngle),
              center.dy + innerRadius * math.sin(startAngle))
          ..lineTo(center.dx + radius * math.cos(startAngle),
              center.dy + radius * math.sin(startAngle))
          ..arcTo(Rect.fromCircle(center: center, radius: radius), startAngle,
              sweepAngle, false)
          ..lineTo(center.dx + innerRadius * math.cos(startAngle + sweepAngle),
              center.dy + innerRadius * math.sin(startAngle + sweepAngle))
          ..arcTo(Rect.fromCircle(center: center, radius: innerRadius),
              startAngle + sweepAngle, -sweepAngle, false)
          ..close();

        paint.shader = null;
        // Use the uptimeColor scheme for filling sections based on the state value
        paint.color = fillExtent > 0
            ? uptimeColor.onSurface
            : uptimeColor
                .surface; // Assuming full fill is 'onSurface' and no fill is 'surface'
        canvas.drawPath(filledPath, paint);
      } else {
        // For sections beyond the length of machineStates, use a neutral color
        Path path = Path()
          ..moveTo(center.dx, center.dy)
          ..arcTo(Rect.fromCircle(center: center, radius: radius), startAngle,
              sweepAngle, false)
          ..close();

        paint.color =
            uptimeColor.onSurface; // Use 'background' for unspecified states
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
