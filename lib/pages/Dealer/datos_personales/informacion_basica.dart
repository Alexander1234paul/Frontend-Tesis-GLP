import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class InformacionBasicaScreen extends StatefulWidget {
  const InformacionBasicaScreen({Key? key}) : super(key: key);

  @override
  _InformacionBasicaScreenState createState() =>
      _InformacionBasicaScreenState();
}

class _InformacionBasicaScreenState extends State<InformacionBasicaScreen> {
  String _selectedImagePath = '';
  DateTime _selectedDate = DateTime.now();

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Foto de Perfil'),
        backgroundColor: Color(0xFFA72138),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_selectedImagePath.isNotEmpty)
                          CircleAvatar(
                            backgroundImage:
                                FileImage(File(_selectedImagePath)),
                            radius: 60,
                          )
                        else
                          CircleAvatar(
                            radius: 45,
                            //child: Icon(Icons.person),
                            backgroundColor: Color.fromARGB(240, 114, 117, 115),
                            backgroundImage: AssetImage('assets/usuario.png'),
                          ),
                        SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Implementa la lógica para el último botón
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side:
                                BorderSide(color: Colors.red[900]!, width: 1.5),
                            // minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Colors.red[900]!,
                          ),
                          label: Text(
                            'Añadir',
                            style: TextStyle(
                              color: Colors.red[900]!,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Nombre',
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Apellido',
                          ),
                        ),
                        SizedBox(height: 20),
                        //Text('Fecha de Nacimiento:'),
                        Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                        SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: _selectDate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side:
                                BorderSide(color: Colors.red[900]!, width: 1.5),
                            minimumSize: Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(
                            Icons.date_range_sharp,
                            color: Colors.red[900]!,
                          ),
                          label: Text(
                            'Fecha de nacimiento',
                            style: TextStyle(
                              color: Colors.red[900]!,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Correo',
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Implementa la lógica para el último botón
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side:
                                BorderSide(color: Colors.red[900]!, width: 1.5),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          icon: Icon(
                            Icons.save,
                            color: Colors.red[900]!,
                          ),
                          label: Text(
                            'Guardar',
                            style: TextStyle(
                              color: Colors.red[900]!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
