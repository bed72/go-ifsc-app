import 'package:flutter/material.dart';

class UserModel {
  String name;
  String email;
  String tokenCell;
  String password;
  String passwordConfirmation;

  UserModel({
    @required this.name,
    @required this.email,
    @required this.tokenCell,
    @required this.password,
    @required this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'tokenCell': tokenCell,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    tokenCell = json['token_cell'];
    password = json['password'];
    passwordConfirmation = json['passwordConfirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['token_cell'] = this.tokenCell;
    data['password'] = this.password;
    data['passwordConfirmation'] = this.passwordConfirmation;
    return data;
  }
}
