import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ra7al/repositories/adhan_repository.dart';

part 'adhan_event.dart';
part 'adhan_state.dart';

class AdhanBloc extends Bloc<AdhanEvent, AdhanState> {
  final AdhanRepository adhanRepository;

  AdhanBloc({required this.adhanRepository}) : super(AdhanInitial()) {
    on<FetchAdhanTiming>(_onFetchAdhanTiming);
  }

  Future<void> _onFetchAdhanTiming(
    FetchAdhanTiming event,
    Emitter<AdhanState> emit,
  ) async {
    emit(AdhanLoading());
    try {
      final adhanTimings = await adhanRepository.getAdhanTiming();
      emit(AdhanLoaded(adhanTimings));
    } catch (e) {
      emit(AdhanError(e.toString()));
    }
  }
}
