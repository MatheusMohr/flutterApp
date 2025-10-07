import 'package:app_produtos/controllers/produto_controller.dart';
import 'package:app_produtos/services/produto_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/menu_component.dart';

class ProdutoListScreen extends GetView<ProdutoController> {
  const ProdutoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProdutoController(service: ProdutoService()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Lista de Produtos"),
      ),
      drawer: MenuComponent(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 50),
                const SizedBox(height: 10),
                Text('Erro: ${controller.error}'),
              ],
            ),
          );
        }

        if (controller.produtos.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 50),
                SizedBox(height: 10),
                Text('Nenhum produto cadastrado'),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () => controller.listar(),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.produtos.length,
            itemBuilder: (context, index) {
              final produto = controller.produtos[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  leading: CircleAvatar(
                    child: Text(produto.nome![0]),
                  ),
                  title: Text(
                    produto.nome ?? 'Sem nome',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Preço: R\$ ${produto.preco?.toStringAsFixed(2) ?? '0.00'}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Confirmar Exclusão",
                        middleText: "Você tem certeza que deseja remover o produto '${produto.nome}'?",
                        textConfirm: "Sim, Remover",
                        textCancel: "Cancelar",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          Get.back();
                          controller.removerProduto(produto.id!);
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}