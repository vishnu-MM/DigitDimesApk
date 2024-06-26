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
      ViewAssignedOrder(nn["naame"].toString(),nn["phone"].toString(),nn["place"].toString(),nn["post"].toString(),nn["pin"].toString(),nn["photo"].toString(),nn["product_name"].toString(),nn["qty"].toString(),nn["price"].toString(),nn["assign_id"].toString(),nn["status"].toString());
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
                                      ListTile(
                                        leading: Icon(Icons.arrow_drop_down_circle),
                                        title: Text(snapshot.data[index].product_name,),
                                        subtitle: Text(
                                            "Quantity: "+snapshot.data[index].qty+" Price: "+snapshot.data[index].price,
                                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text("Delivery Address: \n"
                                            +"\n Recipient  :"+snapshot.data[index].naame
                                            +"\n Phone        :"+snapshot.data[index].phone
                                            +"\n Place         :"+snapshot.data[index].place
                                            +"\n Post           :"+snapshot.data[index].post
                                            +"\n PIN             :"+snapshot.data[index].pin,
                                          style: TextStyle(color: Colors.blue.withOpacity(0.6)),
                                        ),
                                      ),

                                      Image.network("http://"+ips+":5000/"+snapshot.data[index].photo),
                                      ButtonBar(
                                        alignment: MainAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async{
                                              final pref = await SharedPreferences.getInstance();
                                              String ip = pref.getString("ip").toString();
                                              String uid=pref.getString("lid").toString();
                                              String asid=snapshot.data[index].assign_id;
                                              var data = await http.post(Uri.parse("http://" + ip + ":5000/update_assigned_order_post"),body: {"asid":asid});
                                              Navigator.push(context, new MaterialPageRoute(builder: (context)=>StaffAssigendOrder()));
                                            },
                                            child: const Text('Mark as Delivered'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
  late final photo ;
  late final product_name ;
  late final status ;
  late final qty ;
  late final price ;
  late final assign_id ;

  ViewAssignedOrder(this.naame,this.phone,this.place,this.post,this.pin,this.photo,this.product_name,this.qty,this.price,this.assign_id,this.status);
}

