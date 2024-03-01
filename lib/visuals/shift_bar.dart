import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/utils.dart';
import 'package:visuals/theme.dart';

class ProductivityBarChart extends StatefulWidget {
  final List<double> machineStates;
  final double size;
  final double startingHour;

  const ProductivityBarChart({
    Key? key,
    required this.size,
    required this.machineStates,
    required this.startingHour,
  })  : assert(machineStates.length <= 60),
        super(key: key);

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
        Tween<double>(begin: 0, end: widget.machineStates.length.toDouble())
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
              widget.machineStates,
              widget.startingHour,
              Theme.of(context),
              _animation.value, //
            ),
          ),
        ),
      ),
    );
  }
}

class ProductivityBarChartPainter extends CustomPainter {
  final List<double> machineStates;
  final double startingHour;
  final ThemeData theme;
  final double animationValue; // Current animation value

  ProductivityBarChartPainter(
      this.machineStates, this.startingHour, this.theme, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final int sectionsToDraw = animationValue.floor(); // Convert to integer
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double barWidth =
        size.width / 60; // There are 60 sections for a full circle.

    // Loop through each machine state and draw a bar for it.
    for (int i = 0; i < sectionsToDraw; i++) {
      final double fillExtent = 1 - machineStates[i]; // Value between 0 and 1
      final double barHeight = size.height *
          machineStates[i]; // Calculate bar height based on the machine state.
      final double xStart = i * barWidth;
      final double yStart = size.height -
          barHeight; // Start drawing from the bottom of the canvas.

      // Draw the bar
      paint.color = uptimeColor(fillExtent, theme.colorScheme.surface);

      canvas.drawRect(
          Rect.fromLTWH(xStart, yStart, barWidth, barHeight), paint);
    }

    // Optionally draw ticks and labels
    final textStyle =
        GoogleFonts.orbitron(color: theme.colorScheme.onSurface, fontSize: 12);
    final textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    for (int i = 0; i <= machineStates.length / 5; i++) {
      double xPosition = (size.width / 12) * i;
      // Draw hour labels
      final String label = "${(startingHour + i) % 12}";
      textPainter.text = TextSpan(
          text: label == "0" ? "12" : label,
          style: textStyle.copyWith(fontSize: size.width / 20));
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(xPosition - textPainter.width / 2, size.height));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
