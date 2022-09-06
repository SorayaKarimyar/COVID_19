import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19/pages/printable_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CertificateScreen extends StatefulWidget {
  final String identityNumber;
  const CertificateScreen({Key? key, required this.identityNumber})
      : super(key: key);

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  var userData = {};
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vaccine Certificate"),
        backgroundColor: Colors.redAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    shareDoc(
                      userData['name'],
                      userData['email'],
                      userData['gender'],
                      userData['tel'],
                      userData['address'],
                      userData['dob'],
                      userData['identityNumber'],
                      userData['vaccineType'],
                      userData['firstDose'],
                      userData['secondDose'],
                      userData['certificateID'],
                    );
                  },
                  child: Text("Share"),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      printDoc(
                        userData['name'],
                        userData['email'],
                        userData['gender'],
                        userData['tel'],
                        userData['address'],
                        userData['dob'],
                        userData['identityNumber'],
                        userData['vaccineType'],
                        userData['firstDose'],
                        userData['secondDose'],
                        userData['certificateID'],
                      );
                    },
                    child: Text("Print Now")),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("registeredIndividual")
                .doc(widget.identityNumber)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went Wrong");
              }
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                userData = data;
                return certificateScreen(
                  context,
                  data,
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }

  Container certificateScreen(BuildContext context, Map<String, dynamic> data) {
    return Container(
      color: const Color.fromARGB(255, 251, 251, 158),
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: Image.asset("images/logo.png"),
                        ),
                        const Text(
                          "Covid 19 Pass",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.red,
                            width: 2,
                          )),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "FULLY VACCINATED",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      height: 20,
                    ),
                    Text("Personal Information"),
                    Divider(),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Name : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['name'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Email : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['email'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Gender"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['gender'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Tel no : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['tel'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Address : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['address'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Date of Birth : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['dob'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Official Information"),
                    Divider(),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Identity Number : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['identityNumber'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Vaccine Type : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['vaccineType'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("FirstDose : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['firstDose'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("SecondDose : "),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              data['secondDose'] != null ||
                                      data['secondDose'] != ''
                                  ? data['secondDose']
                                  : '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text("Status : "),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Vacinnated",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Certificate No",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data['certificateID'],
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Issued Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data['secondDose'] != ''
                            ? data['secondDose']
                            : data['firstDose'],
                        style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  QrImage(
                    backgroundColor: Colors.white,
                    gapless: false,
                    // embeddedImage: const AssetImage('images/logo.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size(50, 50),
                    ),
                    data: "Name: " +
                        data['name'] +
                        " " +
                        "Identity Number: " +
                        data['identityNumber'] +
                        " " +
                        "Vaccine Type:" +
                        data['vaccineType'],
                    version: QrVersions.auto,
                    size: 100.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future printDoc(
      String name,
      String email,
      String gender,
      String tel,
      String address,
      String dob,
      String cnic,
      String vaccineType,
      String fDose,
      String sDose,
      String certificateNo) async {
    // final image = await imageFromAssetBundle("images/logo.png");

    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(name, email, gender, tel, address, dob,
              cnic, vaccineType, fDose, sDose, certificateNo);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  Future<void> shareDoc(
      String name,
      String email,
      String gender,
      String tel,
      String address,
      String dob,
      String cnic,
      String vaccineType,
      String fDose,
      String sDose,
      String certificateNo) async {
 
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(name, email, gender, tel, address, dob,
              cnic, vaccineType, fDose, sDose, certificateNo);
        }));
    await Printing.sharePdf(bytes: await doc.save(), filename: 'my-cnic.pdf');
  }
}
