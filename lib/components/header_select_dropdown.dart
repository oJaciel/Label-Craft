import 'package:flutter/material.dart';
import 'package:label_craft/models/label_header.dart';

class HeaderSelectDropdown extends StatelessWidget {
  const HeaderSelectDropdown({
    super.key,
    required this.headers,
    required this.selectedHeader,
    required this.onChanged,
  });

  final List<LabelHeader> headers;
  final LabelHeader selectedHeader;
  final ValueChanged<LabelHeader?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Cabeçalho:', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<LabelHeader>(
          value: selectedHeader,
          onChanged: onChanged,
          items:
              headers.map((header) {
                return DropdownMenuItem<LabelHeader>(
                  value: header,
                  child: Text(header.name),
                );
              }).toList(),
        ),
      ],
    );
  }
}
