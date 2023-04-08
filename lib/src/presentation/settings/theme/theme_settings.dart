import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/settings/theme/cubit.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Header(),
          SizedBox(height: 16),
          DarkModeTile(),
          SizedBox(height: 16),
          Flexible(child: ColorSelector(colors: Colors.primaries)),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Tema', style: Theme.of(context).textTheme.headlineLarge);
  }
}

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
      buildWhen: (p, c) => p.themeMode != c.themeMode,
      builder: (context, state) {
        return SegmentedButton<ThemeMode>(
          emptySelectionAllowed: false,
          multiSelectionEnabled: false,
          showSelectedIcon: false,
          selected: <ThemeMode>{state.themeMode},
          onSelectionChanged: (Set<ThemeMode> modes) {
            if (modes.isNotEmpty) {
              assert(modes.length == 1);
              context.read<ThemeSettingsCubit>().updateThemeMode(modes.first);
            }
          },
          segments: [
            for (final ThemeMode mode in ThemeMode.values)
              ButtonSegment(
                value: mode,
                icon: Icon(mode.icon),
                label: Text(mode.label),
              ),
          ],
        );
      },
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector({super.key, required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
      builder: (context, state) {
        final selectedColor = state.seedColor;

        return GridView.builder(
          itemCount: colors.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 48,
            maxCrossAxisExtent: 48,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, int index) {
            final color = colors[index];

            return ColorOption(
              color: color,
              isSelected: color == selectedColor,
              onPressed: () {
                context.read<ThemeSettingsCubit>().updateSeedColor(color);
              },
            );
          },
        );
      },
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
      child = const Icon(Icons.circle, color: Colors.white);
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

extension on ThemeMode {
  String get label {
    switch (this) {
      case ThemeMode.system:
        return 'Sistema';
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Escuro';
    }
  }

  IconData get icon {
    switch (this) {
      case ThemeMode.system:
        return Icons.vibration;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }
}
