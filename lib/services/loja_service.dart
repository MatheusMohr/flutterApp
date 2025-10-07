// ARQUIVO: lib/services/loja_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/loja_model.dart';

const String baseUrl = 'http://localhost:8080/loja';

class LojaService {
  final http.Client _client;

  LojaService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<LojaModel>> listar() async {
    final response = await _client.get(Uri.parse('$baseUrl/listar'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((json) => LojaModel.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar as lojas');
    }
  }

  Future<LojaModel> salvar(LojaModel loja) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/salvar'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(loja.toJson()),
    );
    if (response.statusCode == 201) {
      return LojaModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Falha ao salvar a loja: ${response.body}');
    }
  }

  Future<LojaModel> editar(String id, LojaModel loja) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/editar/$id'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(loja.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return LojaModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Falha ao editar a loja: ${response.body}');
    }
  }

  Future<void> remover(String id) async {
    final response = await _client.post(Uri.parse('$baseUrl/apagar/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao remover a loja: ${response.body}');
    }
  }
}