part of "shared.dart";

Future<File> getImage() async {
  var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  return File(image.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task;

  return snapshot.ref.getDownloadURL();
}
