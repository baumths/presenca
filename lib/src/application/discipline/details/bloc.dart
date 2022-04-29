import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class DisciplineDetailsBloc
    extends Bloc<DisciplineDetailsEvent, DisciplineDetailsState> {
  DisciplineDetailsBloc({
    required this.discipline,
  }) : super(const DisciplineDetailsState()) {
    on<DisciplineDetailsEvent>(_onEvent);
  }

  final Discipline discipline;

  Future<void> _onEvent(
    DisciplineDetailsEvent event,
    Emitter<DisciplineDetailsState> emit,
  ) async {}
}
