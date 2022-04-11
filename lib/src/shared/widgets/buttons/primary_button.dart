import 'package:flutter/material.dart';

import '../../constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.height,
  })  : width = null,
        super(key: key);

  const PrimaryButton.wide({
    Key? key,
    required this.label,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.height,
  })  : width = double.infinity,
        super(key: key);

  final String label;
  final double? height;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onPressed;

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: SizedBox(
        height: height ?? kDefaultButtonHeight,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
          style: ElevatedButton.styleFrom(
            shadowColor: Theme.of(context).colorScheme.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(kDefaultCornerRadius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
