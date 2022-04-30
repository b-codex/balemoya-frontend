import 'package:balemoya/job/home/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    // logout event
    on<LogoutEvent>(
      (event, emit) async {
        var response = await homeRepository.logout() as Map;

        if (response['status'] == 200) {
          emit(LoggedOut());
        } else {
          emit(LoggingOutFailed());
        }
      },
    );

    // account button clicked event
    on<AccountButtonClick>(
      (event, emit) {
        
      },
    );
  }
}
