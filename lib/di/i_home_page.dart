import 'package:byme_app/pages/dashboard/pages/orders_history/bloc/orders_history_bloc.dart';

import '../app/arch/bloc_provider.dart';
import '../pages/dashboard/pages/home/bloc/home_bloc.dart';
import '../pages/dashboard/pages/home/home_page.dart';
import '../pages/dashboard/pages/order/bloc/orders_bloc.dart';
import '../pages/dashboard/pages/order/orders_page.dart';
import '../pages/dashboard/pages/orders_history/bloc/order_history_details_bloc.dart';
import '../pages/dashboard/pages/orders_history/order_history_details_page.dart';
import '../pages/dashboard/pages/orders_history/orders_history_page.dart';
import '../pages/dashboard/pages/profile/bloc/profile_bloc.dart';
import '../pages/dashboard/pages/profile/profile_page.dart';
import 'app_injector.dart';

extension HomePageExtension on AppInjector {
  BlocProvider<HomeBloc> get  home => container.get();
  BlocProvider<OrdersBloc> get  orders => container.get();
  BlocProvider<ProfileBloc> get  profile => container.get();
  BlocProvider<OrdersHistoryBloc> get  ordersHistory => container.get();
  BlocProvider<OrdersHistoryDetailsBloc> get  ordersHistoryDetails => container.get();

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

    container.registerDependency<BlocProvider<OrdersHistoryBloc>>(() {
      return BlocProvider<OrdersHistoryBloc>(
        bloc: OrdersHistoryBloc(userDataStore),
        child: OrdersHistoryPage(),
      );
    });
    container.registerDependency<BlocProvider<OrdersHistoryDetailsBloc>>(() {
      return BlocProvider<OrdersHistoryDetailsBloc>(
        bloc: OrdersHistoryDetailsBloc(userDataStore),
        child: OrdersHistoryDetailsPage(),
      );
    });

  }

}