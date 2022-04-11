import 'package:flutter/material.dart';

import '../../constants.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.height,
  })  : width = null,
        super(key: key);

  const SecondaryButton.wide({
    Key? key,
    required this.label,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.height,
  })  : width = double.infinity,
        super(key: key);

  final String label;
  final double? height;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height ?? kDefaultButtonHeight,
        width: width,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(label),
          style: OutlinedButton.styleFrom(
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
