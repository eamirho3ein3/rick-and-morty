import 'package:flutter/material.dart';
import 'package:rick_and_morty/pages/home/bloc/home_bloc.dart';

class SearchWidget extends StatelessWidget {
  final FocusNode focus;
  final TextEditingController controller;
  final HomeBloc? homeBloc;
  final Function onSearchChange;
  SearchWidget(this.controller, this.onSearchChange, this.homeBloc, this.focus);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          hintText: 'Search Name',
          hintStyle: Theme.of(context).textTheme.bodyText1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.search,
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
        ),
        focusNode: focus,
        onChanged: (String searchText) {
          onSearchChange(searchText);
        },
      ),
    );
  }
}
