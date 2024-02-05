import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:managementteam/model/Person.dart';
import 'package:managementteam/util/sqllite/SQLLiteManager.dart';

class RegisterPersonView extends StatefulWidget {
  const RegisterPersonView({super.key, this.person});

  final Person? person;

  @override
  State<RegisterPersonView> createState() => _RegisterPersonViewState();
}

class _RegisterPersonViewState extends State<RegisterPersonView> {
  var _person = Person();

  final _branchController = TextEditingController();
  final _nameController = TextEditingController();
  final _latinController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  // Current Address
  final _currentVillageController = TextEditingController();
  final _currentCommuneController = TextEditingController();
  final _currentDistrictController = TextEditingController();
  final _currentProvinceController = TextEditingController();

  // birth Address
  final _addressVillageController = TextEditingController();
  final _addressCommuneController = TextEditingController();
  final _addressDistrictController = TextEditingController();
  final _addressProvinceController = TextEditingController();

  final _commendController = TextEditingController();
  final _jobController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.person != null) {
      _person = widget.person!;

      final branch = _person.branch ?? "";
      final englishName = _person.name ?? "";
      final latin = _person.latin ?? "";
      final phone = _person.phone ?? "";
      final address = _person.address ?? "";
      final comment = _person.comment ?? "";
      final job = _person.job ?? "";

      // birth address
      final addressVillage = _person.addressVillage ?? "";
      final addressDistrict = _person.addressDistrict ?? "";
      final addressCommune = _person.addressCommune ?? "";
      final addressProvince = _person.addressProvince ?? "";

      _addressVillageController.text = addressVillage;
      _addressDistrictController.text = addressDistrict;
      _addressCommuneController.text = addressCommune;
      _addressProvinceController.text = addressProvince;

      // current address
      final currentVillage = _person.currentVillage ?? "";
      final currentDistrict = _person.currentDistrict ?? "";
      final currentCommune = _person.currentCommune ?? "";
      final currentProvince = _person.currentProvince ?? "";

      _currentVillageController.text = currentVillage;
      _currentDistrictController.text = currentDistrict;
      _currentCommuneController.text = currentCommune;
      _currentProvinceController.text = currentProvince;

      _branchController.text = branch;
      _nameController.text = englishName;
      _latinController.text = latin;
      _phoneController.text = phone;
      _addressController.text = address;
      _commendController.text = comment;
      _jobController.text = job;
    }
  }

  bool _enable() {
    var enable = true;
    final englishName = _person.name ?? "";
    final latin = _person.latin ?? "";
    final birthDay = _person.birthDay ?? "";
    final sex = _person.sex ?? "";
    final phone = _person.phone ?? "";
    final comment = _person.comment ?? "";
    final job = _person.job ?? "";
    final status = _person.status ?? "";

    final addressVillage = _person.addressVillage ?? "";
    final addressDistrict = _person.addressDistrict ?? "";
    final addressCommune = _person.addressCommune ?? "";
    final addressProvince = _person.addressProvince ?? "";

    final currentVillage = _person.currentVillage ?? "";
    final currentDistrict = _person.currentDistrict ?? "";
    final currentCommune = _person.currentCommune ?? "";
    final currentProvince = _person.currentProvince ?? "";

    if (englishName.isEmpty ||
        latin.isEmpty ||
        birthDay.isEmpty ||
        sex.isEmpty ||
        phone.isEmpty ||
        addressVillage.isEmpty ||
        addressDistrict.isEmpty ||
        addressCommune.isEmpty ||
        addressProvince.isEmpty ||
        currentVillage.isEmpty ||
        currentDistrict.isEmpty ||
        currentCommune.isEmpty ||
        currentProvince.isEmpty ||
        comment.isEmpty ||
        job.isEmpty ||
        status.isEmpty) {
      enable = false;
    }

    return enable;
  }

  void _validatForm() {
    final branch = _person.branch ?? "";
    final englishName = _person.name ?? "";
    final latin = _person.latin ?? "";
    final birthDay = _person.birthDay ?? "";
    final sex = _person.sex ?? "";
    final phone = _person.phone ?? "";
    final comment = _person.comment ?? "";
    final job = _person.job ?? "";
    final status = _person.status ?? "";

    final addressVillage = _person.addressVillage ?? "";
    final addressDistrict = _person.addressDistrict ?? "";
    final addressCommune = _person.addressCommune ?? "";
    final addressProvince = _person.addressProvince ?? "";

    final currentVillage = _person.currentVillage ?? "";
    final currentDistrict = _person.currentDistrict ?? "";
    final currentCommune = _person.currentCommune ?? "";
    final currentProvince = _person.currentProvince ?? "";

    if (branch.isEmpty) {
      _showErrorMessage("សាខា", "សូមបំពេញសាខា");
    } else if (englishName.isEmpty) {
      _showErrorMessage("ឈ្មោះជាភាសាខ្មែរ", "សូមបំពេញឈ្មោះជាភាសាខ្មែរ");
    } else if (latin.isEmpty) {
      _showErrorMessage("ឈ្មោះជាឡាតាំង", "សូមបំពេញឈ្មោះជាឡាតាំង");
    } else if (birthDay.isEmpty) {
      _showErrorMessage("ថ្ងៃ ខែ ឆ្នាំកំណើត", "សូមបំពេញថ្ងៃ ខែ ឆ្នាំកំណើត");
    } else if (sex.isEmpty) {
      _showErrorMessage("ភេទ", "សូមបំពេញភេទ");
    } else if (phone.isEmpty) {
      _showErrorMessage("លេខទំនាក់ទំនង", "សូមបំពេញលេខទំនាក់ទំនង");
    } else if (addressVillage.isEmpty) {
      _showErrorMessage("ទីកន្លែងកំណើត", "សូមបំពេញភូមិ");
    } else if (addressDistrict.isEmpty) {
      _showErrorMessage("ទីកន្លែងកំណើត", "សូមបំពេញឃុំ");
    } else if (addressCommune.isEmpty) {
      _showErrorMessage("ទីកន្លែងកំណើត", "សូមបំពេញស្រុក/ខណ្ឌ");
    } else if (addressProvince.isEmpty) {
      _showErrorMessage("ទីកន្លែងកំណើត", "សូមបំពេញខេត្ត/រាជធានី");
    } else if (currentVillage.isEmpty) {
      _showErrorMessage("លំនៅឋានបច្ទុប្បន្ន", "សូមបំពេញភូមិ");
    } else if (currentDistrict.isEmpty) {
      _showErrorMessage("លំនៅឋានបច្ទុប្បន្ន", "សូមបំពេញឃុំ");
    } else if (currentCommune.isEmpty) {
      _showErrorMessage("លំនៅឋានបច្ទុប្បន្ន", "សូមបំពេញស្រុក/ខណ្ឌ");
    } else if (currentProvince.isEmpty) {
      _showErrorMessage("លំនៅឋានបច្ទុប្បន្ន", "សូមបំពេញខេត្ត/រាជធានី");
    } else if (job.isEmpty) {
      _showErrorMessage("មុខរបរ", "សូមបំពេញមុខរបរ");
    } else if (status.isEmpty) {
      _showErrorMessage("ប្រភេទខ្ចី", "សូមបំពេញប្រភេទការខ្ចី");
    } else if (comment.isEmpty) {
      _showErrorMessage("មតិយោបល់", "សូមបំពេញមតិយោបល់");
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
          "ចុះឈ្មោះ",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Text(
                  "សាខា",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                TextField(
                  controller: _branchController,
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
                    _person.branch = text;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "ឈ្មោះជាភាសាខ្មែរ",
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
                    setState(() {
                      _person.name = text;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "ឈ្មោះជាឡាតាំង",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                TextField(
                  controller: _latinController,
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
                    setState(() {
                      _person.latin = text;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ថ្ងៃ ខែ ឆ្នាំកំណើត",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            child: GestureDetector(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4)),
                                    border: Border.all(
                                        color: Colors.grey, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 8),
                                  child: Text(
                                    _person.birthDay ?? "",
                                  ),
                                ),
                              ),
                              onTap: () async {
                                DateTime? picker = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1000),
                                  lastDate: DateTime(3100),
                                );
                                if (picker != null) {
                                  var format =
                                      DateFormat('dd MMM, yyyy').format(picker);
                                  setState(() {
                                    _person.birthDay = format;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Male',
                          groupValue: _person.sex,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              _person.sex = value ?? "Male";
                            });
                          },
                        ),
                        const Text(
                          "ប្រុស",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Female',
                          groupValue: _person.sex,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              _person.sex = value ?? "Male";
                            });
                          },
                        ),
                        const Text(
                          "ស្រី",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "លេខទំនាក់ទំនង",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
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
                    setState(() {
                      _person.phone = text;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "ទីកន្លែងកំណើត",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ភូមិ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _addressVillageController,
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
                              setState(() {
                                _person.addressVillage = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ឃុំ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _addressDistrictController,
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
                              setState(() {
                                _person.addressDistrict = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ស្រុក/ខណ្ឌ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _addressCommuneController,
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
                              setState(() {
                                _person.addressCommune = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ខេត្ត/រាជធានី",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _addressProvinceController,
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
                              setState(() {
                                _person.addressProvince = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "ទីលំនៅបច្ទុប្បន្ន",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ភូមិ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _currentVillageController,
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
                              setState(() {
                                _person.currentVillage = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ឃុំ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _currentDistrictController,
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
                              setState(() {
                                _person.currentDistrict = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ស្រុក/ខណ្ឌ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _currentCommuneController,
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
                              setState(() {
                                _person.currentCommune = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ខេត្ត/រាជធានី",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          TextField(
                            controller: _currentProvinceController,
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
                              setState(() {
                                _person.currentProvince = text;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "មុខរបរ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                TextField(
                  controller: _jobController,
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
                    setState(() {
                      _person.job = text;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 'អ្នកខ្ចីប្រាក់',
                          groupValue: _person.status,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              _person.status = value ?? "អ្នកខ្ចីប្រាក់";
                            });
                          },
                        ),
                        const Text(
                          "អ្នកខ្ចីប្រាក់",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'មិនមែនអ្នកខ្ចី',
                          groupValue: _person.status,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              _person.status = value ?? "មិនមែនអ្នកខ្ចី";
                            });
                          },
                        ),
                        const Text(
                          "មិនមែនអ្នកខ្ចី",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "មតិយោបល់",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _commendController,
                      cursorColor: Colors.pink,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          _person.comment = text;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
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
                        'ចុះឈ្មោះ',
                        style: TextStyle(
                          color: _enable() ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (_enable()) {
                      final id = _person.id;
                      final userId = SQLLiteManager.share.user?.id;
                      if (userId != null) {
                        _person.address =
                            "${_person.addressVillage} ${_person.addressCommune} ${_person.addressDistrict} ${_person.addressProvince}";
                        _person.currentAddress =
                            "${_person.currentVillage} ${_person.currentCommune} ${_person.currentDistrict} ${_person.currentProvince}";
                        _person.userId = userId;
                        if (id == null) {
                          SQLLiteManager.share
                              .insert(SQLTable.person, _person.toJson());
                        } else {
                          SQLLiteManager.share
                              .update(SQLTable.person, id, _person.toJson());
                        }
                        Navigator.pop(context);
                      }
                    } else {
                      _validatForm();
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
