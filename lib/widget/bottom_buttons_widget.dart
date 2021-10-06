import 'package:dateapp/page/my_swiped_list.dart';
import 'package:flutter/material.dart';

class BottomButtonsConstant {
  static const USER_LIST = 'user list';
  static const LIKE_LIST = 'like list';
  static const PASS_LIST = 'pass list';
}

class BottomButtonsWidget extends StatefulWidget {
  final Function callback;

  const BottomButtonsWidget({Key? key, required this.callback}) : super(key: key);
  @override
  _BottomButtonsWidgetState createState() => _BottomButtonsWidgetState();
}

class _BottomButtonsWidgetState extends State<BottomButtonsWidget> {
  @override
  Widget build(BuildContext context) => Container(
    height: 70,
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                widget.callback(BottomButtonsConstant.PASS_LIST);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: Colors.red),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.callback(BottomButtonsConstant.USER_LIST);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.star, color: Colors.blue),

              ),
            ),
            GestureDetector(
              onTap: () {
                widget.callback(BottomButtonsConstant.LIKE_LIST);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.favorite, color: Colors.green),
              ),
            ),
          ],
        ),
  );
}
