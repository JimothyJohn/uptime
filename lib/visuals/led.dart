import 'package:flutter/material.dart';

class IndicatorLed extends StatefulWidget {
  final bool status;
  final double size;

  const IndicatorLed({Key? key, required this.status, required this.size})
      : super(key: key);

  @override
  _IndicatorLedState createState() => _IndicatorLedState();
}

class _IndicatorLedState extends State<IndicatorLed>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
      upperBound: 0.95,
    )..repeat(
        reverse:
            true); // Causes the animation to automatically reverse and repeat

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _LedPainter(
            status: widget.status,
            glowOpacity: _animation
                .value, // Pass the current animation value for glow opacity
          ),
        );
      },
    );
  }
}

class _LedPainter extends CustomPainter {
  final bool status;
  final double glowOpacity; // Add glowOpacity as a parameter

  _LedPainter({required this.status, required this.glowOpacity});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Update the glow to use the animated glowOpacity
    paint.color = (status
            ? Color.fromRGBO(0, 220, 100, 1.0)
            : Color.fromRGBO(220, 0, 100, 1.0))
        .withOpacity(glowOpacity);
    paint.maskFilter = MaskFilter.blur(BlurStyle.normal, size.width / 6);
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // The rest of the painting code remains unchanged
    // ...
    // Draw the LED bezel
    paint.color = Colors.grey[300]!;
    paint.maskFilter = null;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // Draw the LED inner circle
    paint.color = (status
            ? const Color.fromRGBO(0, 220, 100, 1.0)
            : const Color.fromRGBO(220, 0, 100, 1.0))
        .withOpacity(glowOpacity);
    canvas.drawCircle(size.center(Offset.zero), size.width / 2 * 0.8, paint);

    // Draw the glare
    Paint glareBackPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    Path glareBackPath = Path()
      ..addOval(Rect.fromCircle(
        center: size.center(Offset(size.width / 8, -size.height / 8)),
        radius: size.width / 4,
      ))
      ..close();
    canvas.drawPath(glareBackPath, glareBackPaint);

    // Draw the glare
    Paint glarePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    Path glarePath = Path()
      ..addOval(Rect.fromCircle(
        center: size.center(Offset(size.width / 6, -size.height / 6)),
        radius: size.width / 10,
      ))
      ..close();
    canvas.drawPath(glarePath, glarePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      true; // Update to true to allow for repainting
}
