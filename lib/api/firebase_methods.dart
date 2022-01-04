abstract class FireBaseMethods {
  Future create(Map<String, dynamic> data);
  Future update(String id, Map<String, dynamic> data);
  Future delete(String id);
  getALL();
  getOne(String id);
}
// Future createUserByEmailAndPassword();
// Future getCurrentUser();

