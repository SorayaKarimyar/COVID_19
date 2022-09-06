import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/admin_root.dart';
import 'package:covid_19/pages/admin/widget/register_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrarList extends StatefulWidget {
  const RegistrarList({Key? key}) : super(key: key);

  @override
  State<RegistrarList> createState() => _RegistrarListState();
}

class _RegistrarListState extends State<RegistrarList> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Registrar List"),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return AdminRoot(
                      navigateIndex: 0,
                    );
                  }));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                  child: SvgPicture.asset(
                    "images/svgs/home.svg",
                    width: 25,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: SvgPicture.asset(
                  "images/svgs/blank.svg",
                  width: 30,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return AdminRoot(
                      navigateIndex: 2,
                    );
                  }));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                  child: SvgPicture.asset(
                    "images/svgs/account.svg",
                    width: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where('role', isEqualTo: 'registrar')
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
                            return RegisterUpdate(
                              email: data[index]['email'],
                              type:'registrar'
                            );
                          }));
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            handleDelete(data[index]['email']);
                            setState(() {
                              snapshot.data?.docs.removeAt(index);
                            });
                          },
                          child: ListTile(
                            title: Text(data[index]['email']),
                            subtitle: Text(data[index]['role']),
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

  handleDelete(String email) {
    setState(() {
      isLoading = true;
    });
    DocumentReference registerUser =
        FirebaseFirestore.instance.collection("users").doc(email);
    registerUser.delete().whenComplete(() {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "User Deleted Successfully");
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const RegistrarList();
      }));
    });
  }
}
