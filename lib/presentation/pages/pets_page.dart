import 'package:flutter/material.dart';

import '../../data/datasource/pets_data.dart';
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


  void _showAddCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleControl,
                decoration: InputDecoration(
                  label: Text('Pet Name'),
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              TextFormField(
                controller: idControl,
                decoration: InputDecoration(
                  label: Text(' id'),
                  prefixIcon: Icon(Icons.title),
                ),
              ),

              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  // Get the category name from the TextFormField
                  String categoryName = titleControl.text;
                  if (categoryName.isNotEmpty) {
                    setState(() {
                      // Add the new category to the list
                      var pet =Pet(idControl.text,titleControl.text,'assets/images/dog.jpg');
                      pets.add(pet);
                    });
                    // Close the bottom sheet
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) =>PetGridTile(index: index,),
              itemCount: pets.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryBottomSheet(context);
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
