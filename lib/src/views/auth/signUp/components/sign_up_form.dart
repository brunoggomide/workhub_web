import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:workhub_web/src/views/plans/planPage.dart';

import '../../../../controllers/auth/auth_controller.dart';
import '../../../utils/env.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtDocumento = TextEditingController();
  var txtContato = TextEditingController();
  var namePlan;
  var meetQtd;
  var deskQtd;
  bool isObscure = true;

  final celFormat = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  final cnpjFormat = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  @override
  void initState() {
    super.initState();
    PlanPage.getPlanName().then((name) {
      setState(() {
        namePlan = name;
      });
    });
    PlanPage.getMeetingRooms().then((meet) {
      setState(() {
        meetQtd = meet;
      });
    });
    PlanPage.getWorkPositions().then((desk) {
      setState(() {
        deskQtd = desk;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text(
            'Crie seu cadastro para acessar o Work-Hub',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: txtNome,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Razão Social",
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: txtEmail,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "E-mail",
                prefixIcon: Icon(Icons.email),
              ),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: txtDocumento,
              inputFormatters: [cnpjFormat],
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "CNPJ",
                prefixIcon: Icon(Icons.business_center),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: txtContato,
              inputFormatters: [celFormat],
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Contato",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              String nome = txtNome.text;
              String email = txtEmail.text;
              String senha = txtSenha.text;
              String documento = txtDocumento.text;
              String contato = txtContato.text;

              if (nome.isNotEmpty &&
                  email.isNotEmpty &&
                  senha.isNotEmpty &&
                  documento.length >= 18 &&
                  contato.length >= 13) {
                AuthController().criarConta(context, nome, email, senha,
                    documento, contato, namePlan, deskQtd, meetQtd);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red[300],
                    content: const Text(
                        'Preencha todos os campos obrigatórios corretamente.'),
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
              "Cadastrar".toUpperCase(),
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
