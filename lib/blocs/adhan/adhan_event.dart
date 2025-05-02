part of 'adhan_bloc.dart';

abstract class AdhanEvent extends Equatable {
  const AdhanEvent();

  @override
  List<Object> get props => [];
}

class FetchAdhanTiming extends AdhanEvent {}
