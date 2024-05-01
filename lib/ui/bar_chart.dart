import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/common/utils.dart';
import 'package:visuals/common/models.dart';
import 'package:visuals/common/theme.dart';

class ProductivityBarChart extends StatefulWidget {
  final List<Measurement> measurements;
  final double size;
  final String timeUnit;

  const ProductivityBarChart({
    Key? key,
    required this.size,
    required this.measurements,
    required this.timeUnit,
  }) : super(key: key);

  @override
  _ProductivityBarChartState createState() => _ProductivityBarChartState();
}

class _ProductivityBarChartState extends State<ProductivityBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
          milliseconds: animationTime), // Total duration of the animation
      vsync: this,
    );

    // Wrap the tween animation with a CurvedAnimation using Curves.easeInOut
    _animation =
        Tween<double>(begin: 0, end: widget.measurements.length.toDouble())
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves
            .easeOut, // This applies the ease-in-out effect to the animation
      ),
    )..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: isExpanded ? widget.size * 2 : widget.size,
          height: isExpanded ? widget.size / 6 * 2 : widget.size / 6,
          child: CustomPaint(
            painter: ProductivityBarChartPainter(
                widget.measurements,
                Theme.of(context),
                _animation.value, //
                widget.timeUnit),
          ),
        ),
      ),
    );
  }
}

class ProductivityBarChartPainter extends CustomPainter {
  final List<Measurement> measurements;
  final ThemeData theme;
  final String timeUnit;
  final double animationValue; // Current animation value

  ProductivityBarChartPainter(
      this.measurements, this.theme, this.animationValue, this.timeUnit);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    late int barNumber;
    switch (timeUnit.toLowerCase()[0]) {
      case "s":
        // There are 5 total 12 minute segments per hour
        // There are a 12 hours in a shift max
        // TODO should this be changed to 15 minutes?
        barNumber = 5 * 12;
        break;
      case "w":
        // To hit ~60 bars in a week we need ~8 bars per day
        // This simplifies to 3 hours per bar
        barNumber = 8 * 7;
        break;
      case "m":
        // Month will be broken down into 2 shifts per day
        barNumber = 2 * 31;
        break;
    }
    final double barWidth =
        size.width / barNumber; // There are 60 sections for a full circle.

    // Optionally draw ticks and labels
    final textStyle =
        GoogleFonts.orbitron(color: theme.colorScheme.onSurface, fontSize: 12);
    final textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    // Default to day frequency
    // Display every new hour (5 * 12 minute shift)
    double freq = 5;
    const List<String> weekdays = ["S", "M", "T", "W", "T", "F", "S"];

    // Loop through each machine state and draw a bar for it.
    for (int i = 0; i < barNumber; i++) {
      final double xStart = i * barWidth;
      if (i < measurements.length) {
        final double fillExtent =
            1 - measurements[i].value; // Value between 0 and 1
        final double barHeight = size.height *
            measurements[i]
                .value; // Calculate bar height based on the machine state.

        final double yStart = size.height -
            barHeight; // Start drawing from the bottom of the canvas.

        // Draw the bar
        paint.color = uptimeColor(fillExtent, theme.colorScheme.surface);

        canvas.drawRect(
            Rect.fromLTWH(xStart, yStart, barWidth, barHeight), paint);
      }

      late int displayedTime;
      switch (timeUnit.toLowerCase()[0]) {
        case "s":
          // Count up hours from start time
          displayedTime = (measurements[0].time.hour + (i / freq)).toInt();
          textPainter.text = TextSpan(
              text: displayedTime < 13
                  ? "$displayedTime"
                  : "${displayedTime - 12}",
              style: textStyle.copyWith(fontSize: size.width / 20));
          break;
        case "w":
          freq = 12;
          textPainter.text = TextSpan(
              text: weekdays[
                  // Count up days from start of the period, 12 samples per day
                  (measurements[0].time.weekday + (i / freq) - 1).toInt()],
              style: textStyle.copyWith(fontSize: size.width / 20));
          break;
        case "m":
          // Print every 5 days accounting for 2 shifts per day
          freq = 2 * 5;
          // Count up days from start of the period, 2 shifts per day
          displayedTime = (measurements[0].time.day + (i / 2)).toInt();
          textPainter.text = TextSpan(
              text: "$displayedTime",
              style: textStyle.copyWith(fontSize: size.width / 20));
      }
      if (i % freq == 0) {
        // Draw hour labels
        textPainter.layout();
        textPainter.paint(
            canvas, Offset(xStart - textPainter.width / 2, size.height));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
