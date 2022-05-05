import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

/// Importing the `profile_event.dart` and `profile_state.dart` files.
part 'profile_event.dart';
part 'profile_state.dart';

/// `ProfileBloc` is a `Bloc` that takes `ProfileEvent`s and outputs `ProfileState`s
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  /// A constructor that takes a `ProfileEvent` and outputs a `ProfileState`.
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async{
      // 
    });
  }
}
