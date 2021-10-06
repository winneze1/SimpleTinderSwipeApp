import 'package:dateapp/api/result/user_list.dart';
import 'package:dateapp/model/user.dart';
import 'package:dateapp/widget/user_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MySwipedListPage extends StatefulWidget {
  final List<Users> userList;
  final String title;
  const MySwipedListPage({Key? key, required this.userList, required this.title}) : super(key: key);

  @override
  _MySwipedListPageState createState() => _MySwipedListPageState();
}

class _MySwipedListPageState extends State<MySwipedListPage> {

  List<Users> swipedUser = [];

  @override
  void initState() {
    // TODO: implement initState
    swipedUser = widget.userList.cast<Users>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: swipedUser.length,
            itemBuilder: (context, index) {
              Users item = swipedUser[index];
              return UserItem(user: item,);
            },
        )
      ),
    );
  }
}
