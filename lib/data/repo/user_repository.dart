import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection;

  UserRepository()
      : _usersCollection = FirebaseFirestore.instance.collection('users');

  // Add a new user
  Future<void> addUser(User user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  // Get a user by ID
  Future<User?> getUserById(String id) async {
    try {
      DocumentSnapshot doc = await _usersCollection.doc(id).get();
      if (doc.exists) {
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error getting user: $e");
    }
    return null;
  }

  // Update a user
  Future<void> updateUser(User user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toMap());
    } catch (e) {
      print("Error updating user: $e");
    }
  }

  // Delete a user
  Future<void> deleteUser(String id) async {
    try {
      await _usersCollection.doc(id).delete();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

  // Get all users
  Future<List<User>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _usersCollection.get();
      return querySnapshot.docs
          .map((doc) => User.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error getting users: $e");
      return [];
    }
  }
}
