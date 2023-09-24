import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/favorite.dart';
import '../widgets/pet_grid_tile.dart';
class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('FAVORITE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon: Icon( Icons.arrow_back),
        ),
      ),
      body: Consumer<FavoritePetsModel>(
        builder: (context, favoriteModel, child) {
          final favoriteMeals = favoriteModel.favoriteMeals;
          return ListView.builder(
            itemCount: favoriteMeals.length,
            itemBuilder: (context, index) {
              final meal = favoriteMeals[index];
              return PetGridTile(
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
