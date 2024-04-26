import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:workhub_web/src/controllers/auth/auth_controller.dart';
import '../../../controllers/user/user_controller.dart';
import '../../../models/user_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    Key? key,
    required this.item,
    required this.id,
  }) : super(key: key);

  final dynamic item;
  final String id;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController txtNome;
  late TextEditingController txtContato;

  final celFormat = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  @override
  void initState() {
    super.initState();
    txtNome = TextEditingController(text: widget.item['nome']);
    txtContato = TextEditingController(text: widget.item['contato']);
  }

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
            // Conteúdo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titulo
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Teste',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: txtNome,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.business),
                      labelText: 'Nome',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Campo de email
                  TextFormField(
                    autofocus: true,
                    inputFormatters: [celFormat],
                    controller: txtContato,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      labelText: 'Contato',
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Confirmar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      String novoNome = txtNome.text;
                      String novoContato = txtContato.text;

                      if (novoContato.isNotEmpty && novoContato.length >= 9) {
                        var e = UsuarioModel(
                          AuthController().idUsuario(),
                          novoNome,
                          novoContato,
                          widget.item['plano'],
                          widget.item['planoDesk'],
                          widget.item['planoMeet'],
                          '',
                        );

                        UserController().atualizar(context, widget.id, e);
                        Navigator.of(context)
                            .pop({'success': true, 'novoContato': novoContato});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[300],
                            content: const Text(
                                'Preencha todos os campos obrigatórios.'),
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

            // Botão para fechar
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
