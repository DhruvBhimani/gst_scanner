import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:gst_scanner/utils.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pdf/widgets.dart' as pw;

class MailPDF extends StatefulWidget {
  final pw.Document pdf;

  const MailPDF({super.key, required this.pdf});

  @override
  State<MailPDF> createState() => _MailPDFState();
}

class _MailPDFState extends State<MailPDF> {
  String email = '';
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isloading,
      progressIndicator: SpinKitThreeBounce(color: Colors.blue),
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 30, right: 20),
                  child: TextFormField(
                    // style: TextStyle(color: Colors.white),
                    // cursorColor: Colors.white,
                    onChanged: ((value) {
                      setState(() {
                        // dispatcher.email = value;

                        email = value;
                      });
                    }),
                    // textCapitalization: TextCapitalization.characters,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please enter valid email';
                        // ignore: unrelated_type_equality_checks
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        label: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Enter Email',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        // filled: true,
                        // fillColor: kPrimaryColor,
                        // border: OutlineInputBorder(
                        //     borderSide: BorderSide.none,

                        //     borderRadius: BorderRadius.circular(10))
                        border: UnderlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 50),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isloading = true;
                          });
                          await mailpdf(widget.pdf, email);
                          setState(() {
                            isloading = false;
                          });
                        }
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                            'Send',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                letterSpacing: 1),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
