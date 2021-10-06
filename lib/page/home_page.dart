import 'dart:math';

import 'package:dateapp/api/request/get_data_request.dart';
import 'package:dateapp/api/result/result.dart';
import 'package:dateapp/api/result/user_list.dart';
import 'package:dateapp/data/users.dart';
import 'package:dateapp/model/user.dart';
import 'package:dateapp/page/my_swiped_list.dart';
import 'package:dateapp/provider/feedback_position_provider.dart';
import 'package:dateapp/utils/constants.dart';
import 'package:dateapp/widget/bottom_buttons_widget.dart';
import 'package:dateapp/widget/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Users>? users = [];

  final List<Users> swipedUser = [];

  UserList? userList;

  String title = '';

  bool isLoading = false;

  bool thereIsNoMore = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callGetUserListRequest();
  }

  /// Call cod report request
  Future<Result> _getUserList() async {
    final headers = await getHeaders();
    Map<String,dynamic> data = Map();
    data['limit'] = 10;
    return await GetUserList().callRequest(context, headers: headers, queries: data);
  }

  void _callGetUserListRequest() async {
    isLoading = true;
    final Result result = await _getUserList();
    if(result.isSuccess()) {
      userList = result.data;
      users = userList!.data;
      print(users.toString());
      setState(() {
        isLoading = false;
      });
    } else {
      users = dummyUsers;
      print('error');
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Get headers
  Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = Map();
    headers['app-id'] = APIKey.api;
    return headers;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                print('change language');
              },
              child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.language, color: Colors.grey,)),
            )
          ],
          leading: Icon(Icons.person, color: Colors.grey),
          title: FaIcon(FontAwesomeIcons.fire, color: Colors.deepOrange),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
             !isLoading ? users!.isEmpty
                  ? wantMore()
                  : Stack(children: users!.map(buildUser).toList()) : CircularProgressIndicator(),
              Expanded(child: Container()),
              BottomButtonsWidget(callback: _handleGoToUserList,)
            ],
          ),
        ),
      );

  Widget wantMore() {
    Random random = new Random();
    int randomNumber = random.nextInt(6) + 1;
    if(thereIsNoMore) {
      return Container(
        child: Column(
          children: [
            Text("There is no more hehe, that's enough"),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Image.asset('assets/user$randomNumber.jpg'),
            )
          ],
        ),
      );
    }
    return TextButton(onPressed: () {
      setState(() {
        thereIsNoMore = true;
      });
    }, child: Text('Want more'));
  }

  Widget buildUser(Users user) {
    final userIndex = users!.indexOf(user);
    final isUserInFocus = userIndex == users!.length - 1;

    return Listener(
      onPointerMove: (pointerEvent) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.updatePosition(pointerEvent.localDelta.dx);
      },
      onPointerCancel: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      onPointerUp: (_) {
        final provider =
            Provider.of<FeedbackPositionProvider>(context, listen: false);
        provider.resetPosition();
      },
      child: Draggable(
        child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: UserCardWidget(user: user, isUserInFocus: isUserInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => onDragEnd(details, user),
      ),
    );
  }

  void onDragEnd(DraggableDetails details, Users user) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      user.isSwipedOff = true;
      swipedUser.add(user);
    } else if (details.offset.dx < -minimumDrag) {
      user.isLiked = true;
      swipedUser.add(user);
    }

    setState(() => users!.remove(user));
  }


  _handleGoToUserList(String value) {
    List<Users> mySwipeUsers = [];
    if(value == BottomButtonsConstant.USER_LIST) {
      mySwipeUsers = swipedUser;
      title = 'Swiped List';
    }
    else if(value == BottomButtonsConstant.PASS_LIST) {
      mySwipeUsers = swipedUser.where((element) => element.isSwipedOff == true).toList();
      title = 'Passed List';
    }
    else if(value == BottomButtonsConstant.LIKE_LIST) {
      mySwipeUsers = swipedUser.where((element) => element.isLiked == true).toList();
      title = 'Liked List';
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return MySwipedListPage(userList: mySwipeUsers, title: title);
        },)
    );

  }
}
