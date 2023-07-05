import 'package:flutter/material.dart';
//import 'package:menu_desplegable/widgets/input_text_login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(const DatosLicenciaScreen());

class DatosLicenciaScreen extends StatelessWidget {
  const DatosLicenciaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ingreso de datos online'),
          backgroundColor: Color(0xFFA72138),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  NumLicencia(),
                  FotoLicenciaFrente(),
                  FotoLicenciaAtras(),
                  FechaExpiracionLicencia(),
                  // DatePickerWidget(
                  //   onDateSelected: (value) {},
                  // ),
                  RoundBorderButton(
                    onPressed: () {},
                    label: 'Guardar',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumLicencia extends StatelessWidget {
  const NumLicencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        height: 130,
        width: 0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: 0.1),
            Text(
              'Numero de licencia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FotoLicenciaFrente extends StatelessWidget {
  const FotoLicenciaFrente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        height: 330,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text(
              'Licencia de conducir(Frente)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Transform.scale(
              scale: 0.7,
              child: Image.asset('assets/licen.png'),
            ),
            ElevatedButton.icon(
              onPressed: getImageFromCamera,
              icon: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
              label: const Text('Añadir',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.red[900]!, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            //const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class FotoLicenciaAtras extends StatelessWidget {
  const FotoLicenciaAtras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        height: 335,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text(
              'Licencia de conducir(parte trasera)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Transform.scale(
              scale: 0.7,
              child: Image.asset('assets/licen.png'),
            ),
            ElevatedButton.icon(
              onPressed: getImageFromCamera,
              icon: const Icon(Icons.add, color: Color.fromARGB(255, 0, 0, 0)),
              label: const Text('Añadir',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                //minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.red[900]!, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            //const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

//facha de expiración de la licencia
class FechaExpiracionLicencia extends StatelessWidget {
  const FechaExpiracionLicencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        height: 130,
        width: 0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: 0.1),
            Text(
              'Fecha de expiración de la licencia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundBorderButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double radius;
  final double borderWidth;
  final Color borderColor;
  final EdgeInsetsGeometry padding;

  const RoundBorderButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.radius = 20,
    this.borderWidth = 2,
    this.borderColor = const Color.fromARGB(255, 139, 32, 24),
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          elevation: 0,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: borderColor,
          ),
        ),
      ),
    );
  }
}

//metodo para seleccionar la imagen desde la galería
Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.getImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    // Aquí puedes procesar la imagen seleccionada
    // Por ejemplo, puedes mostrarla en un widget Image o subirla a un servidor
  }
}

//método para cargar una aimagen desde la camara
Future<File> getImageFromCamera() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.camera);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    print('No image selected.');
    throw Exception('Imagen no seleccionada');
  }
}

//clase para fecha
class DatePickerWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerWidget({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Fecha de expiración de la licencia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_selectedDate.toString()),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });

      widget.onDateSelected(selectedDate);
    }
  }
}
