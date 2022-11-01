import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mydynamiclink/new_profile_page.dart';
import 'package:mydynamiclink/profile_page.dart';

Future<void> main() async {
  //calling init method for firebase initialization
  await init();
  runApp(const MyApp());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initialization
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

 //decalare pendingdynamic variable for getting the url when app is not in foreground and background
  PendingDynamicLinkData? initialLink;
  String? username, userid;

  //declare dynamiclink variable for getting url for when app is on foreground and background
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
    //calling initdynamiclink method for checking initial or dynamic url
    initDynamicLinks();
  }

  Future<void> initDynamicLinks() async {
    //get the initial url
    initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    //method for get data with help of query parameter
   // getDataFromQueryparams(initialLink);

    //method for get key value from custom login
     getDataFromLink(initialLink);

     //make dynamiclinks listenable for checking url changes
    dynamicLinks.onLink.listen((dynamicLinkData) {
    // getDataFromQueryparams(dynamicLinkData);
        getDataFromLink(dynamicLinkData);
    }).onError((error) {
      //catching errors here if dynamiclinks listner unable to listen url
      print(error.message);
    });
  }


  //method for getting key value pair with the help of query parameters
  void getDataFromQueryparams(final initialLink){
    //convert initial link to uri
    final Uri? uri = initialLink?.link;
    //getting queryparams from uri
    final queryParams = uri?.queryParameters;
    //logic for seperation of data
    if (uri.toString().contains("profileDetails")) {

      //Redirect to specific page with argument
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
      //when if condition is not satisfied it will hit here
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProfilePage(
                username: queryParams?["username"],
                userid: queryParams?["userid"],
              )));
    }
  }


  //second method for getting key value pair from link
  void getDataFromLink(final dynamicLinkData) {
    final Uri? uri = dynamicLinkData?.link;

    //divied the uri behalf of ? for get data from uri
    final allParamsList = uri.toString().split("?");
    //logic for getting the particular key data

    //checking condition
    if (dynamicLinkData.toString().contains("profileDetails")) {
      String profilePictureLink = "";
      String username = "";
      String emailId = "";
      String firstname = "";
      String lastName = "";
      String phoneNumber = "";
      String userId = "";

     //loop for getting specific key value from splited uri
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

       //for open a specific page  in app
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

      //else condition loop
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
