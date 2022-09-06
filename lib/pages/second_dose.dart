import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/certificate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class SecondDose extends StatefulWidget {
  final String identityNumber;
  const SecondDose({Key? key, required this.identityNumber}) : super(key: key);

  @override
  State<SecondDose> createState() => _SecondDoseState();
}

class _SecondDoseState extends State<SecondDose> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isValidating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Dose"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("registeredIndividual")
              .doc(widget.identityNumber)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
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
                            enabled: false,
                            name: 'identityNumber',
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.numeric(context),
                            ]),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: data['name'],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            enabled: false,
                            name: 'identityNumber',
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
                              hintText: data['identityNumber'],
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
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    minWidth: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                      handleSecondDose();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.verified_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Second Dose Taken",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
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
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  //this function confirm second dose of vaccine taken by updating the status to secondDoseDone
  handleSecondDose() async {
    setState(() {
      isValidating = true;
    });
    DocumentReference doc = FirebaseFirestore.instance
        .collection("registeredIndividual")
        .doc(widget.identityNumber);
    doc.update({
      'status': 'secondDoseDone',
      'secondDose': DateFormat("dd-MM-yyyy").format(DateTime.now())
    }).whenComplete(() {
      setState(() {
        isValidating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 10),
        content: const Text("Vaccination Completed"),
        action: SnackBarAction(
            label: "Print Certificate",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return CertificateScreen(
                  identityNumber: widget.identityNumber,
                );
              }));
            }),
      ));
      // print("successful");
    });
  }
}
