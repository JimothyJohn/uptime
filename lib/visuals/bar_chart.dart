import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/utils.dart';
import 'package:visuals/theme.dart';

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
    final int sectionsToDraw = animationValue.floor(); // Convert to integer
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double barWidth = size.width /
        measurements.length; // There are 60 sections for a full circle.

    // Optionally draw ticks and labels
    final textStyle =
        GoogleFonts.orbitron(color: theme.colorScheme.onSurface, fontSize: 12);
    final textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    double freq = 5;

    // Loop through each machine state and draw a bar for it.
    for (int i = 0; i < sectionsToDraw; i++) {
      final double fillExtent =
          1 - measurements[i].value; // Value between 0 and 1
      final double barHeight = size.height *
          measurements[i]
              .value; // Calculate bar height based on the machine state.
      final double xStart = i * barWidth;
      final double yStart = size.height -
          barHeight; // Start drawing from the bottom of the canvas.

      // Draw the bar
      paint.color = uptimeColor(fillExtent, theme.colorScheme.surface);

      canvas.drawRect(
          Rect.fromLTWH(xStart, yStart, barWidth, barHeight), paint);

      switch (timeUnit) {
        case "day":
          textPainter.text = TextSpan(
              text: measurements[i].time.hour.toString(),
              style: textStyle.copyWith(fontSize: size.width / 20));
          break;
        case "week":
          freq = 10;
          textPainter.text = TextSpan(
              text: measurements[i].time.weekday.toString(),
              style: textStyle.copyWith(fontSize: size.width / 20));
          break;
        case "month":
          textPainter.text = TextSpan(
              text: measurements[i].time.day.toString(),
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
