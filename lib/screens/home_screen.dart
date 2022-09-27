import 'package:flutter/material.dart';
import 'package:gst_scanner/screens/get_details_by_text.dart';
import 'package:gst_scanner/text_detector_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 0),
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TextRecognizerView()));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Center(
                      child: const Text(
                        'Scan GSTIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 50),
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GetDetailsByText()));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: const Center(
                      child: const Text(
                        'Enter GSTIN',
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
    );
  }
}
