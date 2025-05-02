part of 'adhan_bloc.dart';

abstract class AdhanState extends Equatable {
  const AdhanState();

  @override
  List<Object> get props => [];
}

class AdhanInitial extends AdhanState {}

class AdhanLoading extends AdhanState {}

class AdhanLoaded extends AdhanState {
  final CityAndAdhan cityAndAdhan;
  const AdhanLoaded(this.cityAndAdhan);

  @override
  List<Object> get props => [cityAndAdhan];
}

class AdhanError extends AdhanState {
  final String message;

  const AdhanError(this.message);

  @override
  List<Object> get props => [message];
}
