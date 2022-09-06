import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/certificate.dart';
import 'package:covid_19/pages/register.dart';
import 'package:covid_19/pages/second_dose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:covid_19/pages/login.dart';

class VerifyUser extends StatefulWidget {
  const VerifyUser({Key? key}) : super(key: key);

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isValidating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Check User Vacination State"),
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return const LoginScreen();
              }));
            },
            icon: const Icon(Icons.logout_rounded)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    name: 'identityNumber',
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                    ]),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.perm_identity_outlined),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter Cnic",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isValidating
                      ? const CircularProgressIndicator()
                      : Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.redAccent,
                          child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              handleValidate();
                            },
                            child: const Text(
                              "Validate",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void handleValidate() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      final formData = _formKey.currentState!.value;
      setState(() {
        isValidating = true;
      });
      var getDetails = FirebaseFirestore.instance
          .collection("registeredIndividual")
          .doc(formData['identityNumber']);
      getDetails.get().then((value) {
        setState(() {
          isValidating = false;
        });
        if (value['status'] == 'firstDoseDone') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 10),
            content: Text("First Dose Done !!!"),
          ));
        } else if (value['status'] == 'secondDoseDone') {
          setState(() {
            isValidating = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 5),
            content: const Text("Second Dose Done"),
            action: SnackBarAction(
                label: "Print Certificate",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return CertificateScreen(
                      identityNumber: value['identityNumber'],
                    );
                  }));
                }),
          ));
        }
      }).catchError((e) {
        setState(() {
          isValidating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 5),
          content: Text("User Record Not Found"),
          // action: SnackBarAction(
          //     label: "Meet registrar!!",
          //     onPressed: () {
          //       // Navigator.push(context, MaterialPageRoute(builder: (_) {
          //       //   return const RegisterScreen();
          //       // }));
          //     }),
        ));
      });
    }
  }
}
