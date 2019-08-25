 import 'package:flutter/material.dart';

AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        color: Color(0xffdddddd),
        onPressed: () => {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.menu,
          ),
          color: Color(0xffdddddd),
          onPressed: () => {},
        ),
      ],
      title: Text(''),
    );
  }