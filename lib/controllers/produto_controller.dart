import 'package:app_produtos/models/produto_model.dart';
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

}