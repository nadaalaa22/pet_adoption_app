import 'package:flutter/material.dart';

import '../../data/models/pet.dart';
import '../pages/pet_information.dart';

class PetGridTile extends StatefulWidget {
  final Pet pet;
  final Function() onTapCallback;

  PetGridTile({super.key, required this.pet, required this.onTapCallback});

  @override
  State<PetGridTile> createState() => _PetGridTileState();
}

class _PetGridTileState extends State<PetGridTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PetInformation(petInfo: widget.pet)));
          setState(() {});
          widget.onTapCallback();
        },
        child: SizedBox(
          width: 200,
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              footer: Container(
                  height: 50,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                      child: Text(
                    widget.pet.name,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ))),
              child: Image.asset(
                widget.pet.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
