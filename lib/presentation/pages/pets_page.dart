import 'package:flutter/material.dart';
import 'package:pet_adoption_app/data/datasource/local_datasource/user_local_datasource.dart';
import 'package:pet_adoption_app/presentation/pages/form_page.dart';
import '../../data/datasource/local_datasource/pet_local_datasource.dart';
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
              SizedBox(
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
                        imageUrl: 'assets/images/dog2.jpg');
                    await PetDataImp().getPets().then((value) => print(value));
                    await PetDataImp().setPet(pet);
                    await PetDataImp().getPets().then((value) => print(value));
                    // pets.add(pet);
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
        actions: [
          TextButton(
              onPressed: () {
                UserDataImp().logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FormPage()));
              },
              child: Text(
                'Log out',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: PetDataImp().getPets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          PetGridTile(
                        pet: snapshot.data![index],
                      ),
                      itemCount: snapshot.data!.length,
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddCategoryBottomSheet(context);
          setState(() {});
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
