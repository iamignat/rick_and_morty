import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatelessWidget {
  final ScrollController scrollController = ScrollController();
  PersonsList({super.key});

  void setUpScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListCubit>().loadPersons();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setUpScrollController(context);
    return BlocBuilder<PersonListCubit, PersonListState>(
      builder: (context, state) {
        var persons = <PersonEntity>[];
        bool isLoading = false;
        if (state is PersonListLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonListLoading) {
          persons = state.oldPersonList;
          isLoading = true;
        } else if (state is PersonListLoaded) {
          persons = state.personList;
        } else if (state is PersonListError) {
          return Text(
            state.message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(
                person: persons[index],
              );
            } else {
              Timer(Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[400],
          ),
          itemCount: persons.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _loadingIndicator() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
