import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      UserReal userReal = await UserServices.getUser(event.id);

      yield UserLoaded(userReal);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      UserReal updateUser = (state as UserLoaded)
          .userReal
          .copyWith(name: event.name, profilePicture: event.profileImage);
      await UserServices.updateUser(updateUser);
      yield UserLoaded(updateUser);
    }
  }
}
