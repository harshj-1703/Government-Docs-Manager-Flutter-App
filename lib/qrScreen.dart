import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:government_docs_manager_app/websiteScreen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Government Docs Manager"),
        backgroundColor: Color.fromARGB(255, 0, 96, 192),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 6, child: _buildQrView(context)),
          Expanded(
            flex: 2,
            child: Container(
              color: Color.fromARGB(255, 0, 96, 192),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Container(
                        width: 120,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebSiteScreen(
                                        url: result!.code!,
                                      )),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Color.fromARGB(255, 0, 96, 192),
                          ),
                          child: Text('Check Result'),
                        ),
                      )
                    else
                      const Text(
                        'Scan QR And Verify',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          icon: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Icon(
                                snapshot.data == true
                                    ? Icons.flash_on
                                    : Icons.flash_off,
                                color: Colors.white,
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          icon: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Icon(
                                  snapshot.data == CameraFacing.back
                                      ? Icons.camera_rear
                                      : Icons.camera_front,
                                  color: Colors.white,
                                );
                              } else {
                                return const Icon(Icons.camera);
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          icon: const Icon(
                            Icons.pause,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.height < 400) ? 50.0 : 250.0;
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
      setState(() {
        result = scanData;
      });
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
