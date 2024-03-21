import 'package:flutter/material.dart';
import 'package:leafapp/core/routes.dart';
import 'package:leafapp/data/repository/leaf_repository.dart';
import 'package:leafapp/logic/leaf/bloc/leaf_bloc.dart';
import 'package:leafapp/presentation/screens/get_started/getStarted_screen.dart';
import 'package:leafapp/presentation/screens/home/home_screen.dart';
import 'package:leafapp/presentation/screens/login/login_screen.dart';
import 'package:leafapp/presentation/screens/master_screen/master_home_screen.dart';
import 'package:leafapp/presentation/screens/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
        home: MasterHomePage(),
      ),
    );
  }
}