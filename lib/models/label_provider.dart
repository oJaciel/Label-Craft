import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:label_craft/data/mock_labels.dart';
import 'package:label_craft/models/label.dart';
import 'package:http/http.dart' as http;
import 'package:label_craft/utils/constants.dart';

class LabelProvider with ChangeNotifier {
  List<Label> _labels = mockLabels;

  List<Label> get labels => [..._labels];

  Future<void> loadLabels() async {
    _labels.clear();

    final response = await http.get(
      Uri.parse('${Constants.LABEL_BASE_URL}.json'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((labelId, labelData) {
      _labels.add(
        Label(
          id: labelId,
          name: labelData['name'],
          hasWeight: labelData['hasWeight'],
          weight: labelData['price'] ?? '',
          hasPrice: labelData['hasPrice'],
          price: labelData['price'] ?? '',
          hasFab: labelData['hasFab'],
          hasExpDate: labelData['hasExpDate'],
        ),
      );
    });
    notifyListeners();
  }
}
