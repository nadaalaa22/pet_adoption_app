import 'package:flutter/material.dart';

import '../../data/datasource/local_datasource/pet_local_datasource.dart';
import '../widgets/pet_grid_tile.dart';

class AdoptPage extends StatefulWidget {
  const AdoptPage({Key? key}) : super(key: key);

  @override
  State<AdoptPage> createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          'Adopted',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: PetDataImp().getAdoptedPets(),
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
