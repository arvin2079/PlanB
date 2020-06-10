import 'package:flutter/material.dart';
import 'package:planb/src/bloc/user_bloc.dart';

class UserBlocProvider extends InheritedWidget {
  final UserBloc bloc;

  UserBlocProvider({Key key, Widget child})
      : bloc = UserBloc(),
        super(key: key, child: child);

  static UserBloc of(BuildContext context){
    // ignore: deprecated_member_use
    return (context.inheritFromWidgetOfExactType(UserBlocProvider) as UserBlocProvider).bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
