import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/admin/admin_root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscure = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register New User"),
        backgroundColor: Colors.redAccent,
      ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.redAccent,
      //   onPressed: () {},
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //     size: 36,
      //   ),
      // ),
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
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Register new user",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'name', // controller: emailController,
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    onSaved: (value) {
                      // emailController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.redAccent,
                    style: const TextStyle(color: Colors.black),

                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.mail, color: Colors.redAccent),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.red.withOpacity(0.6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'email', // controller: emailController,
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    onSaved: (value) {
                      // emailController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.redAccent,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.mail, color: Colors.redAccent),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.red.withOpacity(0.6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'password', // controller: emailController,
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    onSaved: (value) {
                      // emailController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: Colors.redAccent,
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
                                  color: Colors.redAccent)
                              : const Icon(Icons.visibility_off,
                                  color: Colors.redAccent)),
                      prefixIcon:
                          const Icon(Icons.vpn_key, color: Colors.redAccent),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.red.withOpacity(0.6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderDropdown(
                    name: 'role',
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
                      // prefixIcon: const Icon(Icons.mail, color: Colors.redAccent),
                      // contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.redAccent,
                    child: MaterialButton(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        handleRegister();
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
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
        ),
      ),
    );
  }

  void handleRegister() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final formData = _formKey.currentState!.value;
      DocumentReference registerUser =
          FirebaseFirestore.instance.collection("users").doc(formData['email']);
      registerUser.set(formData).whenComplete(() {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Registered Successfully");
      });
    }
  }
}
