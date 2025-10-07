// ARQUIVO: lib/screens/loja_form_screen.dart

import 'package:app_produtos/controllers/loja_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class LojaFormScreen extends GetView<LojaController> {
  const LojaFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEditing = controller.nomeController.text.isNotEmpty;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Loja' : 'Nova Loja'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: FadeInUp(
          duration: const Duration(milliseconds: 500),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildTextFormField(
                            controller: controller.nomeController,
                            labelText: 'Nome da Loja',
                            icon: Icons.store_outlined),
                        const SizedBox(height: 20),
                        _buildTextFormField(
                            controller: controller.cnpjController,
                            labelText: 'CNPJ',
                            icon: Icons.business_center_outlined),
                        const SizedBox(height: 20),
                        _buildTextFormField(
                            controller: controller.enderecoController,
                            labelText: 'Endereço',
                            icon: Icons.location_on_outlined),
                        const SizedBox(height: 20),
                        _buildTextFormField(
                            controller: controller.descricaoController,
                            labelText: 'Descrição',
                            icon: Icons.description_outlined,
                            maxLines: 3),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : _buildSubmitButton(_formKey);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      {required TextEditingController controller,
        required String labelText,
        required IconData icon,
        int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      validator: (value) =>
      (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
    );
  }

  Widget _buildSubmitButton(GlobalKey<FormState> formKey) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          colors: [Colors.pink.shade300, Colors.pink.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.pink.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4)),
        ],
      ),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save_alt_outlined, color: Colors.white),
        label: const Text('SALVAR',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            controller.salvarOuEditar();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}