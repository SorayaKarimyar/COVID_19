import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/admin_home.dart';
import 'package:covid_19/pages/admin/admin_root.dart';
import 'package:covid_19/pages/certificate.dart';
import 'package:covid_19/pages/check_identity.dart';
import 'package:covid_19/pages/second_dose.dart';
import 'package:covid_19/pages/verifier/verifier_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreen> {
  bool isChecking = false;
  bool obscure = true;
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Image.asset("images/logo.png"),
                ),
                FormBuilderTextField(
                    name: 'email',
                    autofocus: false,
                    // controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.email(context)
                    ]),
                    onSaved: (value) {
                      // emailController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                FormBuilderTextField(
                    name: 'password',
                    autofocus: false,
                    // controller: passwordController,
                    obscureText: obscure,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.minLength(context, 6)
                    ]),
                    onSaved: (value) {
                      // passwordController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: obscure
                              ? Icon(Icons.remove_red_eye_sharp)
                              : Icon(Icons.visibility_off_outlined)),
                      prefixIcon: const Icon(Icons.vpn_key),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                isChecking
                    ? const CircularProgressIndicator()
                    : Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.redAccent,
                        child: MaterialButton(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            handleLogin();
                          },
                          child: const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Dont have an account ? "),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Text(
                //         "Register Now",
                //         style: TextStyle(color: Colors.redAccent),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

// this function login user depending on their role

// first is gets the user details and check the 'role', and the password and email matches, it logs the user in
  handleLogin() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isChecking = true;
      });
      final formData = _formKey.currentState!.value;
      DocumentReference userLogin =
          FirebaseFirestore.instance.collection("users").doc(formData['email']);

      userLogin.get().then((value) {
        if (value['role'] == 'verifier' &&
            value['password'] == formData['password']) {
          setState(() {
            isChecking = false;
          });
          // print('verifier');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                // return const CheckIdentity();
                return const VerifierRoot();
              },
            ),
          );
        }
// if role is verifier and password do not match with user input, it throws an errow
        if (value['role'] == 'verifier' &&
            value['password'] != formData['password']) {
          setState(() {
            isChecking = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 10),
            content: const Text("Password not correct "),
            action: SnackBarAction(label: "Retry Again", onPressed: () {}),
          ));
        }
        // if role is verifier and password matches, its logs user in to verifier panel
        if (value['role'] == 'registrar' &&
            value['password'] == formData['password']) {
          setState(() {
            isChecking = false;
          });
          // print('verifier');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                // return const CheckIdentity();
                return const CheckIdentity();
              },
            ),
          );
        }
        if (value['role'] == 'registrar' &&
            value['password'] != formData['password']) {
          setState(() {
            isChecking = false;
          });
          print('password not correct');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 10),
            content: const Text("Password not correct "),
            action: SnackBarAction(label: "Retry Again", onPressed: () {}),
          ));
        }
        
        // if role is admin and password matches with user input,it logs user in to admin panel
        if (value['role'] == 'admin' &&
            value['password'] == formData['password']) {
          setState(() {
            isChecking = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AdminRoot(
              navigateIndex: 0,
            );
          }));
        }
         
         // if role is admin and password do not match with user, it throws an error that password not correct
        if (value['role'] == 'admin' &&
            value['password'] != formData['password']) {
          setState(() {
            isChecking = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 10),
            content: const Text("Password not correct "),
            action: SnackBarAction(label: "Retry Again", onPressed: () {}),
          ));
          print('password not correct');
        }
      }).catchError((e) {
        // print(e.message);
        setState(() {
          isChecking = false;
        });

        // if user not found in the users table in the database, if checks in the registeredIndividual table in the database

        FirebaseFirestore.instance
            .collection("registeredIndividual")
            .where('email', isEqualTo: formData['email'])
            .get()
            .then((value) {

              // if user is found in the registeredIndividual table, it gets the details and check the status
          var userData = value.docs[0];
          // if password and email is corresponding to the one in the registeredIndividual table in the table, it perform the function below
          if (userData['email'] == formData['email'] &&
              userData['password'] == formData['password']) {
               
               // if user status is firstDoseDone, it throw a message below that dose not completed
            if (userData['status'] == 'firstDoseDone') {
              print("first dose done");
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration:Duration(seconds: 10),
                content: Text("First Dose Done !!!,Meet registrar to complete dose"),
         
              ));
            } else {
              // if dose is equal to secondDoseDone, it redirects to certificate screen
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return CertificateScreen(
                  identityNumber: userData['identityNumber'],
                );
              }));
            }
          } 
          // if password is not correct, it throws an errow message
          else if (userData['email'] == formData['email'] &&
              userData['password'] != formData['password']) {
            print("password not correct");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 10),
              content: const Text("User not found "),
              action: SnackBarAction(label: "Retry Again", onPressed: () {}),
            ));
          }
        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 10),
            content: const Text("User not found"),
            action: SnackBarAction(label: "Retry Again", onPressed: () {}),
          ));
        });
      });
    }
  }
}
