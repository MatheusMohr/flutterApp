import 'package:app_produtos/controllers/loja_controller.dart';
import 'package:app_produtos/services/loja_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/menu_component.dart';

class LojaListScreen extends GetView<LojaController> {
  const LojaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LojaController(service: LojaService()));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Lista de Lojas"),
      ),
      drawer: MenuComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.add),
      ),
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

        if (controller.lojas.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.store_mall_directory_outlined, color: Colors.grey, size: 50),
                SizedBox(height: 10),
                Text('Nenhuma loja cadastrada'),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.listar(),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.lojas.length,
            itemBuilder: (context, index) {
              final loja = controller.lojas[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  leading: const CircleAvatar(
                    child: Icon(Icons.store),
                  ),
                  title: Text(
                    loja.nome,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(loja.endereco),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.inventory_2_outlined, color: Colors.blueAccent),
                        tooltip: 'Ver Produtos',
                        onPressed: () {
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        tooltip: 'Remover Loja',
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Confirmar Exclusão",
                            middleText: "Você tem certeza que deseja remover a loja '${loja.nome}'?",
                            textConfirm: "Sim, Remover",
                            textCancel: "Cancelar",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back();
                              controller.removerLoja(loja.id!);
                            },
                          );
                        },
                      ),
                    ],
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