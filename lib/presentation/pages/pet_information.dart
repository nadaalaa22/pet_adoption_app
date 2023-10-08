import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_adoption_app/data/datasource/local_datasource/pet_local_datasource.dart';
import '../../data/models/pet.dart';

class PetInformation extends StatefulWidget {
  final Pet petInfo;

  PetInformation({required this.petInfo});

  @override
  State<PetInformation> createState() => _PetInformationState();
}

class _PetInformationState extends State<PetInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          ' ID #  ${widget.petInfo.id}  ${widget.petInfo.name}',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.petInfo.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              PetDataImp().togglePetFavorite(widget.petInfo.id);
              setState(() {
                widget.petInfo.isFavorite = !widget.petInfo.isFavorite;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(widget.petInfo.imageUrl)),
            Text(
              'ID : ${widget.petInfo.id}',
              style: TextStyle(color: Colors.purple, fontSize: 24),
            ),
            Text(
              'Name : ${widget.petInfo.name}',
              style: TextStyle(color: Colors.purple, fontSize: 24),
            ),
            Text(
              'Tips : Dogs need a comfortable and quiet place to rest. Ensure they have a cozy bed or crate where they can relax and sleep. ',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              'Keep your dog on a leash when in public areas to ensure their safety and the safety of others. Obey leash laws and be a responsible dog owner.  ',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  PetDataImp().togglePetAdopted(widget.petInfo.id);
                  setState(() {
                    Fluttertoast.showToast(
                      msg: "Adopted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      // Duration of the toast (short or long)
                      gravity: ToastGravity.BOTTOM,
                      // Position of the toast on the screen
                      timeInSecForIosWeb: 1,
                      // Time in seconds for iOS and web
                      backgroundColor: Colors.black54,
                      // Background color of the toast
                      textColor: Colors.white,
                      // Text color of the toast message
                      fontSize: 16.0, // Font size of the toast message
                    );
                  });
                },
                child: Text(
                  'Adopt',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
