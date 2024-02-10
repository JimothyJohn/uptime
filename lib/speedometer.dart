import 'dart:math' as math;
import 'package:flutter/material.dart';

class Speedometer extends StatefulWidget {
  final double value; // Value should be between 0 and 1

  const Speedometer({Key? key, required this.value}) : super(key: key);

  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500), // Total animation time
      vsync: this,
    );

    // Tween sequence for overshoot and settle back in
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
                begin: 0.0, end: widget.value * 1.1) // Overshoots to 110%
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30.0, // 50% of the animation duration for overshooting
      ),
      TweenSequenceItem(
        tween: Tween<double>(
                begin: widget.value * 1.1,
                end: widget.value * .95) // Settle back to 100%
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20.0, // 30% of the animation duration for settling back
      ),
      TweenSequenceItem(
        tween: Tween<double>(
                begin: widget.value * .95,
                end: widget.value * 1.02) // Settle back to 100%
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 20.0, // 10% of the animation duration for settling back
      ),
      TweenSequenceItem(
        tween: Tween<double>(
                begin: widget.value * 1.02,
                end: widget.value) // Settle back to 100%
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 30.0, // 10% of the animation duration for settling back
      ),
    ]).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(200, 100), // You can adjust the size as needed
          painter: SpeedometerPainter(_animation.value),
        );
      },
    );
  }
}

class SpeedometerPainter extends CustomPainter {
  final double value;

  SpeedometerPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw arc
    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    canvas.drawArc(rect, math.pi, math.pi, false, paint);

// Draw ticks
    for (int i = 0; i <= 10; i++) {
      final tickPaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2;
      final angle = math.pi / 10 * i;
      final x1 = size.width / 2 + size.width / 2 * math.cos(math.pi + angle);
      final y1 = size.height + size.height * math.sin(math.pi + angle);
      // Adjust tick positions to be inside the arc
      final x2 = x1 - 10 * math.cos(math.pi + angle);
      final y2 = y1 - 10 * math.sin(math.pi + angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint);
    }

// Draw percentage text
    final percentageSpan = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      text: '${(value * 100).toInt()}%',
    );
    final percentagePainter = TextPainter(
      text: percentageSpan,
      textDirection: TextDirection.ltr,
    );
    percentagePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xPercentageText = (size.width - percentagePainter.width) * 0.5;
    final yPercentageText = (size.height - percentagePainter.height) * 0.5;
    percentagePainter.paint(canvas, Offset(xPercentageText, yPercentageText));

// Draw "UPTIME" text
    const uptimeSpan = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18, // Adjust the font size as needed
        fontWeight: FontWeight.normal,
      ),
      text: 'UPTIME',
    );
    final uptimePainter = TextPainter(
      text: uptimeSpan,
      textDirection: TextDirection.ltr,
    );
    uptimePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xUptimeText = (size.width - uptimePainter.width) * 0.5;
// Position the "UPTIME" text just below the percentage text
    final yUptimeText = yPercentageText +
        percentagePainter.height +
        5.0; // 5.0 is the padding between texts
    uptimePainter.paint(canvas, Offset(xUptimeText, yUptimeText));

// Draw complex arrow
    final arrowAngle = math.pi + math.pi * value;
    final arrowLength = size.width / 2 * 0.8; // Adjust the length as needed
    const double arrowWidth = 10.0; // Adjust the width of the arrow's body

// Calculate the base center of the arrow
    final baseX = size.width / 2 + arrowLength * math.cos(arrowAngle);
    final baseY = size.height + arrowLength * math.sin(arrowAngle);

// Arrow body
    final path = Path();
    path.moveTo(size.width / 2, size.height); // Start at the bottom center
// Move to the left side of the base of the arrow
    path.lineTo(
      baseX - arrowWidth * math.cos(arrowAngle + math.pi / 2),
      baseY - arrowWidth * math.sin(arrowAngle + math.pi / 2),
    );
// Create the triangular extension (tip of the arrow)
    final tipX = size.width / 2 +
        (arrowLength + 20) *
            math.cos(arrowAngle); // Extend the tip beyond the base
    final tipY = size.height + (arrowLength + 20) * math.sin(arrowAngle);
    path.lineTo(tipX, tipY); // Pointy top
// Move to the right side of the base of the arrow
    path.lineTo(
      baseX + arrowWidth * math.cos(arrowAngle + math.pi / 2),
      baseY + arrowWidth * math.sin(arrowAngle + math.pi / 2),
    );
// Close the path to create a filled shape
    path.close();

    final arrowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill; // Use fill to create a solid arrow

    canvas.drawPath(path, arrowPaint);

// Draw rounded end at the bottom
    final roundedEndPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
// Draw the circle at the base of the arrow to create a rounded end
    canvas.drawCircle(
        Offset(size.width / 2, size.height), arrowWidth / 2, roundedEndPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
