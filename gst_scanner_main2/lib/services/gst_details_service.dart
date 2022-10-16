import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gst_scanner/constants.dart';
import 'package:gst_scanner/models/gst_user_models.dart';
import 'package:gst_scanner/screens/gst_details_screen.dart';
import 'package:gst_scanner/utils.dart';
import 'package:http/http.dart' as http;
// import 'package:dart_ipify/dart_ipify.dart';




class GstDetailsServices {
  getgstdetails(String gstin, BuildContext context) async {

    // final ipv4 = await Ipify.ipv4();
    // print(ipv4);

    String Url = '$host/api/gst-users?filters[GSTIN][\$eq]=$gstin';

    var response = await http.get(Uri.parse(Url), headers: headers);
    var json = jsonDecode(response.body);

    print(json);
    if (response.statusCode == 200) {
      if (json['data'] != null && json['data'].length != 0) {
        GstUserModels gstdetails =
            GstUserModels.fromJson(json['data'][0]['attributes']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GstDetailsScreen(
                      gstdetails: gstdetails,
                    )));
      } else {
        return errorSnackBar(context, 'No details found for this GSTIN.');
      }
    } else {
      return errorSnackBar(context, 'something went wrong.');
    }
  }
}
