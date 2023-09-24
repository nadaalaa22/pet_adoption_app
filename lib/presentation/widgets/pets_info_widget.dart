import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../data/models/favorite.dart';
import '../../data/models/pet.dart';

class PetInformation extends StatelessWidget {
  final Pet petInfo;
  PetInformation({required  this.petInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(' ID #  ${petInfo.id}  ${petInfo.name}',style: TextStyle(color: Colors.white), ),
        actions: [
          Consumer<FavoritePetsModel>(
            builder: (context, favoriteModel, child) {
              final isFavorite = favoriteModel.favoriteMeals.contains(petInfo);
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  final favoriteModel = Provider.of<FavoritePetsModel>(context, listen: false);
                  favoriteModel.toggleFavorite(petInfo);
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(image: AssetImage(petInfo.imageUrl)),
          Text('ID : ${petInfo.id}',style: TextStyle(color: Colors.purple,fontSize: 24),),
          Text('Name : ${petInfo.name}',style: TextStyle(color: Colors.purple,fontSize: 24),),
          Text('Tips :  ',style: TextStyle(color: Colors.black,fontSize: 18),),
          Text('Tips :  ',style: TextStyle(color: Colors.black,fontSize: 18),),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){}, child: Text('Adopt',style: TextStyle(color: Colors.white,fontSize: 24),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,

              ),
            ),
          ),
        ],
      ),
    );
  }
}
