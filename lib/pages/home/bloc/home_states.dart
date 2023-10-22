import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/result.dart';

class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeUninitialized extends HomeState {}

class HomeLoading extends HomeState {}

class FetchLoading extends HomeState {}

class SearchStatusUpdate extends HomeState {}

class CharactersReady extends HomeState {
  final Result<DioException, List<Character>> _result;
  CharactersReady(this._result);
  Result<DioException, List<Character>> get getResult => _result;
}

class GetError extends HomeState {}

class AuthReset extends HomeState {}
