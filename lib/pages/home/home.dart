import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/dio-client.dart';
import 'package:rick_and_morty/global-variable.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/pages/home/home-bloc.dart';
import 'package:rick_and_morty/pages/home/home-repository.dart';
import 'package:rick_and_morty/pages/home/widgets/character-item.dart';
import 'package:rick_and_morty/pages/home/widgets/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode _focus = new FocusNode();

  TextEditingController _searchController = TextEditingController();
  ScrollController _listController = ScrollController();
  List<Character> characters = [];
  List<Character> searchResult = [];
  final DioClient _client = DioClient();
  HomeBloc _homeBloc;
  int page = 1;
  bool haveMoreData;

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
            appBar: AppBar(
              title: Text('Rick And Morty'),
            ),
            body: _buildBody(),
          ),
        ));
  }

  _manageState() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        _homeBloc = context.read<HomeBloc>();
        haveMoreData = GlobVariable().getCharacterListStatus();
        if (state is HomeUninitialized) {
          // initial the screen
          context
              .read<HomeBloc>()
              .add(GetCharacters(page, context, _client, true));
        } else if (state is HomeLoading) {
          // get data
          return _buildRegularLoading();
        } else if (state is SearchStatusUpdate) {
          // update search status
          characters.clear();
          if (!_homeBloc.isSearching) {
            context
                .read<HomeBloc>()
                .add(GetCharacters(page, context, _client, true));
          }
        } else if (state is CharactersReady) {
          // data are ready
          characters.addAll(state.getResult);

          _homeBloc.isLoading = false;
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
    return ListView.separated(
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

  void _onSearchChange(String searchText) {
    characters.clear();
    _homeBloc.add(
        GetCharacters(page, context, _client, true, searchText: searchText));
  }

  void _onFocusChange() {
    _homeBloc.add(ChangeSearchStatus());
  }

  void _onListviewChange() {
    if ((_listController.offset >=
            (_listController.position.maxScrollExtent * 0.8)) &&
        !_homeBloc.isLoading &&
        haveMoreData) {
      page++;
      _homeBloc.add(GetCharacters(page, context, _client, false));
      _homeBloc.isLoading = true;
    }
  }
}
