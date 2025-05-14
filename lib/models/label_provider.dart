import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:label_craft/data/mock_labels.dart';
import 'package:label_craft/models/label.dart';
import 'package:http/http.dart' as http;
import 'package:label_craft/utils/constants.dart';

class LabelProvider with ChangeNotifier {
  List<Label> _labels = mockLabels;

  List<Label> get labels => [..._labels];

  //Método para carregar as etiquetas do banco
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
          name: labelData['name'] ?? '',
          hasWeight: labelData['hasWeight'] ?? false,
          weight: labelData['weight'] ?? '',
          hasPrice: labelData['hasPrice'] ?? false,
          price: labelData['price'] ?? '',
          hasFab: labelData['hasFab'] ?? false,
          hasExpDate: labelData['hasExpDate'] ?? false,
        ),
      );
    });
    notifyListeners();
  }

  //Método para salvar etiqueta a partir das informações do formulário
  //Dispara o método de salvar ou editar no banco de dados
  Future<void> saveLabel(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final label = Label(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      hasWeight: data['hasWeight'] as bool,
      weight: data['weight'] as String,
      hasPrice: data['hasPrice'] as bool,
      price: data['price'] as String,
      hasFab: data['hasFab'] as bool,
      hasExpDate: data['hasExpDate'] as bool,
    );

    if (hasId == true) {
      return updateLabel(label);
    } else {
      return addLabel(label);
    }
  }

  //Método para salvar etiqueta no banco e localmente
  Future<void> addLabel(Label label) async {
    final response = await http.post(
      Uri.parse('${Constants.LABEL_BASE_URL}.json'),
      body: jsonEncode({
        "name": label.name,
        "hasWeight": label.hasWeight,
        "weight": label.weight,
        "hasPrice": label.hasPrice,
        "price": label.price,
        "hasFab": label.hasFab,
        "hasExpDate": label.hasExpDate,
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _labels.add(
      Label(
        id: id,
        name: label.name,
        hasWeight: label.hasWeight,
        weight: label.weight,
        hasPrice: label.hasPrice,
        price: label.price,
        hasFab: label.hasFab,
        hasExpDate: label.hasExpDate,
      ),
    );
    notifyListeners();
  }

  //Método para editar etiqueta no banco e localmente
  Future<void> updateLabel(Label label) async {
    int index = _labels.indexWhere((i) => i.id == label.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.LABEL_BASE_URL}/${label.id}.json'),
        body: jsonEncode({
          "name": label.name,
          "hasWeight": label.hasWeight,
          "weight": label.weight,
          "hasPrice": label.hasPrice,
          "price": label.price,
          "hasFab": label.hasFab,
          "hasExpDate": label.hasExpDate,
        }),
      );
      _labels[index] = label;
      notifyListeners();
    }
  }

  //Método para remover etiqueta do banco e localmente
  void removeLabel(Label label) async {
    int index = _labels.indexWhere((i) => i.id == label.id);
    if (index >= 0) {
      final label = _labels[index];

      _labels.remove(label);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.LABEL_BASE_URL}/${label.id}.json'),
      );

      //Se der erro no servidor, o produto é reinserido
      if (response.statusCode >= 400) {
        _labels.insert(index, label);
        notifyListeners();
      }
    }
  }
}
