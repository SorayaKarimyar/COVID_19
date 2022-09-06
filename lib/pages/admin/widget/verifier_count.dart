import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/widget/verifier_list.dart';
import 'package:flutter/material.dart';

class VerifierCount extends StatelessWidget {
  const VerifierCount({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const VerifierList();
        }));
      },
      child: Container(
        width: double.infinity,
        height: size.height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Colors.red, Colors.redAccent],
              begin: Alignment.topLeft, //begin of the gradient color
              end: Alignment.bottomRight, //end of the gradient color
              stops: [
                0,
                0.5,
              ]),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .where('role', isEqualTo: 'verifier')
                        .snapshots(),
                    builder: (context, snapshot2) {
                      if (snapshot2.hasError) {
                        return Text("something went wrong");
                      }
                      if (snapshot2.hasData) {
                        return Text(
                          snapshot2.data!.docs.length.toString(),
                          style: TextStyle(fontSize: 38, color: Colors.white),
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
                          return const VerifierList();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Registered Verifiers",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
