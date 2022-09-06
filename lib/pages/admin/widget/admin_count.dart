import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/widget/admin_list.dart';
import 'package:flutter/material.dart';

class AdminCount extends StatelessWidget {
  const AdminCount({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const AdminList();
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            //begin of the gradient color
            begin: Alignment.topLeft,
            //end of the gradient color
            end: Alignment.bottomRight,
            stops: [
              0,
              0.5,
            ],
          ),
        ),
        child: SizedBox(
          width: size.width / 2.8,
          height: size.height / 4,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where('role', isEqualTo: 'admin')
                          .snapshots(),
                      builder: (context, snapshot1) {
                        if (snapshot1.hasError) {
                          return const Text("something went wrong");
                        } else if (snapshot1.hasData) {
                          return Text(
                            snapshot1.data!.docs.length.toString(),
                            style: const TextStyle(
                                fontSize: 38, color: Colors.white),
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return const AdminList();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Registered Admin",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
