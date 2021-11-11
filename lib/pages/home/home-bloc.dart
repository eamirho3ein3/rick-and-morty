import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/dio-client.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/pages/home/home-repository.dart';

class HomeEvent {
  const HomeEvent();
}

class GetCharacters extends HomeEvent {
  final bool isInitialData;
  final BuildContext context;
  final DioClient client;
  final int page;
  final String searchText;
  GetCharacters(this.page, this.context, this.client, this.isInitialData,
      {this.searchText});
}

class ChangeSearchStatus extends HomeEvent {
  ChangeSearchStatus();
}

class Reset extends HomeEvent {}

class HomeState {
  const HomeState();
}

class HomeUninitialized extends HomeState {}

class HomeLoading extends HomeState {}

class SearchStatusUpdate extends HomeState {}

class CharactersReady extends HomeState {
  final List<Character> _result;
  CharactersReady(this._result);
  List<Character> get getResult => _result;
}

class GetError extends HomeState {}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isLoading = false;
  bool isSearching = false;
  bool haveMoreData = true;
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeUninitialized());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetCharacters) {
      if (event.isInitialData) {
        yield HomeLoading();
      }

      try {
        List<Character> result = await homeRepository.getCharacters(
            event.context, event.page, event.searchText, event.client);

        yield CharactersReady(result);
      } catch (error) {
        print("error read from database : $error");

        yield GetError();
      }
    } else if (event is ChangeSearchStatus) {
      isSearching = !isSearching;
      yield SearchStatusUpdate();
    } else if (event is Reset) {
      yield HomeUninitialized();
    }
  }
}
