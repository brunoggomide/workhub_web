import 'package:flutter/material.dart';

import '../../../controllers/auth/auth_controller.dart';

class EditPassword extends StatefulWidget {
  EditPassword({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;
  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final senhaAtualController = TextEditingController();

  final novaSenhaController = TextEditingController();

  final novaSenhaController2 = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 600,
          minHeight: 200,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Editar senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: isObscure,
                    controller: senhaAtualController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: 'Digite sua senha',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: isObscure,
                    controller: novaSenhaController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: 'Nova senha',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: isObscure,
                    controller: novaSenhaController2,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: 'Confirme a nova senha',
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      if (novaSenhaController.text ==
                          novaSenhaController2.text) {
                        AuthController().alterarSenha(
                          context,
                          widget.email,
                          senhaAtualController.text,
                          novaSenhaController.text,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[300],
                            content: const Text('Senhas diferente.'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Editar',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
