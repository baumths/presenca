import 'package:flutter/material.dart';

import '../theme/padding.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    this.buttons = const <Widget>[],
    required this.fab,
  });

  final List<Widget> buttons;
  final Widget fab;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BottomAppBar(
        child: Padding(
          padding: AppPadding.horizontalMedium,
          child: Row(
            children: [
              ...buttons,
              const Spacer(),
              fab,
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
  });

  final Widget icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: onPressed,
      iconSize: 24,
      splashRadius: 24,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
