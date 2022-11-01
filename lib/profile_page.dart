import 'package:flutter/material.dart';



class ProfilePage extends StatelessWidget {

  final username,userid;

  const ProfilePage({Key? key, this.username, this.userid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile page "),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "username:- $username",
              style: Theme.of(context).textTheme.headline6,
            ),
            const  SizedBox(
              height: 100,
            ),
            Text(
              "userid:- $userid",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

