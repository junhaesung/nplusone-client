import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nplusone/view/navigation/tab_page_cubit.dart';
import 'package:nplusone/view/navigation/tab_page_navigator.dart';
import 'package:nplusone/view/nplusone_colors.dart';

class NplusoneApp extends StatelessWidget {
  const NplusoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TabPageCubit>(create: (_) => TabPageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: NplusoneColors.purple,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
          ),
          canvasColor: Colors.white,
          fontFamily: 'Pretendard',
          primarySwatch: Colors.purple,
        ),
        home: const TabPageNavigator(),
      ),
    );
  }
}
