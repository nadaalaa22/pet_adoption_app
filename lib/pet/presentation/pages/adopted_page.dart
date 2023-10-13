import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/pet/presentation/bloc/pet_bloc.dart';

import '../widgets/pet_grid_tile.dart';

class AdoptPage extends StatelessWidget {
  const AdoptPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Adopted',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
      ),
      body: BlocBuilder<PetBloc, PetState>(builder: (context, state) {
        return Column(
          children: [
            if (state is PetLoadingState) const CircularProgressIndicator(),
            if (state is PetLoadedState)
              Expanded(
                child: ListView.builder(
                  itemCount:
                      state.pets.where((element) => element.isAdopt).length,
                  itemBuilder: (_, i) {
                    return PetGridTile(
                      pet: state.pets
                          .where((element) => element.isAdopt)
                          .toList()[i],
                    );
                  },
                ),
              ),
          ],
        );
      }),
    );
  }
}
