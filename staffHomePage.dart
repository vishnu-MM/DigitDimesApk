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
        "/ViewAssignedOrder":(BuildContext context)=>AssignedOrderPage(title: '',),
        "/ViewPreviousOrder":(BuildContext context)=>PreviousOredrPage(title: '',),
        "/ViewStaffProfile":(BuildContext context)=>StaffProfilePage(title: '',),
        "/ViewRating":(BuildContext context)=>StaffRatingPage(title: '',),


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
            DrawerHeader(child: Text(" Digit Dimes" , style:TextStyle(fontSize: 35),  ), decoration: BoxDecoration( color: Colors.blueGrey,),),
            ListTile(
              title: Text("Assigned Order") , onTap: (){
              Navigator.pushNamed(context, "/ViewAssignedOrder");
            },),
            ListTile(
              title: Text("previous Order") , onTap: (){
              Navigator.pushNamed(context, "/ViewPreviousOrder");
            },),
            ListTile(
              title: Text("profile") , onTap: (){
              Navigator.pushNamed(context, "/ViewStaffProfile");
            },),
            ListTile(
              title: Text("Rating") , onTap: (){
              Navigator.pushNamed(context, "/ViewRating");
            },),

          ],
        ),

      ),
    );
  }
}
