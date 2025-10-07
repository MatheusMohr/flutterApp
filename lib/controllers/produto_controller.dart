import 'package:app_produtos/models/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:app_produtos/services/produto_service.dart';
import 'package:get/get.dart';

class ProdutoController extends GetxController{
  final ProdutoService service;

  ProdutoController({required this.service});

  final produtos = <ProdutoModel>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit(){
    super.onInit();
    listar();
  }

  Future<void> listar() async{
    try{
      isLoading.value = true;
      error.value = '';
      produtos.assignAll(await service.listar());
    }catch(e){
      error.value = e.toString();
    } finally{
      isLoading.value = false;
    }
  }
  Future<void> removerProduto(String id) async {
    try {
      await service.remover(id);
      produtos.removeWhere((produto) => produto.id == id);

      Get.snackbar(
        'Sucesso!',
        'Produto removido com sucesso.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível remover o produto. Tente novamente.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      error.value = 'Erro ao remover produto: $e';
    }
  }
}