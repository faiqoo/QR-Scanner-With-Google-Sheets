import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../qr_widget/qr_scanner.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({Key? key}) : super(key: key);

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  bool buttonStatus = true;
  String qrValue = '';

  changeButton(bool val) {
    buttonStatus = val;
    setState(() {});
  }

  String dropdownvalue = 'Lahore';

  // List of items in our dropdown menu
  var items = ['Lahore', 'Islamabad'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.rectangle,color: Theme.of(context).colorScheme.primaryContainer),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.location_on),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QRViewCamera(loc: dropdownvalue),
              ));
            },
            child: Container(
              decoration: const BoxDecoration(
                // color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage(
                    "icons/qr_code.png",
                  ),
                ),
              ),
            ),
          ),
        ),
        CupertinoButton(
          borderRadius: BorderRadius.zero,
          minSize: 40.h,
          padding: EdgeInsets.all(25.h),
          color: Theme.of(context).colorScheme.primaryContainer,
          disabledColor: Colors.grey,
          onPressed: buttonStatus
              ? () async {
                  // qrValue = await Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => QRViewCamera(loc: dropdownvalue),
                  // ));
                  // print(qrValue);
                  // changeButton(true);
            Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QRViewCamera(loc: dropdownvalue),
                ));
                }
              : null,
          child: GestureDetector(
            onTap: () {
              // moveToScreen(qrValue);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QRViewCamera(loc: dropdownvalue),
              ));
            },
            child: Center(
                child: Text(
              buttonStatus ? "Proceed" : "Scan the QR code to proceed",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            )),
          ),
        ),
        // const SizedBox(
        //   height: 50,
        // ),
      ],
    );
  }
}
