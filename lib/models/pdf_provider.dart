import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:label_craft/models/label.dart';
import 'package:printing/printing.dart';

class PdfProvider {
  static Future<void> generateLabelPdf(Label label) async {
    final pdf = pw.Document();

    // 👇 Carregando a imagem dos assets
    final Uint8List imageData = await rootBundle
        .load('images/label_logo.png')
        .then((data) => data.buffer.asUint8List());
    final pw.ImageProvider image = pw.MemoryImage(imageData);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(24, (index) {
                return pw.Container(
                  width: (PdfPageFormat.a4.availableWidth - 16) / 4,
                  padding: const pw.EdgeInsets.all(4),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        
                        children: [
                          pw.Image(
                            image,
                            width: 92,
                            height: 42,
                            alignment: pw.Alignment.center,
                          ),
                          pw.Text(
                            'CNPJ: 08.601.406/0001-31',
                            style: pw.TextStyle(fontSize: 6),
                            textAlign: pw.TextAlign.start
                          ),
                          pw.Text(
                            'Fone: (54) 9 9957-5514 / 9 9616-8921',
                            style: pw.TextStyle(fontSize: 6),
                            textAlign: pw.TextAlign.start
                          ),
                        ],
                      ),

                      pw.SizedBox(height: 4),
                      pw.Text(
                        label.hasWeight
                            ? 'Peso: ${label.weight}'
                            : 'Peso: ______',
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                      pw.Text(
                        label.hasPrice
                            ? 'Preço: R\$ ${label.price}'
                            : 'Preço: R\$ ______',
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                      if (label.hasFab)
                        pw.Text(
                          'Fabricação: ____/____/_____',
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      if (label.hasExpDate)
                        pw.Text(
                          'Validade: 02 meses (sob congelamento)',
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
