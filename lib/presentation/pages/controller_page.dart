import 'package:flutter/material.dart';
import 'package:pet_adoption_app/presentation/pages/adopted_page.dart';
import 'package:pet_adoption_app/presentation/pages/pets_page.dart';

import 'favorite_page.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          PetsPage(),
          FavoritePage(),
          AdoptPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pets,
              color: Colors.black54,
            ),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.black54,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Colors.black54,
            ),
            label: 'Adopted',
          )
        ],
      ),
    );
  }
}
