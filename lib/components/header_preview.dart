import 'package:flutter/material.dart';
import 'package:label_craft/models/label_header.dart';

class HeaderPreview extends StatelessWidget {
  const HeaderPreview(this.header, {super.key});

  final LabelHeader header;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (header.image != null && header.image != '')
                Image.network(
                  header.image ?? '',
                  alignment: Alignment.center,
                  width: 120,
                  height: 55,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      'Imagem não encontrada',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      height: 55,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),

              if (header.displayName!.isNotEmpty)
                Text(
                  header.displayName ?? '',
                  style: TextStyle(
                    fontSize:
                        header.image != null && header.image != '' ? 12 : 20,
                  ),
                  textAlign: TextAlign.start,
                ),
              if (header.aditionalInfo!.isNotEmpty)
                Text(
                  header.aditionalInfo ?? '',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.start,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
