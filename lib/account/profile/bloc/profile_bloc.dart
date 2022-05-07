import 'package:balemoya/account/profile/models/models.dart';
import 'package:balemoya/account/profile/repository/repository.dart';
import 'package:balemoya/static/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

/// Importing the `profile_event.dart` and `profile_state.dart` files.
part 'profile_event.dart';
part 'profile_state.dart';

/// `ProfileBloc` is a `Bloc` that takes `ProfileEvent`s and outputs `ProfileState`s
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  /// A constructor that takes a `ProfileEvent` and outputs a `ProfileState`.
  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    /// A class that is used to store data in the device.
    SharedPreference sharedPreference = SharedPreference();

    on<LoadProfileEvent>((event, emit) async {
      emit(LoadingProfile());

      final sessionID = await sharedPreference.getSession().then(
        (value) {
          return value;
        },
      );

      await Future.delayed(Duration(seconds: 2));

      final response = await profileRepository.getProfileInfo(
        sessionID: sessionID[1],
      ) as Map;

      if (response['status'] == 200) {
        emit(
          ProfileLoadDone(
            profileModel: response['userProfile'],
          ),
        );
      }
      if (response['status'] == 404) {
        emit(ProfileLoadingFailed());
      }
    });

    on<ChangeProfilePictureEvent>(((event, emit) async {
      final response = await profileRepository.changeProfilePicture(
        filePath: event.filePath,
      ) as Map;

      if (response['success'] == true) {
        emit(ChangeProfilePictureSuccess());
      }
      emit(ChangeProfilePictureFailed());
    }));

    on<DeleteAccountEvent>(((event, emit) async {
      final sessionID = await sharedPreference.getSession().then(
        (value) {
          return value;
        },
      );

      final response = await profileRepository.deleteAccount(
        sessionID: sessionID,
      ) as Map;

      if (response['status'] == 200) {
        emit(DeleteAccountSuccess());
      }
      emit(DeleteAccountFailed());
    }));

    on<ResumeBuilderEvent>(((event, emit) async {}));

    on<ResetPasswordEvent>(((event, emit) async {}));

    on<EditPortfolioEvent>(((event, emit) async {
      final response = await profileRepository.editPortfolio(
        editedText: event.editedText,
      ) as Map;
      if (response['status'] == 200) {
        emit(PortfolioUpdateSuccess());
      }
      emit(PortfolioUpdateFailed());
    }));

    on<EditSkillsEvent>(((event, emit) async {
      final response = await profileRepository.editSkills(
        skills: event.editedSkills,
      ) as Map;

      if (response['status'] == 200) {
        emit(SkillsUpdateSuccess());
      }
      emit(SkillsUpdateFailed());
    }));

    on<UploadCVEvent>(((event, emit) async {
      final response = await profileRepository.uploadCV(
        filePath: event.filePath,
      ) as Map;

      if (response['success'] == true) {
        emit(UploadCVSuccess());
      }
      emit(UploadCVFailed());
    }));
  }
}
