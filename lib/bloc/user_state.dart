part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final UserReal userReal;

  UserLoaded(this.userReal);

  @override
  List<Object> get props => [userReal];
}
