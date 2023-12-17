import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/screens/verification_screen.dart';

class QRViewCamera extends StatefulWidget {
  QRViewCamera({Key? key, this.loc}) : super(key: key);

  String? loc;

  @override
  State<StatefulWidget> createState() => _QRViewCameraState();
}

class _QRViewCameraState extends State<QRViewCamera> {
  Barcode? result;
  QRViewController? controller;
  bool isDialogOpen = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  moveToScreen(BuildContext context, String? id) {
    Navigator.pop(context);

    result.toString().isNotEmpty
        ? Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  VerificationScreen(id: id ?? result!.code ?? '', loc: widget.loc??''),
            ),
          )
        : () {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                  child: const Icon(
                    size: 50,
                    Icons.flash_on,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!isDialogOpen) {
        setState(() {
          result = scanData;
          isDialogOpen = true;
          if (Platform.isAndroid) {
            controller.pauseCamera();
          }
        });
        result != null
            ? showDialog(
                context: context,
                builder: (context) => WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: AlertDialog(
                    title: const Text("Scanned Data"),
                    content: Text(result?.code ?? ""),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          moveToScreen(context, result!.code);
                          isDialogOpen = false;
                        },
                        child: const Text("Proceed"),
                      ),
                    ],
                  ),
                ),
              )
            : () {};
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
