part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserReal convertToUser(
          {String name = "No Name",
          List<String> selectedGenres,
          String selectedLanguange = "English",
          int balance = 50000}) =>
      UserReal(this.uid, this.email,
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguange: selectedLanguange,
          balance: balance);
  Future<UserReal> fromFirestore() async =>
      await UserServices.getUser(this.uid);
}
