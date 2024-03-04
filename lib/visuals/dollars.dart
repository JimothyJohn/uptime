import 'package:flutter/material.dart';
import 'package:visuals/theme.dart';

class MoneyValueText extends StatelessWidget {
  final double hours;
  final double hourlyValue;
  final double uptime;

  const MoneyValueText({
    Key? key,
    required this.hours,
    required this.hourlyValue,
    required this.uptime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the value
    final value = (hours * hourlyValue * uptime).toInt();
    final Color textColor = value >= 200 ? uptimeGreen : uptimeRed;
    final List<Shadow> shadows = value >= 200
        ? [
            const Shadow(
              offset: Offset(0, 0), // Horizontal and vertical offset
              blurRadius: 10, // How much the shadow is blurred
              color: uptimeGreen, // Shadow color with opacity
            )
          ]
        : [];

    // Format the value with comma and two decimal places
    final String formattedValue = formatCurrency(value);

    return Text(
      formattedValue,
      textAlign: TextAlign.center,
      style: TextStyle(
          shadows: shadows,
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 24),
    );
  }

  String formatCurrency(int value) {
    // Adding commas to the whole part
    String wholePart = value.abs().toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},');

    // Prefixing with + or - sign
    String sign = value >= 0 ? '+' : '-';

    return "$sign\$$wholePart";
  }
}
