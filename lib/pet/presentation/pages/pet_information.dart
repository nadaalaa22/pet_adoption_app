import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/models/pet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_app/pet/presentation/bloc/pet_bloc.dart';

class PetInformation extends StatefulWidget {
  final Pet petInfo;

  const PetInformation({super.key, required this.petInfo});

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
          style: const TextStyle(color: Colors.white),
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
              context
                  .read<PetBloc>()
                  .add(SetFavoritePetsEvent(id: widget.petInfo.id));
              if (mounted) {
                setState(() {
                  widget.petInfo.isFavorite = !widget.petInfo.isFavorite;
                });
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<PetBloc, PetState>(
          listener: (context, state) {
            if (state is PetLoadedState) {
              Fluttertoast.showToast(
                msg: "successfully",
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
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(image: AssetImage(widget.petInfo.imageUrl)),
                Text(
                  'ID : ${widget.petInfo.id}',
                  style: const TextStyle(color: Colors.purple, fontSize: 24),
                ),
                Text(
                  'Name : ${widget.petInfo.name}',
                  style: const TextStyle(color: Colors.purple, fontSize: 24),
                ),
                const Text(
                  'Tips : Dogs need a comfortable and quiet place to rest. Ensure they have a cozy bed or crate where they can relax and sleep. ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const Text(
                  'Keep your dog on a leash when in public areas to ensure their safety and the safety of others. Obey leash laws and be a responsible dog owner.  ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<PetBloc>()
                          .add(SetAdoptedPetsEvent(id: widget.petInfo.id));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                      'Adopt',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
