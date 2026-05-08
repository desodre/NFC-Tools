import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfctools/viewmodels/nfc_scan_view_model.dart';
import 'package:nfctools/widgets/nfc_catalog_info.dart';
import 'package:nfctools/widgets/nfc_snack_bar.dart';
import 'package:nfctools/widgets/tag_scan_dialog.dart';

class NfcReadWindow extends StatefulWidget {
  final NfcScanViewModel viewModel;

  const NfcReadWindow({super.key, required this.viewModel});

  @override
  State<NfcReadWindow> createState() => _NfcReadWindowState();
}

class _NfcReadWindowState extends State<NfcReadWindow> {
  void _showAvailabilitySnack(NFCAvailability availability) {
    final message = switch (availability) {
      NFCAvailability.available => 'NFC is available.',
      NFCAvailability.disabled => 'NFC is disabled.',
      NFCAvailability.not_supported => 'NFC is not supported.',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      NfcSnackBar(content: Text(message, textAlign: TextAlign.center)),
    );
  }

  void _showTagInfoDialog() {
    final tag = widget.viewModel.tag!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tag Info:'),
        contentPadding: const EdgeInsets.all(2),
        content: NfcCatalogInfo(
          tag: tag,
          onSave: () async {
            await widget.viewModel.saveCurrentTag();
            if (mounted) Navigator.of(context).pop();
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
        ),
      ),
    );
  }

  Future<void> _startScan() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const TagScanDialog(),
    );

    final availability = await widget.viewModel.checkAvailability();
    if (!mounted) return;
    _showAvailabilitySnack(availability);

    await widget.viewModel.pollTag();
    if (!mounted) return;

    Navigator.of(context).pop();

    if (widget.viewModel.status == NfcScanStatus.tagFound) {
      _showTagInfoDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        NfcSnackBar(
          content: const Text('Timeout exceeded.', textAlign: TextAlign.center),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _startScan,
        child: const Text('Scan Tag'),
      ),
    );
  }
}