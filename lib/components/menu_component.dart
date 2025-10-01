import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MenuComponent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Text("Produtos",
                  style: TextStyle(color: Colors.pink, fontSize: 20),
                )
            ),
            ListTile(
              title: Text("HOME"),
              onTap: () {
                // Navigator.pushNamed(context, '/',arguments: { });
                Get.toNamed('/');
              },
            ),
            ListTile(
              title: Text("Listar Produtos"),
              onTap: () {
                Get.toNamed('/produtos');
              },
            ),
          ],
        ),
      );
  }
}