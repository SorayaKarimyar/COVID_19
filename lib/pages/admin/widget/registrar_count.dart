import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/widget/registrar_list.dart';
import 'package:flutter/material.dart';

class RegistrarCount extends StatelessWidget {
  const RegistrarCount({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const RegistrarList();
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Colors.pink, Colors.pinkAccent],
              begin: Alignment.topLeft, //begin of the gradient color
              end: Alignment.bottomRight, //end of the gradient color
              stops: [
                0,
                0.5,
              ]),
        ),
        child: SizedBox(
          width: size.width / 1.7,
          height: size.height / 4,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where('role', isEqualTo: 'registrar')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("something went wrong");
                        }
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.docs.length.toString(),
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
                            return const RegistrarList();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Registered Registrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
