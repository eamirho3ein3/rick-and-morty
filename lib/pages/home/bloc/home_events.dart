import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCharacters extends HomeEvent {
  final BuildContext context;
  final int page;
  final String? searchText;
  GetCharacters(this.page, this.context, {this.searchText});
}

class FetchCharacters extends HomeEvent {
  final BuildContext context;
  final int page;
  final String? searchText;
  FetchCharacters(this.page, this.context, {this.searchText});
}

class ChangeSearchStatus extends HomeEvent {
  ChangeSearchStatus();
}

class Reset extends HomeEvent {}
