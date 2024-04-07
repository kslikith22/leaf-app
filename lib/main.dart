import 'package:flutter/material.dart';
import 'package:leafapp/core/routes.dart';
import 'package:leafapp/data/repository/ai_description_repository.dart';
import 'package:leafapp/data/repository/auth_repository.dart';
import 'package:leafapp/data/repository/leaf_repository.dart';
import 'package:leafapp/data/repository/user_activity_repository.dart';
import 'package:leafapp/logic/ai/bloc/ai_bloc.dart';
import 'package:leafapp/logic/auth/bloc/auth_bloc.dart';
import 'package:leafapp/logic/leaf/bloc/leaf_bloc.dart';
import 'package:leafapp/logic/user_activity/bloc/user_activity_bloc.dart';
import 'package:leafapp/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LeafBloc(LeafRepository()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => AIBloc(AIRespository()),
        ),
        BlocProvider(
          create: (context) => UserActivityBloc(UserActivityRepository()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoutes,
        initialRoute: '/',
        theme: ThemeData(
          fontFamily: "Poppins",
          useMaterial3: true,
          colorSchemeSeed: Colors.white,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
