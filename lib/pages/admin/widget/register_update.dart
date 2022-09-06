import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/widget/registrar_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterUpdate extends StatefulWidget {
  final String email;
  final String type;
  const RegisterUpdate({Key? key, required this.email, required this.type})
      : super(key: key);

  @override
  State<RegisterUpdate> createState() => _RegisterUpdateState();
}

class _RegisterUpdateState extends State<RegisterUpdate> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscure = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Update"),
        backgroundColor: widget.type == 'registrar'
            ? Colors.pink
            : widget.type == 'admin'
                ? Colors.blue
                : Colors.red,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('email', isEqualTo: widget.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot<Object?>>? data =
                    snapshot.data?.docs;
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Update User Data",
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: 'name', // controller: emailController,
                            keyboardType: TextInputType.name,
                            initialValue: data?[0]['name'],
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            onSaved: (value) {
                              // emailController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),

                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.mail, color: Colors.black),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Name",
                              hintStyle:
                                  TextStyle(color: Colors.red.withOpacity(0.6)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: 'email', // controller: emailController,
                            initialValue: data?[0]['email'],
                            keyboardType: TextInputType.name,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            onSaved: (value) {
                              // emailController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.mail, color: Colors.black),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Email",
                              hintStyle:
                                  TextStyle(color: Colors.red.withOpacity(0.6)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: 'password', // controller: emailController,
                            initialValue: data?[0]['password'],
                            keyboardType: TextInputType.name,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                            onSaved: (value) {
                              // emailController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            obscureText: obscure,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  icon: obscure
                                      ? const Icon(Icons.visibility,
                                          color: Colors.black)
                                      : const Icon(Icons.visibility_off,
                                          color: Colors.black)),
                              prefixIcon: const Icon(Icons.vpn_key,
                                  color: Colors.black),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "Password",
                              hintStyle:
                                  TextStyle(color: Colors.red.withOpacity(0.6)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderDropdown(
                            name: 'role',
                            initialValue: data?[0]['role'],
                            hint: const Text("Choose Role"),
                            isExpanded: true,
                            items: [
                              "admin",
                              "verifier",
                              "registrar"
                              // "Emergency",
                            ].map((option) {
                              return DropdownMenuItem(
                                child: Text(option),
                                value: option,
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              // prefixIcon: const Icon(Icons.mail, color: Colors.black),
                              // contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(30),
                            color: widget.type == 'registrar'
                                ? Colors.pink
                                : widget.type == 'admin'
                                    ? Colors.blue
                                    : Colors.red,
                            child: MaterialButton(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                handleUpdate();
                              },
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
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
                      )),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  void handleUpdate() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final formData = _formKey.currentState!.value;
      DocumentReference registerUser =
          FirebaseFirestore.instance.collection("users").doc(formData['email']);
      registerUser.update(formData).whenComplete(() {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Update Successful");
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const RegistrarList();
        }));
      });
    }
  }
}
