import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/common/utils.dart';
import 'package:visuals/common/theme.dart';

class Clock extends StatefulWidget {
  final List<double> machineStates;
  final double size;
  final double startingHour;

  const Clock({
    Key? key,
    required this.size,
    required this.machineStates,
    required this.startingHour,
  })  : assert(machineStates.length <= 60),
        super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> with SingleTickerProviderStateMixin {
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
    _animation = Tween<double>(begin: 0, end: 60).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves
            .easeInOut, // This applies the ease-in-out effect to the animation
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
          height: isExpanded ? widget.size * 2 : widget.size,
          child: CustomPaint(
            painter: ClockPainter(
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

class ClockPainter extends CustomPainter {
  final List<double> machineStates;
  final double startingHour;
  final ThemeData theme;
  final double animationValue; // Current animation value

  ClockPainter(
    this.machineStates,
    this.startingHour,
    this.theme,
    this.animationValue, // Accept animationValue in constructor
  );

  @override
  void paint(Canvas canvas, Size size) {
    // Existing painting code, modified to use animationValue
    // Use animationValue to determine how many sections to draw
    // For example, if animationValue is 30, draw the first 30 sections
    int sectionsToDraw = animationValue.floor(); // Convert to integer
    // Convert hours to radians (15 degrees per hour, π/12 radians per hour)

    final Paint paint = Paint()..style = PaintingStyle.fill;
    final Offset center = Offset(size.width / 2, size.height / 2);
    // Reduce the radius for the sections so they don't touch the outer edges
    final double radius = size.width / 2 * 0.9; // 90% of the full radius

    // Draw the 60 12-minute sections to fill the clock
    for (int i = 0; i < sectionsToDraw; i++) {
      final double startingAngleOffset = startingHour * (math.pi / 6);
      final startAngle =
          (2 * math.pi / 60 * i) - math.pi / 2 + startingAngleOffset;
      const sweepAngle = 2 * math.pi / 60;

      // Make every 5th tick longer
      final double tickInnerRadius = (i % 5 == 0)
          ? radius * 0.9
          : radius * 0.95; // 90% of the radius for inner tick
      final double tickOuterRadius = radius; // 95% of the radius for outer tick

      // Calculate tick start and end points
      final Offset tickStart = Offset(
        center.dx + tickInnerRadius * math.cos(startAngle),
        center.dy + tickInnerRadius * math.sin(startAngle),
      );
      final Offset tickEnd = Offset(
        center.dx + tickOuterRadius * math.cos(startAngle),
        center.dy + tickOuterRadius * math.sin(startAngle),
      );

      // Draw the tick
      paint
        ..color = theme.colorScheme.onSurface // Tick color
        ..strokeWidth = 2; // Tick width
      canvas.drawLine(tickStart, tickEnd, paint);

      // Adjust path drawing to fill based on the machine state value
      if (i < machineStates.length) {
        double fillExtent = 1 - machineStates[i]; // Value between 0 and 1

        // Calculate the inner radius to start the fill based on the fillExtent
        double innerRadius = radius * (1 - fillExtent);

        // Define the filled section as a path
        Path filledPath = Path()
          ..moveTo(center.dx, center.dy)
          ..lineTo(center.dx + innerRadius * math.cos(startAngle),
              center.dy + innerRadius * math.sin(startAngle))
          ..arcTo(Rect.fromCircle(center: center, radius: innerRadius),
              startAngle, sweepAngle, false)
          ..close();

        paint.shader = null;
        // Use the uptimeColor scheme for filling sections based on the state value
        paint.color = uptimeColor(fillExtent, theme.colorScheme.surface);

        canvas.drawPath(filledPath, paint);
      } else {
        // For sections beyond the length of machineStates, use a neutral color
        Path path = Path()
          ..moveTo(center.dx, center.dy)
          ..arcTo(Rect.fromCircle(center: center, radius: radius), startAngle,
              sweepAngle, false)
          ..close();

        paint.color =
            Colors.transparent; // Use 'background' for unspecified states
        canvas.drawPath(path, paint);
      }

      // Draw clock numbers
      for (int i = 1; i <= 12; i++) {
        final double angle = 2 * math.pi / 12 * i - math.pi / 2;
        final String number = i.toString();

        final textSpan = TextSpan(
            text: number,
            style: GoogleFonts.orbitron(
              color: theme.colorScheme.onSurface,
              fontSize: size.width / 10,
            ));

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();

        final numberPosition = Offset(
          center.dx +
              (radius - (size.width / 8)) * math.cos(angle) -
              textPainter.width / 2,
          center.dy +
              (radius - (size.width / 8)) * math.sin(angle) -
              textPainter.height / 2,
        );
        textPainter.paint(canvas, numberPosition);
      }

      // Draw a circle outline to complete the clock look
      final outlinePaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = theme.colorScheme.onSurface
        ..strokeWidth = 2;
      canvas.drawCircle(center, radius, outlinePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
