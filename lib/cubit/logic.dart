import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginshose/dataBase/dbheper.dart';
import 'states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitState());
  static AppCubit get(context) => BlocProvider.of(context);

  insertUser(String email, String password) {
    DbHelper.insertdb(email, password);
    emit(InsertDatabaseState());
  }

  List<Map> mapData = [];
  showData() {
    DbHelper.printdb().then((value) {
      mapData = value;
      print(mapData);
    });
    emit(ShowDatabaseState());
  }

  deletData(int id) {
    DbHelper.deletedb(id);
    showData();
    emit(DeleteDatabaseState());
  }

  creatAcount(Map acount) {
    insertUser(acount['email'], acount['password']);
    showData();
    emit(CreatAcountState());
  }

  checkAcount(Map acount) {
    showData();
    bool isExist = false;

    for (var accountuser in mapData) {
      if (acount['email'] == accountuser['email'] &&
          acount['password'] == accountuser['password']) {
        isExist = true;
        break;
      }
    }
    emit(CheckAcountState());

    return isExist;
  }
}
