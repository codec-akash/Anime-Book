import 'package:animebook/bloc/quotes_bloc.dart';
import 'package:animebook/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        backgroundColor: Color(0xff202531),
        accentColor: Color(0xff2F353A),
      ),
      home: BlocProvider<QuotesBloc>(
        create: (context) => QuotesBloc(),
        child: HomeScreen(),
      ),
    );
  }
}
