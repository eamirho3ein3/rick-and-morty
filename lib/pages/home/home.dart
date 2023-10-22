import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/pages/home/bloc/home_bloc.dart';
import 'package:rick_and_morty/services/api/api_failure_action.dart';
import 'package:rick_and_morty/services/global-variable.dart';
import 'package:rick_and_morty/models/character.dart';

import 'package:rick_and_morty/pages/home/widgets/character-item.dart';
import 'package:rick_and_morty/pages/home/widgets/search.dart';
import 'package:rick_and_morty/services/helper.dart';

class HomePage extends StatefulWidget {
  static const String route = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode _focus = new FocusNode();

  TextEditingController _searchController = TextEditingController();
  ScrollController _listController = ScrollController();
  List<Character> characters = [];
  List<Character> searchResult = [];
  String? _searchText;
  HomeBloc? _homeBloc;
  int page = 1;
  bool haveMoreData = GlobVariable().getCharacterListStatus();

  @override
  void initState() {
    super.initState();

    _listController.addListener(_onListviewChange);
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.removeListener(_onListviewChange);
    _listController.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(HomeRepository()),
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: customTheme(context).currentColor.background,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: customTheme(context).currentColor.surface,
              title: Text(
                'Rick And Morty',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: customTheme(context).currentColor.secondary),
              ),
            ),
            body: _buildBody(),
          ),
        ));
  }

  _manageState() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        _homeBloc = context.read<HomeBloc>();

        if (state is HomeUninitialized) {
          // initial the screen

          _getData(context);
        } else if (state is HomeLoading) {
          // loading state
          return _buildRegularLoading();
        } else if (state is SearchStatusUpdate) {
          // update search status
          characters.clear();
          if (!_homeBloc!.isSearching) {
            _getData(context);
            // context
            //     .read<HomeBloc>()
            //     .add(GetCharacters(page, context, true));
          }
        } else if (state is CharactersReady) {
          var result = state.getResult.getOrNull();
          if (result != null) {
            // data are ready
            characters.addAll(result);
            _homeBloc!.isLoading = false;
          } else {
            // get error
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onError(state.getResult.left);
            });
          }

          context.read<HomeBloc>().add(Reset());
        } else if (state is GetError) {
          // get error
          return _buildCenterMessage("oops");
        }

        return _buildList();
      },
    );
  }

  _buildBody() {
    return Column(
      children: [
        // search widget
        SearchWidget(_searchController, _onSearchChange, _homeBloc, _focus),

        // list widget
        Expanded(
          child: _manageState(),
        )
      ],
    );
  }

  _buildList() {
    return characters.isEmpty
        ? Center(
            child: Text("No data to show :("),
          )
        : ListView.separated(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            controller: _listController,
            itemBuilder: (context, index) {
              if (haveMoreData && index == characters.length) {
                return _buildRegularLoading();
              } else {
                return CharacterItem(characters[index]);
              }
            },
            separatorBuilder: (context, _) {
              return SizedBox(
                height: 16,
              );
            },
            itemCount: characters.isEmpty
                ? 0
                : haveMoreData
                    ? characters.length + 1
                    : characters.length);
  }

  _buildCenterMessage(String message) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  _buildRegularLoading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        backgroundColor: Colors.black,
      ),
    );
  }

  _onError(DioException error) {
    if (error.response?.statusCode != 404) {
      FailureAction.create(context, error, _getData).show();
    }
  }

  _getData(BuildContext context) {
    _homeBloc!.add(GetCharacters(page, context, searchText: _searchText));
  }

  _fetchData(BuildContext context) {
    _homeBloc!.add(FetchCharacters(page, context, searchText: _searchText));
  }

  void _onSearchChange(String searchText) {
    _searchText = searchText;
    characters.clear();
    page = 1;
    _getData(context);
  }

  void _onFocusChange() {
    _homeBloc!.add(ChangeSearchStatus());
  }

  void _onListviewChange() {
    if ((_listController.offset >=
            (_listController.position.maxScrollExtent * 0.8)) &&
        !_homeBloc!.isLoading &&
        haveMoreData) {
      page++;
      _fetchData(context);
      _homeBloc!.isLoading = true;
    }
  }
}
