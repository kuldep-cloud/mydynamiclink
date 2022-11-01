
# mydynamiclink

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [firebase: ](https://console.firebase.google.com/)
- [firebase_core: ](https://pub.dev/packages/firebase_core)
- [firebase_dynamic_link: ](https://pub.dev/packages/firebase_dynamic_links)


For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Firebase config

    Firebase Dynamic Links provides a rich feature for handling deep linking for applications and websites.
    The best part is that Firebase deep linking is free, for any scale.
    Dynamic Links instead of redirecting the user to the playstore bring-in Optimal User Experience by also navigating him to the Intended Equivalvent content in web/app apparently contributing to building ,improving and growing application for multiple platform domains.



Setup & Initial Configuration

      In order to send Firebase Dynamic Links, We need to create a firebase project for the Firebase Dynamic Links from firebase.google.com by logging in with your Google account

     1.Click on Add Project Button (+) initiating firebase project creation process.
     2.Select the appropriate name for the project entering continue further
     3.You can either select the firebase analytics and then clicking on Continue Project. Firebase Project is now created and ready to use .

This Progress indicator will show before the dashboard indicating success.

In the project overview page, click the android  icon for android app and ios icon for ios app to launch the setup workflow as we now needs to register your flutter project for the android and iOS application.


Integration with android App

    In the project overview page, select the android icon to launch the setup flow. If you have already added the app to your project provide click on add app to provide details of your application.


Register your app with Firebase :

        a. Provide with your app package name ex(com.example.app).
           Find this package name from your open project in android folder. Select the top-level app in the project navigator, then access src>main>AndroidManifest.xml. package  name  package="com.example.dynamiclinknewdemo
        b. You may also provide optional details like App Nick Name and Sha key.
        c. Register your app.


Make sure you enter the package name As this can’t be edited further at the moment .


Next step, We need to download the config file named Google-service.json file  & repeating a similar process to registering your ios app there saving the GoogleService-info.plist file. Keep those configuration files in ready-to-use with Flutter app later.

After that copy that downloaded folder to your:

      Your app name > android > app

After successfully adding google-services.json file to your app folder, you need to add Firebase SDK to the build.gradle folder.

Now we have successfully initial configuration and adding Firebase to our existing project. Then we will move on to the next step.

Setting up Firebase

       1. On the right side of the Firebase console, select “Dynamic Links” after redirecting to your firebase flutter dynamic link project. Then click “Get started”.
       2. Selecting a domain under the given modal “Add URL prefix”(mydynamiclink.page.link). Here they will provide automatically some domains. If you need to customize it you can enter the domain you preferred. Then click “Continue” button.

Create a dynamic link inside the Firebase Console

      1. Click “New Dynamic Link”. 
      2. Set up a short URL link and click “Next”.
      3. Then you need to set up your dynamic link URL, under “Set up your Dynamic Link”. There is a deep link to your application and if a specific user has not installed the app where that user should redirect. As an example, you can provide app play store link as the dynamic link. Link name can be given as any meaningful short name about your dynamic link that you prefer. Click “Next”.
      4. Choose “Open the deep link URL in a browser” option. In that option, if the specific app is not installed in your app the link will open through the browser. If not you can choose “Open the deep link in your iOS App” but if so you need to have an iOS app. Then click “Next”.
      5. Here we define behavior for Android. Select “Open the deep link in your Android App” and choose your android app. Then click “Next”.
      6. Additionally, you can customize some advanced options. Then click “Create”.
      7. Under the URL, you will get your created dynamic link.

Integration with iOS App

    In the project overview page, select the iOS icon to launch the setup flow. If you have already added the app to your project provide click on add app to provide details of your application.

Register your app with Firebase :

    a. Provide with your app’s bundle ID.
    Find this bundle ID from your open project in XCode. Select the top-level app in the project navigator, then access the General tab. The Bundle Identifier value is the iOS bundle ID (for example, com.yourcompany.ios-app-name).
    b. You may also provide optional details like App Nick Name and App Store ID.
    c. Register your app.

Make sure you enter the correct ID As this can’t be edited further at the moment .

        Next step, We need to download the config file named GoogleService-info.plist & repeating a similar process to registering your android app there saving the Google-service.json file. Keep those configuration files in ready-to-use with Flutter app later.

Open Project Settings in the Firebase console and select iOS application.

     Now We need to add the App Store Id of the flutter application which can be located at the app’s URL.
     We can also use makeshift app ID if our app is not published yet which can be replaced later.
     We may need to add the Team ID which can be located at the Apple Member Centre under the provisioning profile.

Open XCode Following the Steps :

        Signing & Capabilities: Turn On the associated domain by adding it to the list which looks like this firebasedynamiclicks.page.link .{URL Schema Created in the firebase console }.

Note: Make sure that your provisioning profile supports the associated domain’s capability.

       Add the Identifier field as Bundle ID and URL Schema as your bundle ID which will look like com.flutterdevs.test.


Note:- Starting with Flutter 2.8, there is a new way to initialize a Firebase project within Flutter to bypass this steps.

        1.Create project in Firebase console, but you don't need to download the files mentioned or change build.gradle files
        2.Install Firebase CLI here(https://firebase.google.com/docs/cli)
        3.run dart pub global activate flutterfire_cli in your Flutter project
        4.run flutterfire configure

Android Config

Deep link

Deep Links: This link doesn’t require a host, a hoster file, or any custom scheme.
It provides a way to utilize your app using URL: your_scheme://any_host. Here’s the Deep Link intent filter that you need to add to your AndroidManifest.xml.
You can also change the scheme and host:

<!-- Deep Links --> 

           <!-- Deep linking -->
            <meta-data android:name="flutter_deeplinking_enabled" android:value="true" />
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="http" android:host="dynamiclinknewdemo.page.link" />
                <data android:scheme="https" />
            </intent-filter>


IOS CONFIG

custom url schemas

Custom URL: This URL doesn’t require a host, entitlements, a hosted file, or any custom scheme.
Similar to a Deep Link in Android, you need to add the host and scheme in the ios/Runner/Info.plist file as below:

    <key>CFBundleURLTypes</key>
     <array>
      <dict>
          <key>CFBundleTypeRole</key>
          <string>Editor</string>
          <key>CFBundleURLName</key>
          <string>dynamiclinknewdemo.page.link</string>
          <key>CFBundleURLSchemes</key>
          <array>
              <string>https</string>
          </array>
      </dict>
     </array>

important:- Method for getting url

        Future<void> initDynamicLinks() async {
              //it is use when app is not in foreground or background
        PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

                // write your logic
           //it is used when app is on foreground and background
         dynamicLinks.onLink.listen((dynamicLinkData) {

                //write your logic

          }).onError((error) {

                 print(error.message);
           });
         }

     
get url data in app with help of queryparameter

               final Uri? uri = initialLink?.link;
               final queryParams = uri?.queryParameters;
               username: queryParams?["username"];
               userid: queryParams?["userid"];



get url data in app without help of queryparameter

split uri for getting data from uri

        final allParamsList = uri.toString().split("?");


logic for getting the particular key data from split variable

        final userName,userId;
       //run a loop till array length
        for (int i = 0; i < allParamsList.length; i++) {
          //check the condition of key
          if (allParamsList[i].contains("username")) {
             //set value of index in a variable
            final usernameVariable = allParamsList[i];
             //split again to get value of key
            userName = usernameVariable.split("username=").last;
          } else if (allParamsList[i].contains("userID")) {
            final usernameVariable = allParamsList[i];
            userID = usernameVariable.split("userID%3D").last;
          }
        }

How to navigate to a particular screen in ui?

    if(uri.toString().contains("profileDetails")){
      //get key vale code here
      //navigation code here of specific screen with arguments
      }

