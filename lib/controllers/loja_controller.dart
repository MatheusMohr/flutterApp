
import 'package:app_produtos/models/loja_model.dart';
import 'package:app_produtos/services/loja_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LojaController extends GetxController {
  final LojaService service;
  LojaController({required this.service});

  final lojas = <LojaModel>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

  late TextEditingController nomeController;
  late TextEditingController enderecoController;
  late TextEditingController cnpjController;
  late TextEditingController descricaoController;
  String? _editingId;

  @override
  void onInit() {
    super.onInit();
    nomeController = TextEditingController();
    enderecoController = TextEditingController();
    cnpjController = TextEditingController();
    descricaoController = TextEditingController();
    listar();
  }

  Future<void> listar() async {
    try {
      isLoading.value = true;
      error.value = '';
      lojas.assignAll(await service.listar());
    } catch (e) {
      error.value = "Erro ao carregar lojas: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> salvarOuEditar() async {
    final nome = nomeController.text;
    final endereco = enderecoController.text;
    final cnpj = cnpjController.text;
    final descricao = descricaoController.text;

    if (nome.isEmpty || endereco.isEmpty || cnpj.isEmpty) {
      Get.snackbar('Atenção', 'Todos os campos são obrigatórios.');
      return;
    }

    final loja = LojaModel(
        id: _editingId,
        nome: nome,
        endereco: endereco,
        cnpj: cnpj,
        descricao: descricao);

    try {
      isLoading.value = true;
      if (_editingId == null) {
        await service.salvar(loja);
      } else {
        await service.editar(_editingId!, loja);
      }
      Get.back();
      Get.snackbar('Sucesso!', 'Loja salva com sucesso!',
          backgroundColor: Colors.green);
      await listar();
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao salvar a loja: $e',
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void prepararNovaLoja() {
    _editingId = null;
    nomeController.clear();
    enderecoController.clear();
    cnpjController.clear();
    descricaoController.clear();
    Get.toNamed('/loja-form');
  }

  void carregarLojaParaEdicao(LojaModel loja) {
    _editingId = loja.id;
    nomeController.text = loja.nome;
    enderecoController.text = loja.endereco;
    cnpjController.text = loja.cnpj;
    descricaoController.text = loja.descricao!;
    Get.toNamed('/loja-form');
  }

  Future<void> removerLoja(String id) async {
    try {
      await service.remover(id);
      lojas.removeWhere((loja) => loja.id == id);
      Get.snackbar('Sucesso!', 'Loja removida com sucesso.',
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível remover a loja.',
          backgroundColor: Colors.red);
    }
  }

  @override
  void onClose() {
    nomeController.dispose();
    enderecoController.dispose();
    cnpjController.dispose();
    descricaoController.dispose();
    super.onClose();
  }
}