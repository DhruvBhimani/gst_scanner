import 'package:flutter/material.dart';
import 'package:gst_scanner/constants.dart';
import 'package:gst_scanner/models/gst_user_models.dart';
import 'package:gst_scanner/screens/mail_pdf_screen.dart';
import 'package:gst_scanner/utils.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GstDetailsScreen extends StatefulWidget {
  final GstUserModels gstdetails;

  const GstDetailsScreen({super.key, required this.gstdetails});

  @override
  State<GstDetailsScreen> createState() => _GstDetailsScreenState();
}

class _GstDetailsScreenState extends State<GstDetailsScreen> {
  bool isloading = false;
  final pdf = pw.Document();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                pw.Row(
                  children: [
                    pw.Text(
                      'GSTIN : ',
                      style: pdftextstyle,
                    ),
                    pw.Text(
                      widget.gstdetails.gstin!,
                      style: pdftextstyle,
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 0.6,
                  color: PdfColor.fromInt(Colors.black.value),
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'CompanyName : ',
                      style: pdftextstyle,
                    ),
                    pw.Text(
                      widget.gstdetails.name!,
                      style: pdftextstyle,
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 0.6,
                  color: PdfColor.fromInt(Colors.black.value),
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'PhoneNumber : ',
                      style: pdftextstyle,
                    ),
                    pw.Text(
                      widget.gstdetails.phonenumber!,
                      style: pdftextstyle,
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 0.6,
                  color: PdfColor.fromInt(Colors.black.value),
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      'Email : ',
                      style: pdftextstyle,
                    ),
                    pw.Text(
                      widget.gstdetails.email!,
                      style: pdftextstyle,
                    )
                  ],
                ),
                pw.Divider(
                  thickness: 0.6,
                  color: PdfColor.fromInt(Colors.black.value),
                ),
              ])); // Center
        })); // Page
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isloading,
      progressIndicator: SpinKitThreeBounce(color: Colors.blue),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'GSTIN : ',
                      style: gstdetailstextstyle,
                    ),
                    Text(
                      widget.gstdetails.gstin!,
                      style: gstdetailstextstyle,
                    )
                  ],
                ),
                Divider(
                  thickness: 0.6,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Text(
                      'CompanyName : ',
                      style: gstdetailstextstyle,
                    ),
                    Text(
                      widget.gstdetails.name!,
                      style: gstdetailstextstyle,
                    )
                  ],
                ),
                Divider(
                  thickness: 0.6,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Text(
                      'PhoneNumber : ',
                      style: gstdetailstextstyle,
                    ),
                    Text(
                      widget.gstdetails.phonenumber!,
                      style: gstdetailstextstyle,
                    )
                  ],
                ),
                Divider(
                  thickness: 0.6,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Text(
                      'Email : ',
                      style: gstdetailstextstyle,
                    ),
                    Text(
                      widget.gstdetails.email!,
                      style: gstdetailstextstyle,
                    )
                  ],
                ),
                Divider(
                  thickness: 0.6,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 50),
                      child: ElevatedButton(
                          onPressed: () async {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => GetDetailsByText()));
                            setState(() {
                              isloading = true;
                            });
                            await downloadpdf(pdf);
                            setState(() {
                              isloading = false;
                            });
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: const Center(
                              child: const Text(
                                'Download PDF',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    letterSpacing: 1),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 50),
                      child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MailPDF(
                                          pdf: pdf,
                                        )));
                          },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: const Center(
                              child: const Text(
                                'Mail PDF',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    letterSpacing: 1),
                              ),
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
