import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_plan/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';



class UserController{
    final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
CollectionReference get usersCollection => _firestore.collection('users');


    Future<String?>register(UserModel user) async{
        try {
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: user.email,password:user.password);

          String uid = userCredential.user!.uid;
          user.uid = uid;

          await _firestore.collection('users').doc(uid).set(user.toJson());

          return null;

        }on FirebaseAuthException catch(e){
            return e.message;
        }on FirebaseException catch(e){
            return e.message;
        } catch (e) {
          return 'Error occurred: $e';
        }
        
    }
}