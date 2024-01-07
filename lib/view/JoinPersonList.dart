import 'dart:io';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:managementteam/util/sqllite/SQLLiteManager.dart';
import 'package:managementteam/view/PersonView.dart';
import 'package:managementteam/view/RegisterPersonView.dart';
import 'package:managementteam/view/SearchPersonView.dart';
import 'package:path_provider/path_provider.dart';

import '../model/Person.dart';

class JoinPersonList extends StatefulWidget {
  const JoinPersonList({super.key});

  @override
  State<JoinPersonList> createState() => _JoinPersonListState();
}

class _JoinPersonListState extends State<JoinPersonList>
    with LifecycleAware, LifecycleMixin {
  List<Person> people = [];

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.active) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "ចុះឈ្មោះអ្នកចូលរួម",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(people: people));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () async {
              await createExcel();
            },
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: SQLLiteManager.share.objects(SQLTable.person),
        builder: (context, snapshot) {
          final data = snapshot.data;
          final people = data?.map((e) => Person.fromJson(e)).toList() ?? [];
          this.people = people;
          return Stack(
            children: [
              ListView.builder(
                itemCount: people.length,
                itemBuilder: (c, index) {
                  return Slidable(
                    key: ValueKey(index),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _remove(people[index]);
                          },
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      child: PersonView(
                        person: people[index],
                        config: PersonViewConfig(bgColor: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPersonView(
                              person: people[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (people.isEmpty)
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 100,
                        color: Colors.white,
                      ),
                      Text(
                        "No Data",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  void _remove(Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove ${person.name ?? ""}"),
          content: const Text("Are you sure you wish to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                await SQLLiteManager.share.remove(
                  SQLTable.person,
                  person.id ?? 0,
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future createExcel() async {
    if (people.isEmpty) {
      _showDialog(
        "Data Unavailable",
        "Currently, there is no data available for export.",
      );
      return;
    }
    DateTime now = DateTime.now();
    final today = "Report-${now.year}-${now.month}-${now.day}";

    var excel = Excel.createExcel();
    var sheet = excel[today];

    final rows = people.length;
    final columns = people.first.toJson().keys.toList();
    for (var i = 0; i < rows + 1; i++) {
      for (var j = 0; j < columns.length; j++) {
        TextCellValue? value;
        if (i == 0) {
          value = TextCellValue(columns[j]);
        } else {
          final key = columns[j];
          final json = people[i - 1].toJson()[key].toString();
          value = TextCellValue(json);
        }
        sheet
            .cell(CellIndex.indexByString(
                '${String.fromCharCode(j + 65)}${i + 1}'))
            .value = value;
      }
    }

    var bytes = excel.save();
    if (bytes != null) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/$today.xlsx'");
      await file.writeAsBytes(bytes);
      await Share.file(today, "$today.xlsx", bytes, "text/xlsx");
    }
  }

  void _showDialog(String title, String messag) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(messag),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }
}
