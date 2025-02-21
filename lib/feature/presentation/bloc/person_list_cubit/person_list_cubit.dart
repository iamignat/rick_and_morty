import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_state.dart';

const serverFailureMessage = 'Server Failure';
const cachedFailureMessage = 'Cache Failure';

class PersonListCubit extends Cubit<PersonListState> {
  final GetAllPersons getAllPersons;
  PersonListCubit({required this.getAllPersons}) : super(PersonListEmpty());

  int page = 1;

  void loadPersons() async {
    if (state is PersonListLoading) {
      return;
    }
    final currentState = state;
    var oldPerson = <PersonEntity>[];
    if (currentState is PersonListLoaded) {
      oldPerson = currentState.personList;
    }
    emit(PersonListLoading(oldPerson, isFirstFetch: page == 1));
    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson.fold(
        (failure) =>
            emit(PersonListError(message: _mapFailureToMessage(failure))),
        (person) {
      page++;
      final persons = (state as PersonListLoading).oldPersonList;
      persons.addAll(person);
      emit(PersonListLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailureMessage;
      case const (CacheFailure):
        return cachedFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
