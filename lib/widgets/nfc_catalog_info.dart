import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfctools/models/text_style.dart';

class NfcCatalogInfo extends StatefulWidget {
  final NFCTag tag;
  final VoidCallback onSave;

  const NfcCatalogInfo({super.key, required this.tag, required this.onSave});

  @override
  State<NfcCatalogInfo> createState() => _NfcCatalogInfoState();
}

class _NfcCatalogInfoState extends State<NfcCatalogInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          NfcCardInfo(title: 'App Data', info: '${widget.tag.applicationData}'),
          NfcCardInfo(title: 'ATQA', info: '${widget.tag.atqa}'),
          NfcCardInfo(title: 'Manufacturer', info: '${widget.tag.manufacturer}'),
          NfcCardInfo(title: 'Mifare Block Count', info: '${widget.tag.mifareInfo?.blockCount}'),
          NfcCardInfo(title: 'Mifare Type', info: '${widget.tag.mifareInfo?.type}'),
          NfcCardInfo(title: 'Mifare Size', info: '${widget.tag.mifareInfo?.size}'),
          NfcCardInfo(title: 'Writable', info: '${widget.tag.ndefWritable}'),
          NfcCardInfo(title: 'DSF ID', info: '${widget.tag.dsfId}'),
          NfcCardInfo(title: 'HiLayer Response', info: '${widget.tag.hiLayerResponse}'),
          NfcCardInfo(title: 'ID', info: widget.tag.id),
          NfcCardInfo(title: 'Protocol', info: '${widget.tag.protocolInfo}'),
          NfcCardInfo(title: 'Standard', info: widget.tag.standard),
          NfcCardInfo(title: 'Type', info: widget.tag.type.name),
          ElevatedButton(onPressed: widget.onSave, child: const Text('Save')),
        ],
      ),
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
