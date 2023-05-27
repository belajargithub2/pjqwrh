part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  final String baseUrl;
  final String deviceCode;

  const SettingEvent({required this.baseUrl, required this.deviceCode});

  @override
  List<Object> get props => [];
}

class GetSetting extends SettingEvent{
  const GetSetting({required super.baseUrl, required super.deviceCode});
}
