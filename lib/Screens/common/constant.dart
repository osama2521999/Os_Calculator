
import 'package:flutter/material.dart';

const MaterialColor color=Colors.lightGreen;


const Color appThemColor=color;

String modeType = "light";

Color modeColor = Colors.white;

Icon modeIcon = const Icon(Icons.light_mode_outlined);


double constFieldWidth(BuildContext context,double scale){

  return (MediaQuery.of(context).size.width)*scale;

}


List<double> buttonsHeightWidth(BuildContext context,double scaleHeight,double scaleWidth){

  double width = (MediaQuery.of(context).size.width)*scaleWidth;
  double height = (MediaQuery.of(context).size.height)*scaleHeight;

  return [width,height];

}

TextField calculatorPanel(
  TextEditingController controller, {
  bool? expands,
  bool? readOnly,
  double? cursorHeight,
  Color ? cursorColor,
  TextAlignVertical? textAlignVertical,
  TextAlign? textAlign,
  Color? fontColor,
  double? fontSize,
}) {
  return TextField(
    decoration: const InputDecoration(
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    ),
    textDirection: TextDirection.ltr,
    expands: expands ?? false,
    minLines: expands == true ? null : 1,
    maxLines: expands == true ? null : 6,
    //enabled: false,
    readOnly: readOnly ?? false,
    showCursor: true,
    cursorHeight: cursorHeight,
    // cursorWidth: 100,
    cursorColor: cursorColor,
    autofocus: true,
    textAlignVertical: textAlignVertical,
    textAlign: textAlign ?? TextAlign.start,
    style: TextStyle(fontSize: fontSize,color: fontColor),
    controller: controller,
    //enabled: false,
  );
}

InputDecoration fixedInputDecoration(String text,double border,Widget? suffix){
  return InputDecoration(

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),

    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      borderSide:  BorderSide(
        color: color.shade100,
        width: 2.0,
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(border),
      ///borderSide:  BorderSide(
      ///color: appFieldColor,
      ///),
    ),

    hintText: text,
    // labelText: text,
    //labelStyle: TextStyle(color: appFieldColor),
    suffixIcon: suffix,
    suffixText: null,
  );

}


ButtonStyle fixedButtonStyle(double circular,{Color? buttonColor,Color? borderColor ,double? elevation }){
  return ButtonStyle(
      backgroundColor: MaterialStateProperty.all( buttonColor??appThemColor ),
      elevation: MaterialStateProperty.all(elevation),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circular),
              side: BorderSide(
                //color: Colors.orangeAccent.shade700,
                color: borderColor ?? buttonColor ?? Colors.white,
              )
          )
      )
  );
}



TextStyle fixedTextStyle({double? font, String? family,FontStyle? style,FontWeight? weight,Color? color}){
  return TextStyle(
      fontWeight: weight,
      fontStyle: style,
      color: color /*?? appBarColor*/,
      fontFamily: family,
      fontSize: font
  );
}