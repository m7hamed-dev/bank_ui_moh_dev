import 'dart:developer';
import 'dart:io';

import 'package:bank_ui_moh_dev/screens/card_bank/card_bank_controller.dart';
import 'package:bank_ui_moh_dev/screens/qr/send_money_via_qr_scnner_view.dart';
import 'package:bank_ui_moh_dev/tools/push.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScaanerViaQrView extends StatefulWidget {
  const ScaanerViaQrView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScaanerViaQrViewState();
}

class _ScaanerViaQrViewState extends State<ScaanerViaQrView> {
  Barcode? result;
  QRViewController? controller;
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

  // void _verified(Barcode? data) {
  //   if (data != null) {
  //     //print('result = ${result!.code}');
  //     // CardBankController().getOne(data.code!).then((value) {
  //     // if (value != null) {
  //     //   print('value = ${value.data()['number']}');
  //     //   // print('value = ${value.docs[0].data()['number']}');
  //     Push.toPageWithAnimation(context, ReciverInfoView(code: data.code!));
  //     // }
  //     // });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            // var trim = result!.code!.contains('http://');
                            print('result!.code! = ${result!.code}');
                            return;
                            // Push.toPageWithAnimation(
                            //   context,
                            //   ReciverInfoView(code: result!.code!),
                            // );
                          },
                          child: const Text('done',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (QRViewController qrViewController, bool isAllow) =>
          _onPermissionSet(context, qrViewController, isAllow),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    // setState(() {});

    controller.scannedDataStream.listen(
      (scanData) {
        print('============== \n ${scanData.code}  ============== \n');
        // if (scanData.code != null) {

        // return;
        // }
        result = scanData;
        setState(() {});
        // if (result != null) {
        //   // Push.toPageWithAnimation(
        //   //     context, ReciverInfoView(code: result!.code!));
        // }
        // print('result = ${result!.code}');
        // setState(() {});
      },
      // onDone: () {
      //   Push.toPageWithAnimation(context, ReciverInfoView(code: result!.code!));
      // },
    );
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
