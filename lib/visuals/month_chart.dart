import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visuals/theme.dart';

class MonthView extends StatefulWidget {
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
  _MonthViewState createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView>
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
        Tween<double>(begin: 0, end: widget.dayValues.length.toDouble())
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
    // Use the provided size for the CustomPaint
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
                height: isExpanded ? widget.size * 2 : widget.size / 4,
                child: CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: _MonthViewPainter(
                      firstWeekdayOfMonth:
                          DateTime(widget.year, widget.month, 1).weekday,
                      daysInMonth:
                          DateTime(widget.year, widget.month + 1, 0).day,
                      dayValues: widget.dayValues,
                      theme: Theme.of(context),
                      animationValue: _animation.value),
                ))));
  }
}

class _MonthViewPainter extends CustomPainter {
  final int firstWeekdayOfMonth;
  final int daysInMonth;
  final List<double> dayValues;
  final ThemeData theme;
  final double animationValue; // Current animation value

  _MonthViewPainter(
      {required this.firstWeekdayOfMonth,
      required this.daysInMonth,
      required this.dayValues,
      required this.theme,
      required this.animationValue // Current animation value
      });

  @override
  void paint(Canvas canvas, Size size) {
    final int sectionsToDraw = animationValue.floor(); // Convert to integer
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double squareSize = size.width / 7; // 7 days of the week

    // Calculate initial offset for the first square based on the starting weekday
    int column = firstWeekdayOfMonth - 1; // Adjust for zero-based index
    int row = 0;

    for (int i = 0; i < sectionsToDraw; i++) {
      final double x = column * squareSize;
      final double y = row * squareSize;

      // Draw the square for the day
      paint.color = uptimeGreen.withOpacity(dayValues[i]);
      canvas.drawRect(Rect.fromLTWH(x, y, squareSize, squareSize), paint);

      // Draw the day number
      final dayNumberText = TextSpan(
        text: '${i + 1}',
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
