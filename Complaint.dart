import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const Complaint());
}

class Complaint extends StatelessWidget {
  const Complaint({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint',
      theme: ThemeData(

        primarySwatch: Colors.teal,
      ),
      home: const ComplaintPage(title: 'Complaint'),
    );
  }
}

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key, required this.title});



  final String title;

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  TextEditingController Complaint = TextEditingController();

complaint(String C) async {
  final pref=await SharedPreferences.getInstance();
  String ip= pref.getString("ip").toString();
  String uid=pref.getString("lid").toString();
  String pid=pref.getString("pid_s").toString();
  print("-----ip");
  print(ip);
  var data = await http.post(Uri.parse("http://"+ip+":5000/and_sent_complaints"),body: {"complaint":C,"user":uid,"pid":pid});
  var jsondata = json.decode(data.body);
  print(jsondata);

  String status = jsondata['status'];
  if(status=="ok")
    {
      String lid_s=jsondata["lid"].toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("lid", lid_s);
      setState(() {
        Complaint.text='';
      });
    }
}


// View Complaint
//   String ips='';
//   Future<List<ViewComplaint>> _getNames() async {
//     final pref = await SharedPreferences.getInstance();
//     String ip = pref.getString("ip").toString();
//     String pid=pref.getString("pid_s").toString();
//     var data = await http.post(Uri.parse("http://" + ip + ":5000/and_view_complaint"),body: {"pid":pid});
//     print("------------------------------hoiiiiiii---------------");
//     print(data);
//     var jsonData = json.decode(data.body);
//     setState(() {
//       ips=ip.toString();
//     });
//
//     print(jsonData);
//     List<ViewComplaint> clist = [];
//     for (var nn in jsonData["data"]) {
//       ViewComplaint newname =
//       ViewComplaint(nn["naame"].toString(),nn["complaint"].toString(),nn["date"].toString());
//       clist.add(newname);
//     }
//     return clist;
//   }
//

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the ComplaintPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              Icons.comments_disabled_outlined,
              size: 120,
              color: Colors.grey,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: TextField( controller: Complaint, decoration: InputDecoration( hintText: 'Complaints'),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                    String Complaint_v=Complaint.text;
                    complaint(Complaint_v);
                  }, child: Text("Sent")),
                )
              ],
            ),
          ),


        ],
      ),
    );
    // This trailing comma makes auto-formatting nicer for build method
  }
}

class ViewComplaint {
  late final naame ;
  late final complaint ;
  late final date ;
  ViewComplaint(this.naame,this.complaint,this.date);
}
