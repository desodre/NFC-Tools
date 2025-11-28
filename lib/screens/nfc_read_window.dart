import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfctools/widgets/nfc_snack_bar.dart';
import 'package:nfctools/widgets/tag_scan_dialog.dart';
import 'package:nfctools/models/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NfcReadWindow extends StatelessWidget {
  const NfcReadWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScanTagButton(),
              ],
            ),
          );
          },
        );
  }
}

class ScanTagButton extends StatelessWidget {
  const ScanTagButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => TagScanDialog(),
        );

        var availability = await FlutterNfcKit.nfcAvailability;

        showSnackByAvailability(availability, context);

        try {
          var tag = await FlutterNfcKit.poll(
            androidPlatformSound: true,
            timeout: Duration(seconds: 5),
            iosMultipleTagMessage: "Multiple tags found!",
            iosAlertMessage: "Scan your tag",
          );

          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Tag Info:"),
              contentPadding: EdgeInsets.all(2),
              content: NfcCatalogInfo(tag: tag),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(8))
              ),
            ),
          );
        } catch (e) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(NfcSnackBar(
              content: Text(
                'Timeout exceeded.',
                textAlign: TextAlign.center,
              ),
            ));
          
        }
      },
      child: Text('Scan Tag'),
    );
  }

  void showSnackByAvailability(NFCAvailability availability, BuildContext context) {
    switch (availability) {
      case NFCAvailability.available:
        ScaffoldMessenger.of(context).showSnackBar(NfcSnackBar(
            content: const Text(
          'NFC is available.',
          textAlign: TextAlign.center,
        )));
    
      case NFCAvailability.disabled:
        ScaffoldMessenger.of(context).showSnackBar(NfcSnackBar(
          content: Text(
            'NFC is disabled.',
            textAlign: TextAlign.center,
          ),
        ));
    
      case NFCAvailability.not_supported:
        ScaffoldMessenger.of(context).showSnackBar(NfcSnackBar(
          content: Text(
            'NFC is not suported.',
            textAlign: TextAlign.center,
          ),
        ));
        break;
    }
  }
}

class NfcCatalogInfo extends StatelessWidget {
  final NFCTag tag;

  const NfcCatalogInfo({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return ListView(
      
      children: [
                NfcCardInfo(title: 'App Data', info: '${tag.applicationData}'),
                NfcCardInfo(title: 'ATQA', info: '${tag.atqa}'),
                NfcCardInfo(title: 'Manufacturer', info: '${tag.manufacturer}'),
                NfcCardInfo(title: 'Mifare Block Count', info: '${tag.mifareInfo?.blockCount}'),
                NfcCardInfo(title: 'Mifare Type', info: '${tag.mifareInfo?.type}'),
                NfcCardInfo(title: 'Mifare Size', info: '${tag.mifareInfo?.size}'),
                NfcCardInfo(title: 'Writable', info: '${tag.ndefWritable}'),
                NfcCardInfo(title: 'DSF ID', info: '${tag.dsfId}'),
                NfcCardInfo(title: 'HiLayer Response', info: '${tag.hiLayerResponse}'),
                NfcCardInfo(title: 'ID', info: tag.id),
                NfcCardInfo(title: 'Protocol', info: '${tag.protocolInfo}'),
                NfcCardInfo(title: 'Standard', info: tag.standard),
                NfcCardInfo(title: 'Type', info: tag.type.name),
                ElevatedButton(onPressed: () {
                  saveNFCTag(tag);
                  Navigator.of(context).pop();
                }, child: Text('Save'), )
    ],);
  }
}

Future<void> saveNFCTag(NFCTag tag) async {
  Map<String, dynamic> tagData = tag.toJson();
  final pref = await SharedPreferences.getInstance();
  List<String>? userTags =  pref.getStringList('user_saved_tags') ?? [];
  userTags.add(jsonEncode(tagData));
  await pref.setStringList('user_saved_tags', userTags);

}


class NfcCardInfo extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon; 

  const NfcCardInfo({ super.key, required this.title, required this.info, this.icon = Icons.info_outline});

  @override
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: customTxtStyleTitle,),
                Text(info, style: customTxtStyleParagraph,),
              ],
            ),
          )
        ],
      ),
    );
  }
}