import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gst_scanner/services/gst_details_service.dart';
import 'package:loading_overlay/loading_overlay.dart';

class GetDetailsByText extends StatefulWidget {
  final String? gstin;

  const GetDetailsByText({super.key, this.gstin});

  @override
  State<GetDetailsByText> createState() => _GetDetailsByTextState();
}

class _GetDetailsByTextState extends State<GetDetailsByText> {
  final _formKey = GlobalKey<FormState>();
  String gstin = '';
  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.gstin != null) {
      gstin = widget.gstin!;
    }
  }

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

                        gstin = value;
                      });
                    }),
                    initialValue: widget.gstin,
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) {
                      final iReg = RegExp(
                          r'([0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}[Z]{1}[0-9A-Z]{1})');

                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (!iReg.hasMatch(value)) {
                        return 'Please enter valid GSTIN';
                        // ignore: unrelated_type_equality_checks
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        label: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Enter GSTIN',
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
                          await GstDetailsServices()
                              .getgstdetails(gstin, context);
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
                            'Get Details',
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
