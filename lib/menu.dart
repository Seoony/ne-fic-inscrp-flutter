import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/pages/inicio.dart';
import 'package:ficha_inscripcion/pages/socio/socio_list.dart';

class Menu extends StatefulWidget {

  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const inicio();
      case 1:
        return const SocioList();
      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Negocios Electronicos"),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("NE"),
              accountEmail: Text("ne@unsa.pe"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              title: const Text("Inicio"),
              leading: const Icon(Icons.home),
              selected: (0 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text("Socios"),
              leading: const Icon(Icons.people),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
          ]
        )
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }
}
