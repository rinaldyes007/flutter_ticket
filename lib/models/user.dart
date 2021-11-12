part of 'models.dart';

class UserReal extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final List<String> selectedGenres;
  final String selectedLanguange;
  final int balance;

  UserReal(this.id, this.email,
      {this.name,
      this.profilePicture,
      this.selectedGenres,
      this.selectedLanguange,
      this.balance});

  UserReal copyWith({String name, String profilePicture, int balance}) =>
      UserReal(this.id, this.email,
          name: name ?? this.name,
          profilePicture: profilePicture ?? this.profilePicture,
          balance: balance ?? this.balance,
          selectedGenres: selectedGenres,
          selectedLanguange: selectedLanguange);

  @override
  String toString() {
    return "[$id] - $name, $email";
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        id,
        email,
        name,
        profilePicture,
        selectedGenres,
        selectedLanguange,
        balance
      ];
}
