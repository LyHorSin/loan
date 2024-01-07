import 'package:flutter/material.dart';
import 'package:managementteam/model/Person.dart';
import 'package:managementteam/view/PersonView.dart';
import 'package:managementteam/view/RegisterPersonView.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({
    required this.people,
  });

  final List<Person> people;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var results = people
        .where((element) =>
            (element.name?.toLowerCase() ?? "").contains(query.toLowerCase()) ||
            (element.phone?.toLowerCase() ?? "")
                .contains(query.toLowerCase()) ||
            (element.birthDay?.toLowerCase() ?? "")
                .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (c, index) {
        return GestureDetector(
          child: PersonView(
            person: results[index],
            config: PersonViewConfig(bgColor: Colors.pink.withAlpha(50)),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterPersonView(
                  person: results[index],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}