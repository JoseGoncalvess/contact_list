import 'dart:developer';

import 'package:flutter/material.dart';

import '../../controllers/share_prefs.dart';
import '../../models/contact_model.dart';
import '../widgets/customfild.dart';

class NewContact extends StatefulWidget {
  const NewContact({super.key});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Novo Contato',
          style: TextStyle(
              fontSize: height * 0.026,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.34,
                color: Colors.greenAccent.withOpacity(0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: height * 0.1,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.6,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.07,
                    ),
                    Customfild(
                      controller: nameController,
                      label: "Nome",
                    ),
                    Customfild(
                      controller: nameController,
                      label: "Numero",
                    ),
                    Customfild(
                      controller: nameController,
                      label: "E-mail",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SharePrefs().saveEvento(
            key: keylist,
            contato: ContactModel(
                name: nameController.text,
                email: emailController.text,
                number: numberController.text,
                image: ''),
          );
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}