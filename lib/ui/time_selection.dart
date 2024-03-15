import 'package:flutter/material.dart';

class TimeSelectionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NumberSelector(),
        UnitSelector(),
      ],
    );
  }
}

class NumberSelector extends StatefulWidget {
  @override
  _NumberSelectorState createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  int currentNumber = 3;

  void increment() {
    setState(() {
      currentNumber = currentNumber < 12 ? currentNumber + 1 : currentNumber;
    });
  }

  void decrement() {
    setState(() {
      currentNumber = currentNumber > 1 ? currentNumber - 1 : currentNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: decrement,
          ),
          const Spacer(flex: 2), // Allocate more space to keep center aligned
          // Conditional to not show the previous number if at the start
          if (currentNumber > 1)
            Opacity(
              opacity: 0.5,
              child: Text(
                '${currentNumber - 1}',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24),
              ),
            ),
          const Spacer(), // Central spacer to ensure the main number is centered
          Text(
            '$currentNumber',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(), // Spacer after the main number
          // Conditional to not show the next number if at the end
          if (currentNumber < 12)
            Opacity(
              opacity: 0.5,
              child: Text(
                '${currentNumber + 1}',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24),
              ),
            ),
          const Spacer(flex: 2), // Allocate more space to keep center aligned
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: increment,
          ),
        ],
      ),
    );
  }
}

class UnitSelector extends StatefulWidget {
  @override
  _UnitSelectorState createState() => _UnitSelectorState();
}

class _UnitSelectorState extends State<UnitSelector> {
  final List<String> units = ['D', 'W', 'M'];
  int currentIndex = 0;

  void increment() {
    setState(() {
      currentIndex =
          currentIndex < units.length - 1 ? currentIndex + 1 : currentIndex;
    });
  }

  void decrement() {
    setState(() {
      currentIndex = currentIndex > 0 ? currentIndex - 1 : currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: decrement,
          ),
          Spacer(flex: 2), // Allocate more space to keep center aligned
          // Conditional to not show the previous number if at the start
          if (currentIndex > 0)
            Opacity(
              opacity: 0.5,
              child: TextButton(
                onPressed: decrement,
                child: Text(
                  '${units[currentIndex - 1]}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24),
                ),
              ),
            ),
          Spacer(), // Central spacer to ensure the main number is centered
          Text(
            '${units[currentIndex]}',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          Spacer(), // Spacer after the main number
          // Conditional to not show the next number if at the end
          if (currentIndex < 2)
            Opacity(
              opacity: 0.5,
              child: TextButton(
                onPressed: increment,
                child: Text(
                  '${units[currentIndex + 1]}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24),
                ),
              ),
            ),
          Spacer(flex: 2), // Allocate more space to keep center aligned
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: increment,
          ),
        ],
      ),
    );
  }
}
