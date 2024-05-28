import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';
import 'package:weather_test/features/city/domain/usecases/get_cities_by_keyword_usecase.dart';
import 'package:weather_test/features/city/presentation/widgets/city_search_bar/blocs/get_cities_by_keyword_bloc/get_cities_by_keyword_event.dart';
import 'package:weather_test/features/city/presentation/widgets/city_search_bar/blocs/get_cities_by_keyword_bloc/get_cities_by_keyword_state.dart';

export 'package:weather_test/features/city/presentation/widgets/city_search_bar/blocs/get_cities_by_keyword_bloc/get_cities_by_keyword_event.dart';
export 'package:weather_test/features/city/presentation/widgets/city_search_bar/blocs/get_cities_by_keyword_bloc/get_cities_by_keyword_state.dart';

const _debounceSearchDelay = Duration(milliseconds: 300);

class GetCitiesByKeywordBloc extends Bloc<GetCitiesByKeywordEvent, GetCitiesByKeywordState> {
  final GetCitiesByKeyWordUseCase _getCitiesByKeyWordUseCase;

  GetCitiesByKeywordBloc({
    required GetCitiesByKeyWordUseCase getCitiesByKeyWordUseCase,
  })  : _getCitiesByKeyWordUseCase = getCitiesByKeyWordUseCase,
        super(const GetCitiesByKeywordState([])) {
    on<GetCitiesByKeywordEvent>(
      _onGetCitiesByKeyword,
      transformer: (events, mapper) => events.debounceTime(_debounceSearchDelay).switchMap(mapper),
    );
  }

  FutureOr<void> _onGetCitiesByKeyword(
    GetCitiesByKeywordEvent event,
    Emitter<GetCitiesByKeywordState> emit,
  ) async {
    try {
      final result = await _getCitiesByKeyWordUseCase(event.keyword);

      return emit(GetCitiesByKeywordState(List.unmodifiable(result)));
    } on Exception catch (_) {
      rethrow;
    }
  }
}
