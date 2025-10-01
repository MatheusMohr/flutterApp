import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/produto_model.dart';
const String baseUrl = 'http://localhost:8080/produtos';
class ProdutoService{

    final http.Client _client;
    ProdutoService({http.Client? client}) :
        _client = client ?? http.Client();

    Future<List<ProdutoModel>> listar() async{
      final res = await _client.get(Uri.parse(baseUrl + '/listar'));
      if(res.statusCode >= 200 && res.statusCode < 300 ){
            final data = jsonDecode(res.body) as List;
            return data.map((e) => ProdutoModel.fromJson(e)).toList();
      }
      throw Exception('Erro ao listar produtos: ${res.statusCode}');
    }




}