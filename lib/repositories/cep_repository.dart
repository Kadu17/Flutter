import 'package:flutter_application_1/models/endereco_model.dart';

abstract class CepRepository{

  Future<EnderecoModel> getCep(String cep);

}