import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/admin_root.dart';
import 'package:covid_19/pages/admin/registered_user_update.dart';
import 'package:covid_19/pages/admin/widget/register_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisteredUserList extends StatefulWidget {
  const RegisteredUserList({Key? key}) : super(key: key);

  @override
  State<RegisteredUserList> createState() => _RegisteredUserListState();
}

class _RegisteredUserListState extends State<RegisteredUserList> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Registered List"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("registeredIndividual")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.hasData) {
              return Column(children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      List<QueryDocumentSnapshot<Object?>> data =
                          snapshot.data!.docs;
                      return GestureDetector(
                        onLongPress: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return RegisteredUserUpdate(
                                email: data[index]['email']);
                          }));
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            handleDelete(data[index]['id']);
                            setState(() {
                              snapshot.data?.docs.removeAt(index);
                            });
                          },
                          child: ListTile(
                            title: Text(data[index]['email']),
                            // subtitle: Text(data[index]['role']),
                          ),
                        ),
                      );
                    })
              ]);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  handleDelete(String id) {
    setState(() {
      isLoading = true;
    });
    DocumentReference registerUser =
        FirebaseFirestore.instance.collection("registeredIndividual").doc(id);
    registerUser.delete().whenComplete(() {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "User Deleted Successfully");
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const RegisteredUserList();
      }));
    });
  }
}
