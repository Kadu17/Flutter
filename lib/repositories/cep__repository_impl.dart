
// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter_application_1/models/endereco_model.dart';

import './cep_repository.dart';

import 'package:dio/dio.dart';

class CepRepositoryImpl implements CepRepository{
  @override
  Future<EnderecoModel> getCep(String cep) async {
    try{
      final result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      return EnderecoModel.fromMap(result.data);
    } on Error catch (e) {
      log('Erro ao buscar CEP', error: e);
      throw Exception('Erro ao buscar CEP');
    }
  }
    
}


  
