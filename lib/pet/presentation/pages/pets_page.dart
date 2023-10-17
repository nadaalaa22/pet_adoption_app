import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_adoption_app/pet/presentation/bloc/pet_bloc.dart';
import 'package:pet_adoption_app/user/data/datasource/local_datasource/user_local_datasource.dart';
import 'package:pet_adoption_app/user/presentation/pages/form_page.dart';

import '../../data/models/pet.dart';
import '../widgets/pet_grid_tile.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({Key? key}) : super(key: key);

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  var titleControl = TextEditingController();

  var idControl = TextEditingController();

  Future<void> _showAddCategoryBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleControl,
                decoration: const InputDecoration(
                  label: Text('Pet Name'),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              TextFormField(
                controller: idControl,
                decoration: const InputDecoration(
                  label: Text(' id'),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Get the category name from the TextFormField
                  String petName = titleControl.text;
                  if (petName.isNotEmpty) {
                    var pet = Pet(
                        id: idControl.text,
                        name: titleControl.text,
                        imageUrl: imageFile != null ? imageFile!.path : '');
                    context.read<PetBloc>().add(SetPetEvent(pet: pet));
                    // await PetDataImp().setPet(pet);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  File? imageFile;

  Future<File?> getImage(ImageSource source) async {
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      return File(xFile.path);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PetBloc>().add(GetPetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          TextButton(
              onPressed: () {
                UserDataImp().logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const FormPage()));
              },
              child: const Text(
                'Log out',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ))
        ],
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          print(state);
          if (state is PetLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is PetLoadedState) {
            print(state.pets.length);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) =>
                  PetGridTile(
                    pet: state.pets[index],
                  ),
              itemCount: state.pets.length,
            );
          }
          return SizedBox(
            height: 10,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getImage(ImageSource.gallery).then((value) =>
              setState(() {
                imageFile = value;
              }));
          await _showAddCategoryBottomSheet(context);
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
