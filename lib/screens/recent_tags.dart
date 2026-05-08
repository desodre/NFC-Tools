import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:nfctools/viewmodels/recent_tags_view_model.dart';

class RecentTagsWindow extends StatefulWidget {
  final RecentTagsViewModel viewModel;

  const RecentTagsWindow({super.key, required this.viewModel});

  @override
  State<RecentTagsWindow> createState() => _RecentTagsWindowState();
}

class _RecentTagsWindowState extends State<RecentTagsWindow> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadTags();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        if (widget.viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (widget.viewModel.tags.isEmpty) {
          return const Center(child: Text('No saved tags.'));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: widget.viewModel.tags.length,
            itemBuilder: (context, index) {
              return RecentTag(tag: widget.viewModel.tags[index]);
            },
          ),
        );
      },
    );
  }
}

class RecentTag extends StatelessWidget {
  final NFCTag tag;

  const RecentTag({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          const Icon(Icons.nfc_sharp),
          Column(
            children: <Widget>[Text(tag.type.name), Text(tag.id)],
          ),
        ],
      ),
    );
  }
}

