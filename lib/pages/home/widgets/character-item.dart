import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/helper.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  CharacterItem(this.character);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).colorScheme.secondary,
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
                height: 119,
                width: 119,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 21),
                decoration: BoxDecoration(
                  color: customTheme(context).currentColor.surface,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // title
                        Text(
                          character.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),

                        // status
                        _buildStatusWidget(context),
                      ],
                    ),

                    // info
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: _buildInfoWidget(
                              context, 'Species', character.species),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildInfoWidget(
                              context, 'Gender', character.gender),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildInfoWidget(BuildContext context, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(
          title + ':',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        // value
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  _buildStatusWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: character.status == LifeStatus.Alive
                  ? const Color(0xFF50CD30)
                  : character.status == LifeStatus.Dead
                      ? const Color(0xFFC82B2F)
                      : Color.fromARGB(255, 230, 216, 135),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 6),
            child: Text(
              character.status == LifeStatus.Alive
                  ? 'Alive'
                  : character.status == LifeStatus.Dead
                      ? 'Dead'
                      : 'Unknown',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
