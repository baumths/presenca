import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/discipline.dart';
import '../../../domain/failures/disciplines/discipline_failure.dart';
import '../../../domain/repositories/disciplines_repository.dart';

part 'discipline_form_bloc.freezed.dart';
part 'discipline_form_event.dart';
part 'discipline_form_state.dart';

class DisciplineFormBloc
    extends Bloc<DisciplineFormEvent, DisciplineFormState> {
  DisciplineFormBloc({
    required DisciplinesRepository disciplinesRepository,
  })  : _disciplinesRepository = disciplinesRepository,
        super(DisciplineFormState.initial()) {
    on<DisciplineFormEvent>(_onEvent);
  }

  final DisciplinesRepository _disciplinesRepository;

  Future<void> _onEvent(
    DisciplineFormEvent event,
    Emitter<DisciplineFormState> emit,
  ) async {
    await event.map(
      initialized: (event) => _onInitialized(event, emit),
      nameChanged: (event) => _onNameChanged(event, emit),
      submitted: (event) => _onSubmitted(event, emit),
    );
  }

  Future<void> _onInitialized(
    DisciplineFormInitialized event,
    Emitter<DisciplineFormState> emit,
  ) async {
    event.initialDisciplineOption.fold(
      () {},
      (initialDiscipline) {
        emit(
          state.copyWith(
            discipline: initialDiscipline,
            isEditing: true,
            saveFailureOrSuccessOption: const None(),
          ),
        );
      },
    );
  }

  Future<void> _onNameChanged(
    DisciplineFormNameChanged event,
    Emitter<DisciplineFormState> emit,
  ) async {
    final String name = event.name.trim();

    if (name.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Por favor, informe um nome.',
          saveFailureOrSuccessOption: const None(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          discipline: state.discipline.copyWith(name: name),
          errorMessage: null,
          saveFailureOrSuccessOption: const None(),
        ),
      );
    }
  }

  Future<void> _onSubmitted(
    DisciplineFormSubmitted event,
    Emitter<DisciplineFormState> emit,
  ) async {
    emit(
      state.copyWith(
        isSaving: true,
        saveFailureOrSuccessOption: const None(),
        errorMessage: null,
      ),
    );

    Either<DisciplineFailure, Unit>? failureOrSuccess;

    // Update the creation time to the time of the submission
    final discipline = state.discipline.copyWith(createdAt: DateTime.now());

    if (discipline.validate()) {
      failureOrSuccess = await _disciplinesRepository.save(discipline);
    }

    emit(
      state.copyWith(
        discipline: discipline,
        isSaving: false,
        errorMessage: null,
        saveFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }

  // TODO(future): check if discipline name already exists
  bool _validateName(String name) => name.isNotEmpty;
}
