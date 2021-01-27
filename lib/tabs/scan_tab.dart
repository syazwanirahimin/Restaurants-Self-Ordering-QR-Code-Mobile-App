import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:menuyo/styles.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Scan to Pay";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "QR Code",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                String codeSanner =
                await BarcodeScanner.scan(); //barcode scnner
                setState(() {
                  qrCodeResult = codeSanner;
                });

                // try{
                //   BarcodeScanner.scan()    this method is used to scan the QR code
                // }catch (e){
                //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                // }
              },
              child: Text(
                "Open Scanner",
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text('Meal Plan Card', style: heading)),
        buildCreditCard(),
          ],
        ),
      ),
    );
  }

//its quite simple as that you can use try and catch staatements too for platform exception
  Widget buildCreditCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [raisedBoxShadow],
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/cardbg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('196359', style: creditCardNo),
              //Image.asset('assets/mastercard.png',
                  //width: 46, fit: BoxFit.fitWidth),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/chip.png', width: 30, fit: BoxFit.fitWidth),
              Text('   Universiti Putra Malaysia', style: creditNormal),
            ],
          ),
          SizedBox(height: 6),
          Text('Syazwani Rahimin', style: creditCardNo),
        ],
      ),
    );
  }
}
