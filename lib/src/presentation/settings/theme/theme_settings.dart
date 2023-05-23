import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/settings/theme/cubit.dart';

class ThemeSettingsView extends StatelessWidget {
  const ThemeSettingsView({super.key, this.scrollController});

  static Widget bottomSheetBuilder(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: .7,
      initialChildSize: .55,
      builder: (context, scrollController) {
        return ThemeSettingsView(
          scrollController: scrollController,
        );
      },
    );
  }

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: CustomScrollView(
        shrinkWrap: true,
        controller: scrollController,
        slivers: [
          SliverList.list(children: const [
            Header(),
            SizedBox(height: 16),
            ThemeModeSelector(),
            SizedBox(height: 16),
          ]),
          const SliverColorSelector(colors: Colors.primaries),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Tema', style: Theme.of(context).textTheme.titleLarge);
  }
}

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

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
          segments: const [
            ButtonSegment(
              value: ThemeMode.light,
              icon: Icon(Icons.light_mode_outlined),
            ),
            ButtonSegment(
              value: ThemeMode.dark,
              icon: Icon(Icons.dark_mode_outlined),
            ),
            ButtonSegment(
              value: ThemeMode.system,
              icon: Icon(Icons.smartphone),
            ),
          ],
        );
      },
    );
  }
}

class SliverColorSelector extends StatelessWidget {
  const SliverColorSelector({super.key, required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
      builder: (context, state) {
        final selectedColor = state.seedColor;

        return SliverGrid.extent(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          maxCrossAxisExtent: 40,
          children: [
            for (final Color color in Colors.primaries)
              ColorOption(
                color: color,
                isSelected: color.value == selectedColor.value,
                onPressed: () {
                  context.read<ThemeSettingsCubit>().updateSeedColor(color);
                },
              )
          ],
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
