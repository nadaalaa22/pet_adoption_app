import 'package:flutter/material.dart';
import '../../data/datasource/pets_data.dart';
import '../widgets/pets_info_widget.dart';

class PetInfo extends StatelessWidget {
  final int index ;
  PetInfo({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PetInformation(petInfo: pets[index],),
    );
  }
}
