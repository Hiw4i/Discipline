import 'package:flutter/material.dart';

class TimerSelector extends StatefulWidget {
  const TimerSelector({super.key});

  @override
  State<TimerSelector> createState() => _TimerSelectorState();
}

class _TimerSelectorState extends State<TimerSelector> {
  int selectedHour = 1;
  int selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildWheel(
            count: 24,
            onChanged: (value) => setState(() => selectedHour = value),
          ),
          const SizedBox(width: 5),
          const Text(':', style: TextStyle(fontSize: 40)),
          const SizedBox(width: 5),
          _buildWheel(
            count: 60,
            onChanged: (value) => setState(() => selectedMinute = value),
          )
        ],
      ),
    );
  }


  Widget _buildWheel({required int count, required ValueChanged<int> onChanged}) {
    return SizedBox(
      width: 80,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: count,
              builder: (context, index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            )
          )
        ],
      )
    );
  }
}