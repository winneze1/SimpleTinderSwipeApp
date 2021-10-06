import 'dart:math';

class UserList {
  List<Users>? data;
  int? total;
  int? page;
  int? limit;

  UserList({this.data, this.total, this.page, this.limit});

  UserList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new Users.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class Users {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? age;
  bool? isLiked;
  bool? isSwipedOff;


  Users({this.id, this.title, this.firstName, this.lastName, this.picture, this.age, this.isLiked = false, this.isSwipedOff = false});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['picture'] = this.picture;
    return data;
  }
}