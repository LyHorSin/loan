import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:managementteam/model/User.dart';
import 'package:managementteam/view/HomeScreenView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'util/sqllite/SQLLiteManager.dart';
import 'view/LoginUserView.dart';

void main() async {
  await initDB();
  runApp(const Application());
}

Future<void> initDB() async {
  WidgetsFlutterBinding.ensureInitialized();
  await createDatabase();
}

Future<void> createDatabase() async {
  await SQLLiteManager.share.createDatabase();
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [defaultLifecycleObserver],
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          final str = snapshot.data?.getString("user");
          if (str != null) {
            Map<String, dynamic>? jsonObject = json.decode(str);
            if (jsonObject != null) {
              final user = User.fromJson(jsonObject);
              SQLLiteManager.share.user = user;
              return const HomeScreenView();
            }
          }

          return const LoginUserView();
        },
      ),
    );
  }
}
