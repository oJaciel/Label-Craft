import 'package:flutter/material.dart';
import 'package:label_craft/models/label.dart';
import 'package:label_craft/models/label_header.dart';
import 'package:label_craft/models/pdf_provider.dart';

class LabelPreview extends StatelessWidget {
  const LabelPreview(this.label, {super.key, this.header});

  final Label label;
  final LabelHeader? header;

  @override
  Widget build(BuildContext context) {
    Widget showHeaderImage() {
      if (header?.image == null || header?.image == '') {
        return Text(
          header?.displayName ?? '',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              header?.image ?? '',
              width: 120,
              height: 55,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  header?.displayName ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                );
              },
            ),
            Text(
              header?.displayName ?? '',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.start,
            ),
          ],
        );
      }
    }

    final double? sizedBoxHeight = 4;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        children: [
          //Coluna da imagem, CPF e Fone
          if (header != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showHeaderImage(),
                Text(
                  header?.aditionalInfo ?? '',
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.start,
                ),
              ],
            ),

          SizedBox(height: sizedBoxHeight),

          //Coluna das informações
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label.hasWeight)
                Text(
                  PdfProvider.showWeight(label),
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
              SizedBox(height: sizedBoxHeight),

              if (label.hasPrice)
                Text(
                  PdfProvider.showPrice(label),
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
              SizedBox(height: (sizedBoxHeight! + 1)),

              if (label.hasFab)
                Text(
                  'Fabricação: _____/_____/______',
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
              SizedBox(height: sizedBoxHeight),

              if (label.hasExpDate)
                Text(
                  'Validade: 02 meses (sob congelamento)',
                  style: const TextStyle(fontSize: 13),
                  textAlign: TextAlign.start,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
