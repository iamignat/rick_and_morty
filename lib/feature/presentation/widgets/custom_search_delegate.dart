import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    super.searchFieldLabel = 'Search for characters...',
  });

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: Icon(
            Icons.clear,
          ),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(
          context,
          null,
        ),
        icon: Icon(
          Icons.arrow_back_outlined,
        ),
        tooltip: 'Go back',
      );

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(context, listen: false).add(
      SearchPersons(query: query),
    );

    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonSearchLoaded) {
          final person = state.persons;
          if (person.isEmpty) {
            _showErrorMessage('No characters found');
          }
          return ListView.builder(
            itemCount: person.isNotEmpty ? person.length : 0,
            itemBuilder: (context, index) {
              PersonEntity result = person[index];
              return SearchResult(personResult: result);
            },
          );
        } else if (state is PersonSearchError) {
          return _showErrorMessage(state.message);
        }
        return Center(
          child: Icon(
            Icons.now_wallpaper_outlined,
          ),
        );
      },
    );
  }

  Widget _showErrorMessage(String message) => Container(
        color: Colors.black,
        child: Center(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) => Text(
        _suggestions[index],
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: _suggestions.length,
    );
  }
}
