import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/registered_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class RegisteredUserUpdate extends StatefulWidget {
  final String email;
  const RegisteredUserUpdate({Key? key, required this.email}) : super(key: key);

  @override
  State<RegisteredUserUpdate> createState() => _RegisteredUserUpdateState();
}

class _RegisteredUserUpdateState extends State<RegisteredUserUpdate> {
  final _formKey = GlobalKey<FormBuilderState>();
  // TextEditingController dateController = TextEditingController();
  bool isValidating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register New Individual"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("registeredIndividual")
                .where('email', isEqualTo: widget.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Object?>>? data =
                    snapshot.data?.docs;
                var date = DateFormat("dd-MM-yyyy").parse(data?[0]['dob']);
                var dob = DateTime.parse(date.toString());
                return Column(
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
                              initialValue: data?[0]['name'],
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
                              initialValue: data?[0]['email'],
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
                              name: 'identityNumber',
                              initialValue: data?[0]['identityNumber'],
                              keyboardType: TextInputType.number,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.numeric(context),
                              ]),
                              decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.perm_identity_outlined),
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
                              initialValue: data?[0]['tel'],
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
                              initialValue: data?[0]['address'],
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
                              initialValue: data?[0]['gender'],
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
                            // FormBuilderDateTimePicker(
                            //   name: 'dob',
                            //   initialValue: dob,
                            //   keyboardType: TextInputType.datetime,
                            //   controller: dateController,
                            //   inputType: InputType.date,
                            //   format: DateFormat("dd-MM-yyyy"),
                            //   validator: FormBuilderValidators.compose([
                            //     // FormBuilderValidators.required(context),
                            //   ]),
                            //   decoration: InputDecoration(
                            //     prefixIcon: const Icon(Icons.person),
                            //     contentPadding:
                            //         const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            //     hintText: "Date of birth",
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            FormBuilderDropdown(
                              name: 'vaccineType',
                              initialValue: data?[0]['vaccineType'],
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                              isExpanded: true,
                              items: [
                                "Moderna",
                                "Fizer",
                                "Sinoform",
                                "Janssen",
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
                                hintText: "Vaccine Type",
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 15),
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      onPressed: () {
                                        handleUpdate();
                                      },
                                      child: const Text(
                                        "Update Data",
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
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  handleUpdate() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isValidating = true;
      });
      final formData = _formKey.currentState!.value;
      // formData.update({'':''})
      DocumentReference registerUser = FirebaseFirestore.instance
          .collection("registeredIndividual")
          .doc(formData['identityNumber']);
      registerUser.update(formData).whenComplete(() {
        FirebaseFirestore.instance
            .collection("registeredIndividual")
            .doc(registerUser.id)
            .update({
          'id': registerUser.id,
          // 'dob': date,
          'status': 'firstDoseDone',
          'createdOn': DateFormat("dd-MM-yyyy").format(DateTime.now()),
          'lastUpadte': DateFormat("dd-MM-yyyy").format(DateTime.now())
        }).then((value) {
          Fluttertoast.showToast(
              msg: "Individual record has been stored successfully");
          setState(() {
            isValidating = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const RegisteredUserList();
          }));
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
