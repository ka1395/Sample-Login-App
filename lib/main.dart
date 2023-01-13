import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginshose/cubit/logic.dart';
import 'package:loginshose/cubit/states.dart';
import 'package:loginshose/dataBase/dbheper.dart';
import 'package:loginshose/form/register.dart';

import 'form/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDataBase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          
          home: BlocProvider(
            create: (context) => AppCubit(),
            child: BlocConsumer<AppCubit, AppState>(
              listener: ((context, state) {}),
              builder: ((context, state) {
                var db = AppCubit.get(context);
                return MyLogin();
              }),
            ),
          ),
        ));
  }
}
