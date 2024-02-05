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

  String? job;
  String? status;
  String? comment;
  String? branch;
  // current address
  String? currentAddress;
  String? currentVillage;
  String? currentCommune;
  String? currentDistrict;
  String? currentProvince;
  // Birth Address
  String? address;
  String? addressVillage;
  String? addressCommune;
  String? addressDistrict;
  String? addressProvince;

  Person({
    this.id,
    this.userId,
    this.name,
    this.birthDay,
    this.phone,
    this.sex,
    this.latin,
    this.address,
    this.addressVillage,
    this.addressDistrict,
    this.addressCommune,
    this.addressProvince,
    this.currentAddress,
    this.currentVillage,
    this.currentDistrict,
    this.currentCommune,
    this.currentProvince,
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
        addressVillage: json["address_village"],
        addressDistrict: json["address_district"],
        addressCommune: json["address_commune"],
        addressProvince: json["address_province"],
        currentAddress: json["current_address"],
        currentVillage: json["current_village"],
        currentDistrict: json["current_district"],
        currentCommune: json["current_commune"],
        currentProvince: json["current_province"],
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
        "address_village": addressVillage,
        "address_district": addressDistrict,
        "address_commune": addressCommune,
        "address_province": addressProvince,
        "address": address,
        "current_village": currentVillage,
        "current_district": currentDistrict,
        "current_commune": currentCommune,
        "current_province": currentProvince,
        "current_address": currentAddress,
        "comment": comment,
        "job_title": job,
        "status": status
      };
}
