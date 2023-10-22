import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/pages/home/bloc/home_events.dart';
import 'package:rick_and_morty/pages/home/bloc/home_repository.dart';
import 'package:rick_and_morty/pages/home/bloc/home_states.dart';
import 'package:rick_and_morty/services/helper.dart';
import 'package:rick_and_morty/services/result.dart';

export 'package:rick_and_morty/pages/home/bloc/home_repository.dart';
export 'package:rick_and_morty/pages/home/bloc/home_events.dart';
export 'package:rick_and_morty/pages/home/bloc/home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isLoading = false;
  bool isSearching = false;
  bool haveMoreData = true;

  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeUninitialized()) {
    on<GetCharacters>(_onGetCharacters);
    on<FetchCharacters>(_onFetchCharacters);
    on<ChangeSearchStatus>(_onChangeSearchStatus);

    on<Reset>(_onReset);
  }

  void _onGetCharacters(GetCharacters event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      var result = await homeRepository.getCharacters(
          event.context, event.page, event.searchText);
      emit(CharactersReady(Right(result)));
    } catch (err) {
      print("Error in GetCharacters = $err");
      var error = await checkError(err);
      emit(CharactersReady(Left(error)));
    }
  }

  void _onFetchCharacters(
      FetchCharacters event, Emitter<HomeState> emit) async {
    emit(FetchLoading());

    try {
      var result = await homeRepository.getCharacters(
          event.context, event.page, event.searchText);
      emit(CharactersReady(Right(result)));
    } catch (err) {
      print("Error in GetCharacters = $err");
      var error = await checkError(err);
      emit(CharactersReady(Left(error)));
    }
  }

  void _onChangeSearchStatus(
      ChangeSearchStatus event, Emitter<HomeState> emit) async {
    isSearching = !isSearching;
    emit(SearchStatusUpdate());
  }

  void _onReset(Reset event, Emitter<HomeState> emit) async {
    emit(AuthReset());
  }
}
