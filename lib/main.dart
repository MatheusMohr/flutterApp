import 'package:app_produtos/screens/home_screen.dart';
import 'package:app_produtos/screens/produto_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Produto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //rota inicial
      initialRoute: '/',
      // lista das rotas e paginas
      getPages: [
        GetPage(name: '/', page: () => MyHomePage(title: 'home')),
        GetPage(name: '/produtos', page: () => ProdutoListScreen())
      ],
    );
  }
}

