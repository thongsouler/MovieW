import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/data/data_sources/authentication_local_data_source.dart';

import '../../../common/constants/translation_constants.dart';
import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/login_request_params.dart';
import '../../../domain/entities/no_params.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/usecases/logout_user.dart';
import '../loading/loading_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final LoadingCubit loadingCubit;

  LoginCubit({
    required this.loginUser,
    required this.logoutUser,
    required this.loadingCubit,
  }) : super(LoginInitial());

  void initiateLogin(String username, String password) async {
    loadingCubit.show();
    final Either<AppError, bool> eitherResponse = await loginUser(
      LoginRequestParams(
        userName: username,
        password: password,
      ),
    );

    emit(eitherResponse.fold(
      (l) {
        var message = getErrorMessage(l.appErrorType);
        print(message);
        return LoginError(message);
      },
      (r) {
        print('Login success');
        saveId(username);

        return LoginSuccess();
      },
    ));
    loadingCubit.hide();
  }

  void initiateGuestLogin() async {
    emit(LoginSuccess());
  }

  void logout() async {
    await logoutUser(NoParams());
    emit(LogoutSuccess());
  }

  void saveId(String id) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    await authenticationBox.put('id', id);
    print("Save Id");
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return TranslationConstants.somethingWentWrong;
      case AppErrorType.sessionDenied:
        return TranslationConstants.sessionDenied;
      default:
        return TranslationConstants.wrongUsernamePassword;
    }
  }
}
