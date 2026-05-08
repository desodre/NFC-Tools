import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfctools/models/text_style.dart';

class NfcCatalogInfo extends StatelessWidget {
  final NFCTag tag;
  final VoidCallback onSave;

  const NfcCatalogInfo({super.key, required this.tag, required this.onSave});

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
        ElevatedButton(onPressed: onSave, child: const Text('Save')),
      ],
    );
  }
}

class NfcCardInfo extends StatelessWidget {
  final String title;
  final String info;
  final IconData icon;

  const NfcCardInfo({
    super.key,
    required this.title,
    required this.info,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
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
                Text(title, style: customTxtStyleTitle),
                Text(info, style: customTxtStyleParagraph),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
