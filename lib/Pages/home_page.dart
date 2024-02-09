
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/endereco_model.dart';
import 'package:flutter_application_1/repositories/cep__repository_impl.dart';
import 'package:flutter_application_1/repositories/cep_repository.dart';


class HomePage extends StatefulWidget {

  const HomePage({ super.key, required String title });

  State<HomePage> createState () => _HomePageState();
  
}

class _HomePageState extends State<HomePage> { 
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;
  bool loarding = false;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar CEP'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
            children: [
              TextFormField(
              controller: cepEC,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'CEP obrigatorio';
                }
                return null;
               },
              ),
              ElevatedButton(
                onPressed: () async {
                  final valid = formKey.currentState?.validate() ?? false;
                  if(valid){
                  try {
                    setState(() {
                      loarding = true;
                    });
                    final endereco = await cepRepository.getCep(cepEC.text);
                    loarding = false;
                    setState(() {
                      enderecoModel = endereco;
                    });
                  } catch (e) {
                    setState(() {
                      loarding = false;
                      enderecoModel = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Erro ao buscar endereço'))
                    );
                  }
                }
              },
              child: const Text('Buscar')
              ),
              Visibility(
                visible: loarding,
                child: const CircularProgressIndicator(),
              ),
              Visibility(
               visible: enderecoModel != null,
               child:Text(
                '${enderecoModel?.logradouro} ${enderecoModel?.complemento} ${enderecoModel?.cep}', 
              )),
            ],
          ),
        ),
      ),
    );
  }
}