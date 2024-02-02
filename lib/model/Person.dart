// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));

String personToJson(Person data) => json.encode(data.toJson());

class Person {
  int? id;
  int? userId;
  String? name;
  String? birthDay;
  String? phone;
  String? sex;
  String? latin;
  String? address;
  String? currentAddress;
  String? job;
  String? status;
  String? comment;
  String? branch;

  Person({
    this.id,
    this.userId,
    this.name,
    this.birthDay,
    this.phone,
    this.sex,
    this.latin,
    this.address,
    this.currentAddress,
    this.job,
    this.status,
    this.comment,
    this.branch,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        birthDay: json["birth_day"],
        phone: json["phone"],
        sex: json["sex"],
        latin: json["latin"],
        address: json["address"],
        currentAddress: json["current_address"],
        comment: json["comment"],
        job: json["job_title"],
        status: json["status"],
        branch: json["branch"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "latin": latin,
        "birth_day": birthDay,
        "phone": phone,
        "sex": sex,
        "branch": branch,
        "address": address,
        "current_address": currentAddress,
        "comment": comment,
        "job_title": job,
        "status": status
      };
}
