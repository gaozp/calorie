
import 'package:calculateurcalorie/model/person.dart';
import 'package:redux/redux.dart';

enum Actions{
  Login,Logout
}

class UpdateUserAction{
  final User userInfo;
  UpdateUserAction(this.userInfo);
}

class MainState{
  User user;
  MainState({this.user});
}

MainState appReducer(MainState state,action){
  return new MainState(
    user : UserReducer(state.user,action),
  );
}

final UserReducer = combineReducers<User>([
  TypedReducer<User,UpdateUserAction>(_updateLoaded)
]);

User _updateLoaded(User user,action){
  user = action.userinfo;
  return user;
}



