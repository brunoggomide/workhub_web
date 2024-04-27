import 'package:flutter/material.dart';

import '../../../../controllers/auth/auth_controller.dart';
import '../../../utils/env.dart';
import '../../forgotPassword/forgotPassword.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text(
            'Faça login para acessar o Work-Hub',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: txtEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "E-mail",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: txtSenha,
              textInputAction: TextInputAction.done,
              obscureText: isObscure,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                ),
                hintText: "Senha",
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return ForgotPassword(email: txtEmail.text);
                    });
              },
              child: const Text(
                'Esqueceu a senha?',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              String email = txtEmail.text;
              String senha = txtSenha.text;

              if (email.isNotEmpty && senha.isNotEmpty) {
                AuthController().login(context, email, senha);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[300],
                    content:
                        const Text('Preencha todos os campos obrigatórios.'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: const Color.fromRGBO(177, 47, 47, 1),
            ),
            child: Text(
              "Login".toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 1,
                fontFamily: "Montserrat-Bold",
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
