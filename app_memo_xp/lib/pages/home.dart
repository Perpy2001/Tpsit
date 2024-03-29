import 'package:app_memo_xp/floor_database/database.dart';
import 'package:app_memo_xp/widget/addMemo.dart';
import 'package:app_memo_xp/widget/costum_drower.dart';
import 'package:app_memo_xp/widget/memocard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference _colecMemo;
  AppDatabase database;

  @override
  void initState() {
    getDatabase();
    getColec();
    super.initState();
  }

  getColec() async {
    _colecMemo = FirebaseFirestore.instance.collection("Memo");
  }

  getDatabase() async {
    database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text("Memo"),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AddMemo(colec: _colecMemo, user:user);
                    });
              })
        ],
      ),
      drawer: CostumDrower(
        database: database,
      ),
      body: Container(
        child: StreamBuilder(
          stream: _colecMemo.orderBy("date").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 2))),
                child: ListView(
                  children: snapshot.data.docs.map<Widget>((doc) {
                    if(doc.data()["private"]==true&&user.email!=doc.data()["accaunt"]){
                    return Container();
                    }
                    bool me = false;
                    if (doc.data()["accaunt"] == user.email) {
                      me = true;
                    }

                    return MemoCard(
                      date: doc.data()["date"],
                      private: doc.data()["private"],
                      database: database,
                      docName: doc.id,
                      tags: doc.data()["tags"],
                      me: me,
                      titolo: doc.data()["titolo"],
                      accaunt: doc.data()["accaunt"],
                      body: doc.data()["body"],
                    );
                  }).toList(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
