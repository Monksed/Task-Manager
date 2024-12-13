import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'router/app_router.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/task_cubit.dart';
import 'firebase_options.dart';
import 'repository/tasks_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(FirebaseAuth.instance),
        ),
        BlocProvider(
          create: (context) => TaskCubit(
            TasksRepository(
              FirebaseFirestore.instance, 
              FirebaseAuth.instance),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}