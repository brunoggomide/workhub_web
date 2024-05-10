import 'dart:convert';
import 'package:http/http.dart' as http;

Future getAddress(cep) async {
  return http
      .get(
    Uri.parse('https://viacep.com.br/ws/$cep/json/'),
  )
      .then((response) {
    return json.decode(response.body);
  });
}
