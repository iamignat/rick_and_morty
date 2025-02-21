import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          person.name,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Text(
              person.name,
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            PersonCacheImage(
              imageUrl: person.image,
              height: 260.0,
              width: 260.0,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 12.0,
                  width: 12.0,
                  decoration: BoxDecoration(
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            if (person.type.isNotEmpty) ..._buildText('Type:', person.type),
            ..._buildText(
              'Gender:',
              person.gender,
            ),
            ..._buildText(
              'Number of episodes:',
              person.episode.length.toString(),
            ),
            ..._buildText(
              'Species:',
              person.species,
            ),
            ..._buildText(
              'Last known location:',
              person.location.name,
            ),
            ..._buildText(
              'Origin:',
              person.origin.name,
            ),
            ..._buildText(
              'Was created:',
              DateFormat('y-M-d').format(person.created).toString(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildText(String text, String value) => [
        Text(
          text,
          style: TextStyle(
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
      ];
}
