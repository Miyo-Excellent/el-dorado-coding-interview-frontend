import 'package:equatable/equatable.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/personal_information_model.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/get_profile.dart';
import 'package:el_dorado_coding_interview_frontend/domain/usecases/save_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final PersonalInformationModel profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final SaveProfileUseCase saveProfileUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.saveProfileUseCase,
  }) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    try {
      emit(ProfileLoading());
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> saveProfile(PersonalInformationModel info) async {
    try {
      emit(ProfileLoading());
      await saveProfileUseCase(info);
      emit(ProfileLoaded(info));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
