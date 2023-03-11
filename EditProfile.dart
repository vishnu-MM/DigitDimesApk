import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Profile.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const EditProfile());
}

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Profile',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: const EditProfilePage(title: 'Edit Profile'),
      routes: {
        "/Profile":(BuildContext context)=> new ProfilePage(title: "Profile"),
        "/IpPage":(BuildContext context)=> new MyHomePage(title: "IpPage"),
      },
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.title});

  final String title;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  _EditProfilePageState(){
    viewProfile();

  }


  TextEditingController name = TextEditingController();
  var Gender ;
  TextEditingController Age = TextEditingController();
  TextEditingController Place = TextEditingController();
  TextEditingController Post = TextEditingController();
  TextEditingController Pin = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Phone = TextEditingController();




  Future<void> EditProfile(String name_v,String Gender_v,String Age_v,String Place_v,String Post_v,String Pin_v,String Email_v,String Phone_v)
  async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    // String uid=pref.getString("lid").toString();
    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://"+ip+":5000/and_EditProfile_post"),body: {
      "lid":uid ,"name":name_v,"age":Age_v,"gender":Gender_v,"place":Place_v,"post":Post_v,"pin":Pin_v,"phone":Phone_v,"email":Email_v });
    var jsondata = json.decode(data.body);
    print(jsondata);

    String status = jsondata['status'];
    if(status=="ok")
    {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new ProfilePage(title: "Profile"),
        ),
      );
    }
  }


  String? gender;

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
          // Here we take the value from the EditProfilePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30,15 ),
              child: Column(children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'Name'),
                    controller: name,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'Age'),
                    controller: Age,),
                ),


                RadioListTile(
                  title: Text("Male"),
                  value: "male",
                  groupValue: gender,
                  onChanged: (value){
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),

                RadioListTile(
                  title: Text("Female"),
                  value: "female",
                  groupValue: gender,
                  onChanged: (value){
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'Place'),
                    controller: Place,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'post'),
                    controller: Post,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'Pin'),
                    controller: Pin,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'Email'),
                    controller: Email,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(decoration: InputDecoration(hintText: 'Phone'),
                    controller: Phone,),
                ),

                Padding(padding: EdgeInsets.all(10),
                  child: ElevatedButton(onPressed: (){


                      String name_v=name.text;
                      String Gender_v=gender!;
                      String Age_v=Age.text;
                      String Place_v=Place.text;
                      String Post_v=Post.text;
                      String Pin_v=Pin.text;
                      String Email_v=Email.text;
                      String Phone_v=Phone.text;
                      EditProfile(name_v,Gender_v,Age_v,Place_v,Post_v,Pin_v,Email_v,Phone_v);
                      Navigator.pushNamed(context, "/Profile" );

                  }, child: Text("Done"),),
                ),

              ],),
            )
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  viewProfile()
  async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://"+ip+":5000/and_View_Profile_post"),body: { "lid":uid });
    var jsondata = json.decode(data.body);
    print(jsondata);

    String status = jsondata['status'];
    if(status=="ok")
    {

      setState(() {
        name.text=jsondata["Name"].toString();
        Age.text=jsondata["Age"].toString();
        gender!=jsondata["Gender"].toString();
        Place.text=jsondata["Place"].toString();
        Post.text=jsondata["Post"].toString();
        Pin.text=jsondata["Pin"].toString();
        Email.text=jsondata["Email"].toString();
        Phone.text=jsondata["Phone"].toString();
      });


    }
    else{
      print("tost");
      // Fluttertoast.showToast(
      //     msg: "Status is not ok",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0,
      // );
    }
  }








}
