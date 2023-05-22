import 'package:flutter/material.dart';

class HomeDistribuidor extends StatefulWidget {
  const HomeDistribuidor({Key? key}) : super(key: key);

  @override
  State<HomeDistribuidor> createState() => _HomeDistribuidorState();
}

class _HomeDistribuidorState extends State<HomeDistribuidor> {
  bool isLeftSelected = true;

  void toggleSelection() {
    setState(() {
      isLeftSelected = !isLeftSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 188, 185, 179),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Acción al presionar el botón de menú (izquierda)
          },
        ),
        centerTitle: true,
        title: Container(
          height: 23,
          width: 195,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: toggleSelection,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: isLeftSelected ? 0 : 75,
                  right: isLeftSelected ? 75 : 0,
                  child: Container(
                    // padding: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: isLeftSelected ? Colors.red : Color.fromARGB(255, 105, 211, 109),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        isLeftSelected ? 'No disponible' : 'Disponible',
                        style: TextStyle(
                          color: isLeftSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Text('data'),
    bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.support),
              label: 'Soporte',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: 0, // Índice del botón seleccionado actualmente
          onTap: (index) {
            // Acción al hacer clic en un botón del bottomNavigationBar
            print('Button $index tapped');
          },
        ),
      
    );
  }
}
