import 'package:flutter/material.dart';
import 'package:label_craft/models/label_header.dart';
import 'package:label_craft/theme/app_theme.dart';
import 'package:label_craft/utils/app_routes.dart';

class HeaderSelectDropdown extends StatefulWidget {
  const HeaderSelectDropdown({
    super.key,
    required this.headers,
    required this.selectedHeader,
    required this.onChanged,
  });

  final List<LabelHeader> headers;
  final LabelHeader? selectedHeader;
  final ValueChanged<LabelHeader?> onChanged;

  @override
  State<HeaderSelectDropdown> createState() => _HeaderSelectDropdownState();
}

bool _hasHeader = false;

class _HeaderSelectDropdownState extends State<HeaderSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Incluir Cabeçalho'),
          value: _hasHeader,
          onChanged: (val) => setState(() => _hasHeader = val),
        ),
        if (_hasHeader)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppTheme.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<LabelHeader>(
                      hint: const Text('Selecione um modelo de cabeçalho'),
                      isExpanded: true,
                      value: _hasHeader ? widget.selectedHeader : null,
                      onChanged: widget.onChanged,
                      items:
                          widget.headers.map((header) {
                            return DropdownMenuItem<LabelHeader>(
                              value: header,
                              child: Text(header.name),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.HEADER_FORM);
                },
                icon: Icon(Icons.add),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  iconColor: WidgetStatePropertyAll(Colors.white),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
