import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'individualprofile_event.dart';
part 'individualprofile_state.dart';

class IndividualprofileBloc extends Bloc<IndividualprofileEvent, IndividualprofileState> {
  IndividualprofileBloc() : super(IndividualprofileInitial()) {
    on<IndividualprofileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
