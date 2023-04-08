import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const StaffAssigendOrder());
}

class StaffAssigendOrder extends StatelessWidget {
  const StaffAssigendOrder({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AssignedOrder',
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
      home: const AssignedOrderPage(title: 'AssignedOrder'),
    );
  }
}

class AssignedOrderPage extends StatefulWidget {
  const AssignedOrderPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AssignedOrderPage> createState() => _AssignedOrderPageState();
}

class _AssignedOrderPageState extends State<AssignedOrderPage> {
  String ips='';
  String id_a='';
  Future<List<ViewAssignedOrder>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    var data = await http.post(Uri.parse("http://" + ip + ":5000/View_assigned_order"),body: {"lid":uid});
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    setState(() {
      ips=ip.toString();
    });

    print(jsonData);
    List<ViewAssignedOrder> clist = [];
    for (var nn in jsonData["data"]) {
      ViewAssignedOrder newname =
      ViewAssignedOrder(nn["naame"].toString(),nn["phone"].toString(),nn["place"].toString(),nn["post"].toString(),nn["pin"].toString(),nn["product_name"].toString(),nn["qty"].toString(),nn["price"].toString(),nn["assign_id"].toString());
      clist.add(newname);
    }
    return clist;
  }

  //Update status
  delivered(String ida) async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    String pid=pref.getString("pid_s").toString();
    print("-----ip");
    print(ip);
    var data = await http.post(Uri.parse("http://"+ip+":5000/update_assigned_order_post"),body: {"id":ida});
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
          // Here we take the value from the AssignedOrderPage object that was created by
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
                      return ListTile(
                          onLongPress: () {
                            print("long press" + index.toString());
                          },
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 190,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("User Details",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.green,
                                                      )),
                                                ),

                                                Text(snapshot.data[index].naame,
                                                    style: TextStyle(
                                                      fontSize: 25,
                                                    )),
                                                Text(snapshot.data[index].phone,
                                                    style: TextStyle(
                                                        fontSize: 25
                                                    )),
                                                Text(snapshot.data[index].place,
                                                    style: TextStyle(
                                                        fontSize: 25
                                                    )),
                                                Text(snapshot.data[index].post,
                                                    style: TextStyle(
                                                        fontSize: 25
                                                    )),
                                                Text(snapshot.data[index].pin,
                                                    style: TextStyle(
                                                        fontSize: 25
                                                    )),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 190,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Product Details",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.green
                                                      )),
                                                ),
                                                Text(snapshot.data[index].product_name,
                                                    style: TextStyle(
                                                        fontSize: 25
                                                    )),
                                                Text(snapshot.data[index].qty,
                                                    style: TextStyle(
                                                        fontSize: 25
                                                    )),
                                                Text(snapshot.data[index].price,
                                                    style: TextStyle(
                                                        fontSize: 25
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          width: 500,
                                          child: OutlinedButton(onPressed: (){
                                            id_a=snapshot.data[index].assign_id;
                                            delivered(id_a);
                                          }, child: Text("Delivered",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.blue
                                            ),
                                          )
                                          )
                                      )

                                    ],

                                  ),
                                )
                              ],
                            ),

                          )
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
class ViewAssignedOrder {
  late final naame ;
  late final phone ;
  late final place ;
  late final post ;
  late final pin ;
  late final product_name ;
  late final qty ;
  late final price ;
  late final assign_id ;

  ViewAssignedOrder(this.naame,this.phone,this.place,this.post,this.pin,this.product_name,this.qty,this.price,this.assign_id);
}

