part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserReal user) async {
    // String genres = "";

    // for (var genre in user.selectedGenres) {
    //   genres += genre + ((genre != user.selectedGenres.last) ? ',' : '');
    // }

    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguange': user.selectedLanguange,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<UserReal> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return UserReal(id, snapshot.get('email'),
        balance: snapshot.get('balance'),
        profilePicture: snapshot.get('profilePicture'),
        selectedGenres: (snapshot.get('selectedGenres') as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguange: snapshot.get('selectedLanguange'),
        name: snapshot.get("name"));
  }
}
