
import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/arch/bloc_provider.dart';
import '../../common/fonts/fonts.dart';
import '../../common/utilities/byme_colors.dart';
import '../../di/app_injector.dart';
import 'dashboard_bloc.dart';
typedef TabBarPage = Widget Function();

class DashboardPage extends StatefulWidget {

  @override
  DashboardPageState createState() => DashboardPageState();
}
class DashboardPageState extends State<DashboardPage>{
  DashboardBloc? _bloc;
  List<TabBarPage> _pages = [
        ()=> AppInjector.instance.home,
        ()=> AppInjector.instance.orders,
        ()=> AppInjector.instance.orders,
        ()=> AppInjector.instance.profile,
  ];
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: StreamBuilder<int>(
        initialData: 0,
        stream: _bloc!.selectedPos,
        builder: (b, s) {
          return _pages[s.data!]();
        },
      ),
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), //color of shadow
            blurRadius: 12, // blur radius
            offset: Offset(4.27, -2), // changes position of shadow
          ),
        ]),
        child: StreamBuilder<int>(
            initialData: 0,
            stream: _bloc!.selectedPos,
            builder: (context, snapshot) {
              return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: ByMeColors.app_color,
                  unselectedItemColor: ByMeColors.un_select,
                  selectedLabelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.regular,
                      color: ByMeColors.app_color),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: Fonts.regular,
                      color: ByMeColors.un_select),
                  selectedFontSize: 0.0,
                  unselectedFontSize: 0,
                  currentIndex: snapshot.data!,
                  onTap: (value) {
                    _bloc!.addSelectedPos.add(value);
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/home.svg',height: 21,width: 21,color: (snapshot.data ==0)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/order.svg',height: 21,width: 21,color: (snapshot.data ==1)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Near Me",
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/home.svg',height: 21,width: 21,color: (snapshot.data ==2)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Cart",
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/profile.svg',height: 21,width: 21,color: (snapshot.data ==3)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Profile",
                    ),

                  ]);
            }

        ),
      ),
    );


  }


}