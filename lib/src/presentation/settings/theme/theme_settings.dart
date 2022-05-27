import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/settings/theme/cubit.dart';
import '../../../shared/shared.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        DarkModeTile(),
        SizedBox(height: 8),
        Flexible(child: ColorSelector()),
      ],
    );
  }
}

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
      buildWhen: (p, c) => p.themeMode != c.themeMode,
      builder: (context, state) {
        return SwitchListTile(
          shape: kBottomSheetShapeBorder,
          contentPadding: AppPadding.horizontalMedium.copyWith(right: 4),
          title: const Text(
            'Modo Escuro',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          value: state.themeMode == ThemeMode.dark,
          onChanged: (_) => context //
              .read<ThemeSettingsCubit>()
              .updateThemeMode(
                state.themeMode == ThemeMode.dark
                    ? ThemeMode.light
                    : ThemeMode.dark,
              ),
        );
      },
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector({super.key});

  static const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 6,
    mainAxisExtent: 40,
    crossAxisSpacing: 4,
    mainAxisSpacing: 8,
  );

  static double get height {
    final rowCount = Colors.primaries.length / gridDelegate.crossAxisCount;
    final itemsExtent = rowCount * gridDelegate.mainAxisExtent!;
    return itemsExtent + (rowCount - 1) * gridDelegate.mainAxisSpacing;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: height,
        child: BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
          builder: (context, state) {
            final selectedColor = state.seedColor;

            return GridView.builder(
              itemCount: Colors.primaries.length,
              padding: AppPadding.horizontalMedium,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: gridDelegate,
              itemBuilder: (context, int index) {
                final color = Colors.primaries[index];

                return ColorOption(
                  color: color,
                  isSelected: color == selectedColor,
                  onPressed: () => context //
                      .read<ThemeSettingsCubit>()
                      .updateSeedColor(color),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  const ColorOption({
    super.key,
    required this.color,
    required this.isSelected,
    this.onPressed,
    this.shape = const CircleBorder(),
  });

  final Color color;
  final bool isSelected;
  final VoidCallback? onPressed;

  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    VoidCallback? onTap;
    Widget? child;

    if (isSelected) {
      child = const Icon(Icons.check_circle_outline, size: 36);
    } else {
      onTap = onPressed;
    }

    return Material(
      color: color,
      shape: shape,
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
