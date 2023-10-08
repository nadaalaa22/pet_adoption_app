import 'package:flutter/material.dart';
import 'package:pet_adoption_app/data/datasource/local_datasource/pet_local_datasource.dart';

import '../../data/datasource/pets_data.dart';

import '../widgets/pet_grid_tile.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Favorite',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: PetDataImp().getFavoritePets(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, i) {
                return PetGridTile(
                  pet: snapshot.data![i],
                  onTapCallback: () {
                    setState(() {});
                  },
                );
              },
            );
          }),
    );
  }
}
