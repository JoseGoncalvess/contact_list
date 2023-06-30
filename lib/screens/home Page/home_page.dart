import 'dart:io';

import 'package:contact_list/controllers/homecontroller.dart';
import 'package:contact_list/screens/editing%20contact/editing_contact.dart';
import 'package:contact_list/screens/widgets/show_dailog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../new_contatact/new_contact.dart';
import '../widgets/app_custom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Homecontroller();

  @override
  void initState() {
    super.initState();
    _controller.getcontacts();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            const AppCustomBar(),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, value, child) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        var data = value;
                        return Dismissible(
                          key: Key(index.toString()),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            return await ShowDailog().showdailogg(
                                context: context,
                                contact: data[index].name,
                                page: MaterialPageRoute(
                                  builder: (context) => EditingContact(
                                      index: index,
                                      image: XFile(data[index].image),
                                      name: data[index].name,
                                      number: data[index].number,
                                      email: data[index].email),
                                ),
                                delet: () {
                                  _controller.deletcontatc(index: index);
                                });
                          },
                          background: Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.centerRight,
                            color: Colors.green[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.perm_contact_calendar_rounded,
                                color: Colors.white,
                                size: width * 0.1,
                              ),
                            ),
                          ),
                          onDismissed: (direction) =>
                              _controller.deletcontatc(index: index),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              onBackgroundImageError: (exception, stackTrace) =>
                                  Image.asset('assets/user.png'),
                              backgroundImage: FileImage(
                                File(data[index].image),
                                scale: 2,
                              ),
                            ),
                            title: Text(
                              data[index].name,
                              style: TextStyle(
                                  color: Colors.green[800],
                                  fontSize: height * 0.022,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(data[index].number,
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: height * 0.022,
                                    fontWeight: FontWeight.w400)),
                            focusColor: Colors.greenAccent,
                            trailing: const Icon(Icons.call),
                          ),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewContact(),
                ));
          },
          child: const Icon(
            Icons.add_call,
            color: Colors.white,
          )),
    );
  }
}
