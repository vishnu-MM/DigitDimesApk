import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:digitdimes/StaffViewRating.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const DeliveryStatus());
}

class DeliveryStatus extends StatelessWidget {
  const DeliveryStatus({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliveryStatus',
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
      home: const DeliveryStatusPage(title: 'DeliveryStatus'),
    );
  }
}

class DeliveryStatusPage extends StatefulWidget {
  const DeliveryStatusPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<DeliveryStatusPage> createState() => _DeliveryStatusPageState();
}

class _DeliveryStatusPageState extends State<DeliveryStatusPage> {
  String ips='';
  String id_a='';
  Future<List<ViewPreviousOrder>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    String oid=pref.getString("oid").toString();
    var data = await http.post(Uri.parse("http://" + ip + ":5000/and_Delivary_status"),body: {"oid":oid});
    var jsonData = json.decode(data.body);
    setState(() {
      ips=ip.toString();
    });


    List<ViewPreviousOrder> clist = [];
    for (var nn in jsonData["data"]) {
      ViewPreviousOrder newname =
      ViewPreviousOrder(nn["phone"].toString(),nn["status"].toString(),nn["photo"].toString(),nn["product_name"].toString(),nn["price"].toString(),nn["sname"].toString(),nn["email"].toString(),nn["assign_id"].toString());
      clist.add(newname);
    }
    return clist;
  }

  TextEditingController Review = TextEditingController();

  review(String Rv, R,S)
  async {
    final pref=await SharedPreferences.getInstance();
    String ip= pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    String pid=pref.getString("pid_s").toString();
    var data = await http.post(Uri.parse("http://"+ip+":5000/and_Delivary_rating"),body: { "assignid":R,"review":Rv,"rating":S });
    var jsondata = json.decode(data.body);
    String status = jsondata['status'];
    setState(() {
      Review.text='';
    });
  }
  String asid='';
  String Review_v='';
  double? _rating;
  IconData? _selectedIcon;

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
        // Here we take the value from the DeliveryStatusPage object that was created by
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
                                      title: Text(snapshot.data[index].status,
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                      subtitle: Text(
                                        "Product: "+snapshot.data[index].product_name+" Price: "+snapshot.data[index].price,
                                        style: TextStyle(color: Colors.black.withOpacity(0.6), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Text("Delivery Staff Details"),
                                          Text(
                                              "\n Staff    : "+snapshot.data[index].sname
                                              +"\n Phone  : "+snapshot.data[index].phone
                                              +"\n Email   : "+snapshot.data[index].email,
                                            style: TextStyle(color: Colors.blue.withOpacity(0.6)),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Image.network("http://"+ips+":5000/"+snapshot.data[index].photo),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text("Share Delivary rating",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.amber
                                        ),
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: _rating ?? 0.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 50,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                                        itemBuilder: (context, _) => Icon(
                                          _selectedIcon ?? Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {

                                          setState(() {
                                            _rating = rating;
                                          });
                                        },
                                      ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        child: TextField( controller: Review, decoration: InputDecoration( hintText: 'Review'),),
                                      ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(onPressed: (){
                                        if(snapshot.data[index].status == 'delivered')
                                        {
                                          Review_v=Review.text;
                                          asid=snapshot.data[index].assign_id.toString();
                                          review(Review_v,asid,_rating.toString());
                                        }
                                      }, child: Text("Share")),
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
class ViewPreviousOrder {

  late final sname ;
  late final phone ;
  late final email ;
  late final product_name ;
  late final price ;
  late final String photo ;
  late final qty ;
  late final status ;
  late final assign_id ;


  ViewPreviousOrder(this.phone,this.status,this.photo,this.product_name,this.price,this.sname,this.email,this.assign_id);
}

