import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/certificate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // String vaccineType = '';
  bool obscure = false;
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController dateController = TextEditingController();
  bool isValidating = false;
  var date = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register New Individual"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: Image.asset("images/logo.png"),
            ),
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      keyboardType: TextInputType.name,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'password',
                      keyboardType: TextInputType.emailAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      obscureText: obscure,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: obscure
                              ? Icon(Icons.visibility_outlined)
                              : Icon(Icons.visibility_off_outlined),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Enter Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'identityNumber',
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      //  inputFormatters: [
                      //     CreditCardFormatter(),
                      //   ],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.perm_identity_outlined),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "CNIC/POR",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'tel',
                      keyboardType: TextInputType.phone,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Tel",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'address',
                      keyboardType: TextInputType.streetAddress,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderDropdown(
                      name: 'gender',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      isExpanded: true,
                      items: [
                        "Male",
                        "Female",
                      ].map((option) {
                        return DropdownMenuItem(
                          child: Text("$option"),
                          value: option,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Gender",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "You must be above 5years and below 100years to take vaccine",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    FormBuilderDateTimePicker(
                      name: 'dob',
                      keyboardType: TextInputType.datetime,
                      controller: dateController,
                      inputType: InputType.date,
                      firstDate: DateTime(date.year - 100),
                      lastDate: DateTime(date.year - 5),
                      initialDate: DateTime(date.year - 5),
                      // format: DateFormat("dd-MM-yyyy"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Date of birth",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderDropdown(
                      name: 'vaccineType',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      isExpanded: true,
                      items: ["Moderna", "Fizer", "Sinoform", "Janssen"]
                          .map((option) {
                        return DropdownMenuItem(
                          child: Text("$option"),
                          value: option,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Vaccine Type",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'vaccineID',
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Vaccine ID",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    isValidating
                        ? const CircularProgressIndicator()
                        : Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.redAccent,
                            child: MaterialButton(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                handleRegister(dateController.text);
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
      ),
    );
  }

// this function handle registration of new user to firebase
  handleRegister(date) async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isValidating = true;
      });
      final formData = _formKey.currentState!.value;
      //get random number for certificate
      Random rnd = new Random();
      int min = 10000000, max = 99999999;
      int certificateId = min + rnd.nextInt(max - min);

      DocumentReference registerUser = FirebaseFirestore.instance
          .collection("registeredIndividual")
          .doc(formData['identityNumber']);
      registerUser.set(formData).whenComplete(() {
        // check if vaccine type is jassen and set status to secondDoseDone because jassen is only vaccinated once
        formData['vaccineType'] == 'Janssen'
            ? FirebaseFirestore.instance
                .collection("registeredIndividual")
                .doc(formData['identityNumber'])
                .update({
                'id': registerUser.id,
                'dob': date,
                'status': 'secondDoseDone',
                'role': 'patient',
                'firstDose': DateFormat("dd-MM-yyyy").format(
                  DateTime.now(),
                ),
                'secondDose': '',
                'certificateID': certificateId.toString(),
              }).then((value) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CertificateScreen(
                      identityNumber: formData['identityNumber']);
                }));
                Fluttertoast.showToast(
                    msg: "Individual record has been stored successfully");
                setState(() {
                  isValidating = false;
                });
              }).catchError((e) {
                Fluttertoast.showToast(msg: e.message);
                // print(e.message);
                setState(() {
                  isValidating = false;
                });
              })
            : FirebaseFirestore.instance
                .collection("registeredIndividual")
                .doc(formData['identityNumber'])
                .update({
                'id': registerUser.id,
                'dob': date,
                'role': 'patient',
                'status': 'firstDoseDone',
                'firstDose': DateFormat("dd-MM-yyyy").format(DateTime.now()),
                'secondDose': DateFormat("dd-MM-yyyy").format(DateTime.now()),
                'certificateID': certificateId.toString(),
              }).then((value) {
                Fluttertoast.showToast(
                    msg: "Individual record has been stored successfully");
                setState(() {
                  isValidating = false;
                });
              }).catchError((e) {
                Fluttertoast.showToast(msg: e.message);
                // print(e.message);
                setState(() {
                  isValidating = false;
                });
              });
      });
    }
  }
}
