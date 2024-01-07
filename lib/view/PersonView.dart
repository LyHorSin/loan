import 'package:flutter/material.dart';

import '../model/Person.dart';

class PersonViewConfig {

  Color? bgColor = Colors.pink;
  PersonViewConfig({this.bgColor});

}

class PersonView extends StatelessWidget {
  const PersonView({super.key, required this.person, required this.config});

  final Person person;
  final PersonViewConfig config;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            color: config.bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.person_outlined,
                color: Colors.black,
                size: 35,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.name ?? "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(person.birthDay ?? ""),
                  Text(person.phone ?? ""),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

