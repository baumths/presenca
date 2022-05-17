import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/discipline/export/cubit.dart';
import '../../../../shared/shared.dart';

class DisciplineExportView extends StatelessWidget {
  const DisciplineExportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.allMedium,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Flexible(
            child: BorderedColumn(
              children: [
                ExportHeader(),
                SizedBox(height: 16),
                ExportDescription(),
              ],
            ),
          ),
          SizedBox(height: 16),
          ExportButton(),
        ],
      ),
    );
  }
}

class ExportHeader extends StatelessWidget {
  const ExportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      'Exportação CSV',
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.secondary,
      ),
    );
  }
}

class ExportDescription extends StatelessWidget {
  const ExportDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTextStyle(
      style: theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.secondary,
        fontSize: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text(
            'Ao exportar essa disciplina, um arquivo .csv será criado no seu '
            'dispositivo.',
          ),
          SizedBox(height: 4),
          Text(
            'Esse arquivo será composto por todos os alunos '
            '(incluindo os inativos), e todas as chamadas '
            'dessa disciplina. Detalhes:',
          ),
          SizedBox(height: 4),
          Text(
            '  - Uma linha para cada aluno.\n'
            '  - Uma coluna para cada chamada.\n'
            '  - A última linha é dedicada às anotações.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Atenção! ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: 'Caso você já tenha exportado essa disciplina '
                      'anteriormente, o arquivo antigo será ',
                ),
                TextSpan(
                  text: 'sobrescrito.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExportButton extends StatelessWidget {
  const ExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 48,
      child: BlocBuilder<DisciplineExportCubit, DisciplineExportState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Row(
              children: [
                const SizedBox(width: 16),
                const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DefaultTextStyle(
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.secondary,
                      fontSize: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Exportando Disciplina'),
                        Text(
                          'Isso pode levar alguns segundos...',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius: kDefaultBorderRadius,
              ),
            ),
            child: const Text('Exportar Disciplina'),
            onPressed: () {
              context.read<DisciplineExportCubit>().exportDiscipline();
            },
          );
        },
      ),
    );
  }
}
