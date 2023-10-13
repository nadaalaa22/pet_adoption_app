part of 'pet_bloc.dart';

@immutable
abstract class PetEvent {}

class SetPetEvent extends PetEvent {
  final Pet pet;

  SetPetEvent({required this.pet});
}

class GetPetEvent extends PetEvent {}

class SetFavoritePetsEvent extends PetEvent {
  final String id;

  SetFavoritePetsEvent({required this.id});
}

class SetAdoptedPetsEvent extends PetEvent {
  final String id;

  SetAdoptedPetsEvent({required this.id});
}
