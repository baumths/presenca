import 'package:bloc/bloc.dart';

part 'event.dart';
part 'state.dart';

class AttendanceFormBloc
    extends Bloc<AttendanceFormEvent, AttendanceFormState> {
  AttendanceFormBloc() : super(AttendanceFormState());
}
