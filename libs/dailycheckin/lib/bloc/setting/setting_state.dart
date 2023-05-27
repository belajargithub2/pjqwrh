part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingSuccess extends SettingState {
  final SettingModel settingModel;
  const SettingSuccess(this.settingModel);
}

class SettingError extends SettingState {
  final String? message;
  const SettingError(this.message);
}
