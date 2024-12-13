import 'package:fbase/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(Authenticated(user: userCredential.user!));
    } catch (e) {
      emit(Unauthenticated(error: e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(Authenticated(user: userCredential.user!));
    } catch (e) {
      emit(Unauthenticated(error: e.toString())); 
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    emit(Unauthenticated());
  }
}