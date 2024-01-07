import 'package:flutter/material.dart';
import 'package:managementteam/model/User.dart';
import 'package:managementteam/util/sqllite/SQLLiteManager.dart';
import 'package:managementteam/view/HomeScreenView.dart';

class LoginUserView extends StatefulWidget {
  const LoginUserView({super.key});

  @override
  State<LoginUserView> createState() => _LoginUserViewState();
}

class _LoginUserViewState extends State<LoginUserView> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _enable() {
    var enable = true;
    final name = _nameController.text;
    final password = _passwordController.text;

    if (name.isEmpty || password.isEmpty) {
      enable = false;
    }

    return enable;
  }

  void _validatForm() {
    final name = _nameController.text;
    final password = _passwordController.text;

    if (name.isEmpty) {
      _showErrorMessage("ឈ្មោះគណនី", "សូមបំពេញឈ្មោះគណនី");
    } else if (password.isEmpty) {
      _showErrorMessage("លេខសម្ងាត់", "សូមបំពេញលេខសម្ងាត់");
    }
  }

  void _showErrorMessage(String title, String messag) {
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
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60.0),
                  const Center(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Center(
                    child: Text(
                      "ចូលប្រើប្រាស់",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    "ឈ្មោះគណនី",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    cursorColor: Colors.pink,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    style: const TextStyle(height: 44.0 / 44.0),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    "លេខសម្ងាត់",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    cursorColor: Colors.pink,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    style: const TextStyle(height: 44.0 / 44.0),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ],
              ),
              GestureDetector(
                child: Container(
                  height: 44.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _enable() ? Colors.white : Colors.black12,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(
                    child: Text(
                      'ចូលប្រើប្រាស់',
                      style: TextStyle(
                        color: _enable() ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (_enable()) {
                    var user = User.isExistingUser(
                        _nameController.text, _passwordController.text);
                    if (user != null) {
              
                      SQLLiteManager.share.user = user;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreenView(),
                        ),
                      );
                    } else {
                      _showErrorMessage(
                        "No account found.",
                        "It looks like ${_nameController.text} isn't connected to an account.",
                      );
                    }
                  } else {
                    _validatForm();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
