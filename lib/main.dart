import 'package:bwa_flutix/bloc/blocs.dart';
import 'package:bwa_flutix/ui/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageBloc()),
          BlocProvider(create: (_) => UserBloc()),
          BlocProvider(create: (_) => ThemeBloc())
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (_, themeState) => MaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: Wrapper(),
                )),
      ),
    );
  }
}
