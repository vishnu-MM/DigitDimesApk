import 'dart:convert';
import 'DeliveryStatus.dart';
import 'package:digitdimes/ViewMyOrders.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const ViewMyOrders());
}

class ViewMyOrders extends StatelessWidget {
  const ViewMyOrders({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyOrders',
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
      home: const MyOrdersPage(title: 'MyOrders'),
      routes: {
        "/DeliveryStatus":(BuildContext context)=> new DeliveryStatusPage(title: "DeliveryStatus"),

      },
    );
  }
}

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}
String oid='';
class _MyOrdersPageState extends State<MyOrdersPage> {
  String ips='';
  String id_a='';
  Future<List<ViewMyOrders_>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    var data = await http.post(Uri.parse("http://" + ip + ":5000/view_my_order_post"),body: {"lid":uid});
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    setState(() {
      ips=ip.toString();
    });

    print(jsonData);
    List<ViewMyOrders_> clist_ = [];
    for (var nn in jsonData["data"]) {
      ViewMyOrders_ newname_ =
      ViewMyOrders_(nn["photo"].toString(),nn["product_name"].toString(),nn["qty"].toString(),nn["price"].toString(),nn["assign_id"].toString(),nn["order_id"].toString());
      clist_.add(newname_);
    }
    return clist_;
  }

  //Update status
  delivered(String ida) async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    String pid=pref.getString("pid_s").toString();
    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://"+ip+":5000/view_my_order_post"),body: {"lid":uid});
    var jsondata = json.decode(data.body);
    print(jsondata);

    String status = jsondata['status'];
    if(status=="ok")
    {
      String lid_s=jsondata["lid"].toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("lid", lid_s);
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
          // Here we take the value from the MyOrdersPage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          child: FutureBuilder(
              future: _getNames(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // print("snapshot" + snapshot.toString());
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // padding: EdgeInsets.all(5.0),
                    // shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        // onLongPress: () {
                        //   print("long press" + index.toString());
                        // },
                          children:[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Table(
                                            children:[
                                          TableRow(
                                              children:[ Text("Product:", style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                                Text(snapshot.data[index].product_name),
                                              ]),
                                          // TableRow(padding: const EdgeInsets.all(8.0),
                                          //   child:
                                          // ),
                                        ]
                                        ),
                                        Table(
                                          children: [
                                            TableRow(children: [
                                              Text("Price :", style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(snapshot.data[index].price),
                                            ]),
                                          ],
                                        ),
                                        Table(
                                            children: [
                                              TableRow(children: [
                                                Text("Quantity :", style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                Text(snapshot.data[index].qty),
                                              ]),
                                            ]),
                                        OutlinedButton(onPressed: () async {
                                          oid=snapshot.data[index].order_id;
                                          final prefs = await SharedPreferences.getInstance();
                                          prefs.setString("oid", oid);
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                              builder: (context) => new DeliveryStatusPage(title: "DeliveryStatus"),
                                            ),
                                          );
                                        },
                                            child: Text("Status",
                                              style: TextStyle(),
                                            ))

                                      ],

                                    ),

                                  ),

                                ],
                              ),

                            ),
                          ]
                      );
                    },
                  );
                }
              }),
        ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class ViewMyOrders_ {
  late final product_name ;
  late final qty ;
  late final price ;
  late final String photo ;
  late final assign_id ;
  late final order_id ;

  ViewMyOrders_(this.photo,this.product_name,this.qty,this.price,this.assign_id,this.order_id);
}

