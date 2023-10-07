import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/pet.dart';

abstract class PetData {
  ///add [pet] data to [sharedPreference]
  ///
  /// throw an error
  Future<void> setPet(Pet pet);

  ///get [all] [pet] from  [sharedPreference]
  ///
  /// throw an error
  Future<List<Pet>> getPets();

  /// toggle between [Favorite] and [unFavorite]
  ///
  /// throw an error
  Future<void> togglePetFavorite(String petID);

  ///get [all] [ favorite ] [pet] from  [sharedPreference]
  ///
  /// throw an error
  Future<List<Pet>> getFavoritePets();

  ///get [all] [ Adopted ] [pet] from  [sharedPreference]
  ///
  /// throw an error
  Future<List<Pet>> getAdoptedPets();

  Future<void> togglePetAdopted(String petID);
}

const String petsKey = 'PetsList';

class PetDataImp implements PetData {
  @override
  Future<void> setPet(Pet pet) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String petJson = jsonEncode(pet.toMap());
    List<String> petsJson = prefs.getStringList(petsKey) ?? [];
    petsJson.add(petJson);
    await prefs.setStringList(petsKey, petsJson);
  }

  @override
  Future<List<Pet>> getPets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> petsJson = prefs.getStringList(petsKey) ?? [];
    List<Pet> pets = [];
    for (int i = 0; i < petsJson.length; i++) {
      final petJson = petsJson[i];
      final Map petMap = jsonDecode(petJson);
      Pet pet = Pet.fromMap(petMap);
      pets.add(pet);
    }

    return pets;
  }

  @override
  Future<void> togglePetFavorite(String petID) async {
    final pets = await getPets();
    Pet? pet;
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id == petID) {
        pet = pets[i];
      }
    }
    if (pet == null) throw Exception('pet not found');

    pet.isFavorite = !pet.isFavorite;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(petsKey);
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id != petID) {
        await setPet(pets[i]);
      } else {
        await setPet(pet);
      }
    }
  }

  @override
  Future<List<Pet>> getFavoritePets() async {
    final pets = await getPets();
    List<Pet> favoritePets = [];
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].isFavorite == true) {
        favoritePets.add(pets[i]);
      }
    }
    return favoritePets;
  }

  @override
  Future<void> togglePetAdopted(String petID) async {
    final pets = await getPets();
    Pet? pet;
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id == petID) {
        pet = pets[i];
      }
    }
    if (pet == null) throw Exception('pet not found');

    pet.isAdopt = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(petsKey);
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].id != petID) {
        await setPet(pets[i]);
      } else {
        await setPet(pet);
      }
    }
  }

  @override
  Future<List<Pet>> getAdoptedPets() async {
    final pets = await getPets();
    List<Pet> adoptedPets = [];
    for (int i = 0; i < pets.length; i++) {
      if (pets[i].isAdopt == true) {
        adoptedPets.add(pets[i]);
      }
    }
    return adoptedPets;
  }
}
