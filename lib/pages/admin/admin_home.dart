import 'package:covid_19/pages/admin/widget/admin_count.dart';
import 'package:covid_19/pages/admin/widget/registrar_count.dart';
import 'package:covid_19/pages/admin/widget/verifier_count.dart';
import 'package:covid_19/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const LoginScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.logout_rounded)),
      ),
      // appBar: AppBar(
      //     title: const Text(
      //       "Admin Dashboard",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.redAccent),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Image.asset("images/logo.png"),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) {
                      //       return const AddNewPost();
                      //     },
                      //   ),
                      // );
                    },
                    child: RegistrarCount(size: size),
                  ),
                  AdminCount(size: size),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (_) {
                        //   return const AddYoutubeVideo();
                        // }));
                      },
                      child: VerifierCount(size: size),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logoutUser() async {
    await FirebaseAuth.instance
        .signOut()
        .then(
          (e) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) {
                return const LoginScreen();
              },
            ),
          ),
        )
        .catchError((e) {
      Fluttertoast.showToast(msg: e.message);
    });
  }
}
