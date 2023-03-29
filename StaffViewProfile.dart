import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'StaffEditProfile.dart';


void main() {
  runApp(const StaffProfile());
}

class StaffProfile extends StatelessWidget {
  const StaffProfile({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StaffProfile',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const StaffProfilePage(title: 'StaffProfile'),
      routes: {
        "/EditProfile":(BuildContext context)=> new EditProfilePage(title: '',),

      },
    );
  }
}

class StaffProfilePage extends StatefulWidget {
  const StaffProfilePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StaffProfilePage> createState() => _StaffProfilePageState();
}

class _StaffProfilePageState extends State<StaffProfilePage> {

  _StaffProfilePageState(){
    viewProfile();
  }

  String Name='';
  String Age='';
  String Gender='';
  String Place='';
  String Post='';
  String Pin='';
  String Email='';
  String Phone='';
  String City='';


  viewProfile() async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://"+ip+":5000/staff_View_Profile_post"),body: { "lid":uid });
    var jsondata = json.decode(data.body);
    print(jsondata);

    String status = jsondata['status'];
    if(status=="ok")
    {
      setState(() {
        Name=jsondata["Name"].toString();
        Age=jsondata["Age"].toString();
        Gender=jsondata["Gender"].toString();
        Place=jsondata["Place"].toString();
        Post=jsondata["Post"].toString();
        Pin=jsondata["Pin"].toString();
        Email=jsondata["Email"].toString();
        Phone=jsondata["Phone"].toString();
        City=jsondata["City"].toString();
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been
    // optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the StaffProfilePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("My Profile"),
        ),
        body:ListView(
          children: [
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 90,
                    child: Text("Name :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Name),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 90,
                    child: Text("Age :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Age),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: Text("Gender :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Gender),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: Text("Place :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Place),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: Text("Post :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Post),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: Text("Pin :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Pin),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: Text("Email :")),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(Email),
                )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: Text("Phone :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Phone),
              )],),
            ),
            ListTile(
              title: Row(children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: Text("City :")),
              ), Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(City),
              )],),
            ),
            ListTile(
              title: Center(
                child: ElevatedButton(onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new EditProfilePage(title: '',),)
                  );
                }, child: Text("Edit"),),
              ),
            )
          ],
        )

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
