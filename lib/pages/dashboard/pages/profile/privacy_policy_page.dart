
import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/fonts/fonts.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/load_container/load_container.dart';
import '../../../../common/utils/pyc_colors.dart';
import 'bloc/privacy_policy_page_bloc.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  PrivacyPolicyPageBloc? bloc;
  WebViewController? _controller;
  @override
  void initState() {
    bloc=BlocProvider.of(context);
    _controller = WebViewController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 50,

        leading: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios_new,color: PYCColors.text_Secondary,size: 18,)),
        ),
        automaticallyImplyLeading: false,
        title: ItemLabelText(text: bloc!.type==1?'Privacy Policy':'Terms of Services',style: TextStyle(color: PYCColors.text_Secondary,fontSize: 18,fontFamily: Fonts.bold),),
        backgroundColor: Colors.white,
      ),
      body: LoaderContainer(
        stream: bloc!.isLoading,
        child: WebViewWidget(controller: _controller!
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {

              },
              onPageStarted: (String url) {bloc!.addIsLoading.add(true);},
              onPageFinished: (String url) {bloc!.addIsLoading.add(false);},
              onWebResourceError: (WebResourceError error) {},
            ),
          )
          ..loadRequest(Uri.parse(bloc!.type==2?EndPoints.terms:EndPoints.privacy))),
    
      ),



    );
  }
}
