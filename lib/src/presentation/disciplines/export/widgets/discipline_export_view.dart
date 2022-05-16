import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/export/cubit.dart';
import '../../../../shared/shared.dart';

class DisciplineExportView extends StatelessWidget {
  const DisciplineExportView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: Padding(
        padding: AppPadding.allMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            BlocBuilder<DisciplineExportCubit, DisciplineExportState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LinearProgressIndicator();
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 48),
                    primary: theme.colorScheme.primary,
                    onPrimary: theme.colorScheme.onPrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: kDefaultBorderRadius,
                    ),
                  ),
                  child: const Text('Exportar'),
                  onPressed: () {
                    context.read<DisciplineExportCubit>().exportDiscipline();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
