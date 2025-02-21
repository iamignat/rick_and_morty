// ignore_for_file: prefer_single_quotes

import 'package:flutter/material.dart';
import 'package:rick_and_morty/feature/presentation/widgets/custom_search_delegate.dart';
import 'package:rick_and_morty/feature/presentation/widgets/persons_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Characters",
          style: TextStyle(
              // color: Colors.white,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            ),
            color: Colors.white,
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: PersonsList(),
    );
  }
}
