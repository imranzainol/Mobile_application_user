import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String fullName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                fullName = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (fullName != "" && fullName != null)
            ? FirebaseFirestore.instance
            .collection('Users')
            .where("searchKeywords", arrayContains: fullName)
            .snapshots()
            : FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.docs[index];
              return Card(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      data.data()['fullName'],
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

}