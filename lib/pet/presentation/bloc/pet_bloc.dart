import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_adoption_app/pet/data/datasource/local_datasource/pet_local_datasource.dart';
import 'package:pet_adoption_app/pet/data/models/pet.dart';

part 'pet_event.dart';

part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetBloc() : super(PetInitial()) {
    on<PetEvent>((event, emit) async {
      if (event is SetPetEvent) {
        emit(PetLoadingState());
        await PetDataImp().setPet(event.pet);
        List<Pet> pets = await PetDataImp().getPets();
        emit(PetLoadedState(pets: pets));
      }

      else if (event is GetPetEvent) {
        emit(PetLoadingState());
        List<Pet> pets = await PetDataImp().getPets();
        emit(PetLoadedState(pets: pets));
      }

      else if (event is SetFavoritePetsEvent) {
        await PetDataImp().togglePetFavorite(event.id);
        emit(PetLoadingState());
        List<Pet> pets = await PetDataImp().getPets();
        emit(PetLoadedState(pets: pets));
      }

      else if (event is SetAdoptedPetsEvent) {
        await PetDataImp().togglePetAdopted(event.id);
        emit(PetLoadingState());
        List<Pet> pets = await PetDataImp().getPets();
        emit(PetLoadedState(pets: pets));
      }
    });
  }
}
