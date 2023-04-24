import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../utilities/byme_colors.dart';
class MySearchField extends StatelessWidget {
  final _controller = TextEditingController();
  final labelText;
  final hintText;
  final initialText;
  final obscureText;
  final double height;
  final inputAction;
  final keyboardType;
  final int linesLimit;
  final int? charactersLimit;
  final _focusNode;
  final _onSubmit;
  final _validationStream;
  final _onChange;
  final bool? readOnly;
  final Widget? sufix;
  final Icon? prefixIcon;

  MySearchField(
      {labelText,
        hintText = '',
        initialText = '',
        obscureText = false,
        height = 50.0,
        inputAction,
        keyboardType,
        charactersLimit,
        linesLimit = 1,
        focusNode,
        onSubmit,
        validationStream,
        onChange,readOnly,sufix,prefixIcon})
      : this.labelText = labelText,
        this.hintText = hintText,
        this.initialText = initialText,
        this.obscureText = obscureText,
        this.height = height,
        this.inputAction = inputAction,
        this.charactersLimit=charactersLimit,
        this.linesLimit = linesLimit,
        this.keyboardType = keyboardType,
        _focusNode = focusNode,
        _onSubmit = onSubmit,
        _validationStream = validationStream,
        this.readOnly=readOnly,
        this.sufix=sufix,
        this.prefixIcon=prefixIcon,
        _onChange = onChange {
    _controller.text = initialText;

  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: StreamBuilder<String>(
        initialData: '',
        stream: _validationStream,
        builder: (c, s) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (labelText!="")?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(labelText, style: TextStyle(color: Colors.black,fontSize: 14),),
                ):SizedBox(),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                      color: HexColor('#F3F3F3'),
                      border: Border.all(color: HexColor('#CECECE')),
                      borderRadius: BorderRadius.all(Radius.circular(60))
                  ),
                  height: 48,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset('assets/images/pic.svg')),
                     Align(
                          alignment: Alignment.centerLeft,
                          child:  SvgPicture.asset('assets/images/search.svg')),
                      Padding(
                        padding:  EdgeInsets.only(left: 25.0,right: 20),
                        child: TextField(
                          key: Key(labelText),
                          // controller: _controller,
                          keyboardType: keyboardType,
                          textInputAction: inputAction,
                          maxLines: linesLimit,
                          readOnly: (readOnly!=null)?readOnly!:false,
                          onChanged: _onChange,
                          style: TextStyle(fontSize: 14,color: Colors.black),
                          onSubmitted: _onSubmit,
                          obscureText: obscureText,
                          focusNode: _focusNode,
                          inputFormatters: [
                            if (charactersLimit != null)
                              LengthLimitingTextInputFormatter(charactersLimit)
                          ],
                          decoration: InputDecoration(

                            hintText: hintText,
                            hintStyle: TextStyle(fontSize: 14,color: ByMeColors.hint_text_color),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                (s.data.toString()!="")?Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(s.data!, style: TextStyle(color: Colors.red,fontSize:10),),
                ):SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}