import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mydynamiclink/new_profile_page.dart';
import 'package:mydynamiclink/profile_page.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _MainScreen(),
    );
  }
}

class _MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {


  PendingDynamicLinkData? initialLink;
  String? username, userid;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {

    initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
   // getDataFromQueryparams(initialLink);
     getDataFromLink(initialLink);
    dynamicLinks.onLink.listen((dynamicLinkData) {
    // getDataFromQueryparams(dynamicLinkData);
        getDataFromLink(dynamicLinkData);
    }).onError((error) {
      print(error.message);
    });
  }


  void getDataFromQueryparams(final initialLink){
    final Uri? uri = initialLink?.link;
    final queryParams = uri?.queryParameters;
    if (uri.toString().contains("profileDetails")) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewProfilePage(
              profilePictureLink: queryParams?["profilePictureLink"],
              username: queryParams?["username"].toString(),
              emailId: queryParams?["emailID"].toString(),
              firstname: queryParams?["firtsName"].toString(),
              lastName: queryParams?["lastname"].toString(),
              phoneNumber: queryParams?["phoneNumber"].toString(),
              userId: queryParams?["userID"].toString(),
            )),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                username: queryParams?["username"],
                userid: queryParams?["userid"],
              )));
    }
  }

  void getDataFromLink(final dynamicLinkData) {
    final Uri? uri = dynamicLinkData?.link;
    final allParamsList = uri.toString().split("?");
    //logic for getting the particular key data

    if (dynamicLinkData.toString().contains("profileDetails")) {
      String profilePictureLink = "";
      String username = "";
      String emailId = "";
      String firstname = "";
      String lastName = "";
      String phoneNumber = "";
      String userId = "";


      for (int i = 0; i < allParamsList.length; i++) {
        if (allParamsList[i].contains("username")) {
          final usernameVariable = allParamsList[i];
          username = usernameVariable.split("username=").last;
        } else if (allParamsList[i].contains("userID")) {
          final usernameVariable = allParamsList[i];
          userId = usernameVariable.split("userID%3D").last;
        } else if (allParamsList[i].contains("emailID")) {
          final usernameVariable = allParamsList[i];
          emailId = usernameVariable.split("emailID%3D").last;
        } else if (allParamsList[i].contains("firstName")) {
          final usernameVariable = allParamsList[i];
          firstname = usernameVariable.split("firstName%3D").last;
        } else if (allParamsList[i].contains("lastname")) {
          final usernameVariable = allParamsList[i];
          lastName = usernameVariable.split("lastname%3D").last;
        } else if (allParamsList[i].contains("phoneNumber")) {
          final usernameVariable = allParamsList[i];
          phoneNumber = usernameVariable.split("phoneNumber%3D").last;
        } else if (allParamsList[i].contains("profilePictureLink")) {
          final usernameVariable = allParamsList[i];
          print("usernameVariable $usernameVariable");
          profilePictureLink =
              usernameVariable.split("profilePictureLink%3D").last;
          print("link $profilePictureLink");
        }
      }
//for open a specific page or product page in app
      //use get navigate for easy navigation
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewProfilePage(
                profilePictureLink: profilePictureLink,
                username: username,
                emailId: emailId,
                firstname: firstname,
                lastName: lastName,
                phoneNumber: phoneNumber,
                userId: userId)),
      );
    } else {
      for (int i = 0; i < allParamsList.length; i++) {
        if (allParamsList[i].contains("username")) {
          final usernameVariable = allParamsList[i];
          print(usernameVariable);
          String localvariable = usernameVariable.split("username=").last;
          print(localvariable);
          username = localvariable.split("&").first;
          print(username);
        }
        if (allParamsList[i].contains("userid")) {
          final usernameVariable = allParamsList[i];
          userid = usernameVariable.split("userid=").last;
        }
      }

      if (userid != null && username != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfilePage(
                      username: username,
                      userid: userid,
                    )));
      }
    }
    // Navigator.pushNamed(context, dynamicLinkData.link.path);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Links Example'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("initial link : $initialLink"),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
