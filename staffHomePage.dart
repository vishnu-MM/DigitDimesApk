// import 'package:digitdimes/DigitDimesApk/StaffViewRating.dart';
import 'package:flutter/material.dart';
import 'StaffViewAssignedOrder.dart';
import 'StaffViewPreviousOrder.dart';
import 'StaffViewProfile.dart';
import 'StaffViewRating.dart';

void main() {
  runApp(const StaffHome());
}

class StaffHome extends StatelessWidget {
  const StaffHome({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
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
      home: const StaffHomePage(title: 'Home'),
      routes: {
        "/ViewAssignedOrder":(BuildContext context)=> new AssignedOrderPage(title: '',),
        "/ViewPreviousOrder":(BuildContext context)=> new PreviousOredrPage(title: '',),
        "/ViewStaffProfile":(BuildContext context)=> new StaffProfilePage(title: '',),
        "/ViewRating":(BuildContext context)=> new StaffViewRating(),


      },
    );
  }
}

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {

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
        // Here we take the value from the StaffHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Staff Home page"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Center(
              child: Text(" Digit Dimes",
                style: TextStyle(
                  fontSize: 50,
                  color:  Colors.teal.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),

              ),
            ),
              decoration: BoxDecoration(
                color: Colors.white ,
                image: DecorationImage(fit: BoxFit.fitWidth,
                    image: NetworkImage("https://p0.pikist.com/photos/467/245/shopping-keyboard-enter-button-shopping-cart-shop-online-web-www.jpg")),
              ),),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.insert_comment_outlined,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Assigned Order",
                      style: TextStyle(
                          fontSize: 18
                      ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) =>  new AssignedOrderPage(title: '',),
                ),
              );
            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.comments_disabled_outlined,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("previous Order",
                      style: TextStyle(
                          fontSize: 18
                      ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new PreviousOredrPage(title: " "),
                ),
              );            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(" My profile",
                      style: TextStyle(
                          fontSize: 18
                      ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new StaffProfilePage(title: " "),
                ),
              );            },),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Rating",
                      style: TextStyle(
                          fontSize: 18
                      ),),
                  ),
                ],
              ) , onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new StaffViewRating(),
                ),
              );            },),

          ],
        ),

      ),
    );
  }
}
