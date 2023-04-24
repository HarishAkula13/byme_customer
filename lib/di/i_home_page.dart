import '../app/arch/bloc_provider.dart';
import '../pages/dashboard/pages/home/bloc/home_bloc.dart';
import '../pages/dashboard/pages/home/home_page.dart';
import '../pages/dashboard/pages/order/bloc/orders_bloc.dart';
import '../pages/dashboard/pages/order/orders_page.dart';
import '../pages/dashboard/pages/profile/bloc/profile_bloc.dart';
import '../pages/dashboard/pages/profile/profile_page.dart';
import 'app_injector.dart';

extension HomePageExtension on AppInjector {
  BlocProvider<HomeBloc> get  home => container.get();
  BlocProvider<OrdersBloc> get  orders => container.get();
  BlocProvider<ProfileBloc> get  profile => container.get();
  registerHomePage(){

    container.registerDependency<BlocProvider<HomeBloc>>(() {
      return BlocProvider<HomeBloc>(
        bloc: HomeBloc(userDataStore),
        child: HomePage(),
      );
    });

    container.registerDependency<BlocProvider<OrdersBloc>>(() {
      return BlocProvider<OrdersBloc>(
        bloc: OrdersBloc(userDataStore),
        child: OrdersPage(),
      );
    });

    container.registerDependency<BlocProvider<ProfileBloc>>(() {
      return BlocProvider<ProfileBloc>(
        bloc: ProfileBloc(userDataStore),
        child: ProfilePage(),
      );
    });

  }

}