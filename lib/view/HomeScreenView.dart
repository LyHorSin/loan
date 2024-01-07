import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:managementteam/util/sqllite/SQLLiteManager.dart';
import 'package:managementteam/view/LoginUserView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'JoinPersonList.dart';
import 'RegisterPersonView.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  Future<void> _saveUser() async {
    final share = await SharedPreferences.getInstance();
    final user = SQLLiteManager.share.user;
    if (user != null) {
      var jsonStr = json.encode(user);
      await share.setString("user", jsonStr);
    } else {
      await share.remove("user");
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
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              SQLLiteManager.share.user = null;
              setState(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginUserView(),
                  ),
                );
              });
            },
            child: const Text("Log out"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.person,
                size: 24,
                color: Colors.white,
              ),
            ),
            onTap: () {
              final user = SQLLiteManager.share.user;
              _showDialog(
                user?.username?.toUpperCase() ?? "User",
                "Are you sure you want to logout of your account?",
              );
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: _saveUser(),
        builder: (context, snapshot) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.apartment,
                      size: 60,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "កម្មវិធីគ្រប់គ្រងព័ត៌មាន",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40.0),
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 30,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "ចុះឈ្មោះអ្នកចូលរួម",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPersonView()),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.fact_check_outlined,
                              size: 30,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "បញ្ជីឈ្មោះអ្នកចូលរួម",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const JoinPersonList()),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
