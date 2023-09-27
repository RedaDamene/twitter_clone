import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnexionPage extends StatelessWidget {
  const ConnexionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormLoginWidget();
  }
}

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final textControllerUsername = TextEditingController();
  final textControllerPassword = TextEditingController();
  bool isRememberMe = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: textControllerUsername,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Identifiant",
                    ),
                    validator: (value){
                      if(value == null || value.length < 3){
                        return "L'identifiant doit avoir au moins 3 caractères ! ";
                      };

                      if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                        return "L'idenfiant n'est pas valide !";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: textControllerPassword,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (value){
                      if(value == null || value.length < 8){
                        return "L'identifiant doit avoir au moins 8 caractères ! ";
                      };

                      if(!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value)){
                        return "L'idenfiant n'est pas valide !";
                      }

                      return null;
                    },
                  ),
                  SwitchListTile(value: isRememberMe,
                    title: const Text("Mémoriser mes informations"),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isEnabled){
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  ElevatedButton(onPressed: () {
                    if(_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Connecté : ${textControllerUsername.text}"))
                      );
                      context.go("/home/${textControllerUsername.text}");
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(("Erreur de connexion")))
                      );
                    }
                  },
                      child: const Text("Connexion")),
                  ElevatedButton(onPressed: () {
                    if(_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Connecté : ${textControllerUsername.text}"))
                      );
                      context.go("/home", extra: textControllerUsername.text);
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Erreur de connexion"))
                      );
                    }
                  },
                      child: const Text("Connexion Extra"))
                ],
              ),
            )),
      ),
    );
  }
}