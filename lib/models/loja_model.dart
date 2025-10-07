import 'produto_model.dart';

class LojaModel {
  final String? id;
  final String nome;
  final String endereco;
  final String? descricao;
  final String cnpj;
  final List<ProdutoModel> produtos;

  LojaModel({
    this.id,
    required this.nome,
    required this.endereco,
    required this.cnpj,
    this.descricao,
    this.produtos = const [],
  });

  factory LojaModel.fromJson(Map<String, dynamic> json) {
    var produtosList = <ProdutoModel>[];
    if (json['produtos'] != null && json['produtos'] is List) {
      produtosList = (json['produtos'] as List)
          .map((item) => ProdutoModel.fromJson(item))
          .toList();
    }

    return LojaModel(
      id: json['id']?.toString(),
      nome: json['nome'] ?? '',
      endereco: json['endereco'] ?? '',
      descricao: json['descricao'] ?? '',
      cnpj: json['cnpj'] ?? '',
      produtos: produtosList,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'endereco': endereco,
    'cnpj': cnpj,
    'descricao': descricao,
    'produtos': produtos.map((produto) => produto.toJson()).toList(),
  };
}