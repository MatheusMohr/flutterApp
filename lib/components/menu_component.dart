import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
                child: Text("Menu Principal",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )
            ),
            ListTile(
              // Adicionando um ícone no início do item
              leading: const Icon(Icons.home_outlined),
              title: const Text("Página Inícial"),
              onTap: () {
                // Fecha o menu antes de navegar
                Navigator.pop(context);
                Get.toNamed('/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: const Text("Listar Produtos"),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/produtos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.store_mall_directory_outlined),
              title: const Text("Listar Lojas"),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/lojas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.store_mall_directory_outlined),
              title: const Text("Cadastrar Lojas"),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/loja-form');
              },
            ),
          ],
        ),
      );
  }
}