import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';


buildPrintableData(
        String name,
        String email,
        String gender,
        String tel,
        String address,
        String dob,
        String cnic,
        String vaccineType,
        String firstDose,
        String secondDose,
        String certificateNo) =>
    pw.Padding(
      padding: pw.EdgeInsets.all(10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Covid 19 pass"),
                pw.Text("Fully Vaccinated"),
              ]),
          pw.SizedBox(height: 20),
          pw.Text("Personal Information"),
          pw.Container(
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [

                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text('Name:'),
                            pw.SizedBox(width: 10),
                            pw.Text(name,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text('Email:'),
                            pw.SizedBox(width: 10),
                            pw.Text(email,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text('Gender:'),
                            pw.SizedBox(width: 10),
                            pw.Text(gender,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                    ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text('Tel:'),
                            pw.SizedBox(width: 10),
                            pw.Text(tel,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text('Address:'),
                            pw.SizedBox(width: 10),
                            pw.Text(address,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text('Dob:'),
                            pw.SizedBox(width: 10),
                            pw.Text(dob,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )),
                          ]),
                    ])
              ],
            ),
          ),
          pw.SizedBox(
            height: 20,
          ),
          pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Row(children: [
              pw.Text('Identity Number:'),
              pw.SizedBox(width: 10),
              pw.Text(cnic,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  )),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Text('VaccineType:'),
              pw.SizedBox(width: 10),
              pw.Text(vaccineType,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  )),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Text('FirstDose:'),
              pw.SizedBox(width: 10),
              pw.Text(firstDose,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  )),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Text('SecondDose:'),
              pw.SizedBox(width: 10),
              pw.Text(secondDose,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  )),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
              pw.Text('Status:'),
              pw.SizedBox(width: 10),
              pw.Text('vaccinated',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  )),
            ]),
          ]),
          pw.SizedBox(
            height: 20,
          ),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Certificate No",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Text(certificateNo),
                  pw.Text("Issued Date",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Text(secondDose),
                ]),
          ]),
        ],
      ),
    );
