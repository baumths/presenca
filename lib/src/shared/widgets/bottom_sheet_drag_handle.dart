import 'package:flutter/material.dart';

class BottomSheetDragHandle extends StatelessWidget {
  const BottomSheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Center(
        child: ColoredBox(
          color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(.4),
          child: const SizedBox(width: 36, height: 4),
        ),
      ),
    );
  }
}
