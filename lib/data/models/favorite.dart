import 'package:flutter/foundation.dart';
import 'package:pet_adoption_app/data/models/pet.dart';



class FavoritePetsModel extends ChangeNotifier {
  final List<Pet> _favoriteMeals = [];

  List<Pet> get favoriteMeals => _favoriteMeals;

  void toggleFavorite(Pet pet) {
    if (_favoriteMeals.contains(pet)) {
      _favoriteMeals.remove(pet);
    } else {
      _favoriteMeals.add(pet);
    }
    notifyListeners();
  }
}
