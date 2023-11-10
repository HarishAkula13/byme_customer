

import '../app/arch/bloc_provider.dart';
import '../pages/dashboard/dashboard_bloc.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/login/login_bloc.dart';
import '../pages/login/login_page.dart';
import '../pages/onboard/create_profile/create_profile_bloc.dart';
import '../pages/onboard/create_profile/create_profile_page.dart';
import '../pages/onboard/sign_up/otp_bloc.dart';
import '../pages/onboard/sign_up/otp_page.dart';
import '../pages/onboard/sign_up/sign_up_bloc.dart';
import '../pages/onboard/sign_up/sign_up_page.dart';
import '../repositories/login/login_api.dart';
import 'app_injector.dart';

extension LoginExtension on AppInjector {
  LoginFactory get  loginPage => container.get();
  SignUpFactory get  signUpPage => container.get();
  OTPFactory get  otpPage => container.get();
  CreateProfileFactory get  createProfilePage => container.get();
  DashboardFactory get  dashboardPage => container.get();

  registerLogin(){
    container.registerDependency<LoginFactory>((){
      return(type)=> BlocProvider<LoginBloc>(bloc: LoginBloc(LoginService(),userDataStore,type), child:  LoginPage());
    });
    container.registerDependency<SignUpFactory>((){
      return(type)=> BlocProvider<SignUpBloc>(bloc: SignUpBloc(LoginService(),userDataStore,type), child:  SignUpPage());
    });
    container.registerDependency<DashboardFactory>((){
      return(type,addressData)=> BlocProvider<DashboardBloc>(bloc: DashboardBloc(LoginService(),userDataStore,type,addressData), child:  DashboardPage());
    });
    container.registerDependency<OTPFactory>((){
      return(type,verifyData)=> BlocProvider<OTPBloc>(bloc: OTPBloc(LoginService(),userDataStore,type,verifyData), child:  OTPPage());
    });

    container.registerDependency<CreateProfileFactory>((){
      return(verifyData)=> BlocProvider<CreateProfileBloc>(bloc: CreateProfileBloc(LoginService(),userDataStore,verifyData), child:  CreateProfilePage());
    });


  }

}