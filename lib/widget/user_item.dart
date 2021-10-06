import 'package:cached_network_image/cached_network_image.dart';
import 'package:dateapp/api/result/user_list.dart';
import 'package:dateapp/model/user.dart';
import 'package:flutter/material.dart';
class UserItem extends StatelessWidget {
  final Users user;
  const UserItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(user.picture);
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 40,
            width: 40,
            fit: BoxFit.cover,
            imageUrl: user.picture.toString(),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(user.firstName.toString(), style: TextStyle(color: Colors.grey, fontSize: 14),),
          )
        ],
      ),
    );
  }
}
