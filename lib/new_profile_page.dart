import 'package:flutter/material.dart';


class NewProfilePage extends StatelessWidget {
  final  profilePictureLink,username,emailId,firstname,lastName,phoneNumber,userId;
  const NewProfilePage({Key? key, required this.profilePictureLink, required this.username, required this.emailId, required this.firstname, required this.lastName, required this.phoneNumber, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Profile Page"),
      ),
      body: Center(
        child: Column(
          children: [

            const SizedBox(height: 20,),
            Container(
                height: 100,
                width: 100,
                child: Image.network(profilePictureLink.toString())),
            const SizedBox(height: 20,),
            Text("User Name : $username"),
            const SizedBox(height: 20,),
            Text("User ID :  $userId"),
            const SizedBox(height: 20,),
            Text("First Name : $firstname"),
            const SizedBox(height: 20,),
            Text("Last Name :  $lastName"),
            const SizedBox(height: 20,),
            Text("Email ID :  $emailId"),
            const SizedBox(height: 20,),
            Text("Phone Number :  $phoneNumber"),

          ],
        ),
      ),
    );
  }
}

