import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Purchase extends StatelessWidget {
  const Purchase({super.key});

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
        primarySwatch: Colors.teal,
      ),
      home: const PurchasePage(title: 'Home'),
      routes: {

      },
    );
  }
}

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {


  _PurchasePageState(){
    viewSingleProduct();
  }


  String Name='';
  String Price='';
  String description='';
  String photo='';
  String ips='';
  String pids='';
  Int? rat;




  viewSingleProduct() async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String pid= pref.getString("pid_1").toString();

    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://" + ip + ":5000/and_View_SingleProduct_post"),body: { "pid":pid });
    var jsondata = json.decode(data.body);
    print(jsondata);

    String status = jsondata['status'];
    if(status=="ok")
    {
      setState(() {
        Name=jsondata["Name"].toString();
        Price=jsondata["Price"].toString();
        description=jsondata["description"].toString();
        photo=jsondata["photo"].toString();
        ips=ip.toString();
      });
    }
  }

  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                Name,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.network(
                "http://"+ ips +":5000/"+photo,
                height: 300.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Price: '+Price,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Description: \n'+description,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Quantity',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text(
                    _quantity.toString(),
                    style: TextStyle(fontSize: 20.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Buy Now'),
          ),
        ),
      ),
    );
  }
}






