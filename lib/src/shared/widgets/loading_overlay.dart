import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
    required this.visible,
    required this.description,
  }) : super(key: key);

  final bool visible;
  final String description;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: visible ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: screenSize.width,
        height: screenSize.height,
        child: Visibility(
          visible: visible,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
