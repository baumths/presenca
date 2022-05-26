import 'package:flutter/material.dart';

import '../shared.dart';

class BorderedColumn extends StatelessWidget {
  const BorderedColumn({
    super.key,
    this.children = const <Widget>[],
    this.color,
  });

  final List<Widget> children;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: kDefaultBorderRadius,
        border: Border.all(
          color: color ?? Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
      child: Padding(
        padding: AppPadding.allMedium,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
