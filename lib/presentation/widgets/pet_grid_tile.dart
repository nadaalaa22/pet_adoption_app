import 'package:flutter/material.dart';
import '../../data/datasource/pets_data.dart';
import '../pages/pet_info.dart';

class PetGridTile extends StatelessWidget {
   final int index ;
   PetGridTile({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PetInfo(index:index)));
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
                  child: Center(child: Text(pets[index].name,style: TextStyle(color: Colors.white,fontSize: 24),))),
              child: Image.asset(pets[index].imageUrl,fit: BoxFit.cover,),
            ),
          ),
        ),
      ),
    );
  }
}
