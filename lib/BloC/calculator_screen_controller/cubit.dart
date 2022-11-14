import 'dart:developer';

import 'package:calculator_app/BloC/calculator_screen_controller/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

import '../../Screens/common/constant.dart';

class CalculatorScreenController extends Cubit<CalculatorScreenStates>{

  CalculatorScreenController(this.context) :super(InitialState());

  static CalculatorScreenController get(context) => BlocProvider.of(context);

  BuildContext context;

  /// light & dark Mode

  Color reModeColor = modeType == "light" ? Colors.black : Colors.white12 ;

  List<bool> selectedMode = [true,false];
  List<Widget> iconsMode = [
    const Icon(Icons.light_mode),
    const Icon(Icons.dark_mode)
  ];

  void selectMode(int index){
    if(index == 0){
      modeType = "light";
      modeColor = Colors.white;
      reModeColor = Colors.black;
      selectedMode = List.filled(selectedMode.length, false);
      selectedMode[index] = true;
    }else{
      modeType = "dark";
      modeColor = Colors.white12;
      reModeColor = Colors.white;
      selectedMode = List.filled(selectedMode.length, false);
      selectedMode[index] = true;
     // iconsMode[index] = Icon(Icons.dark_mode,color: reModeColor);
    }
    reInitialRichTextController();
    emit(ChangeModeState());
  }


  ///

  ///TextEditingController calcScreenWriter = TextEditingController();

  List<String> bName = [
    "AC","±","%","÷",
    "7","8","9","x",
    "4","5","6","ــ",
    "1","2","3","+",
    "⟲","0",".","=",
  ];

  bool clickEQ = false;

  double bSpaceing(int index){
    if(index < 4 || index == 7 || index == 11 || index == 15|| index == 19){
      return 0;
    }
    return 4;
  }

  Color bTextColor(int index){
    if(index < 3){
      //return const Color.fromRGBO(104, 213, 157, 1.0);
      return Colors.greenAccent.shade200;
    }
    if(index == 3 || index == 7 || index == 11 || index == 15|| index == 19){
      //return const Color.fromRGBO(243, 43, 18, 1.0);
      return Colors.redAccent.shade700;
    }
    return reModeColor;

  }

  void writeOnPanel(int index){

    if(clickEQ){
      if(calcScreenWriter.value.text.contains("Error")){
        calcScreenWriter.text = "";
      }else{
        calcScreenWriter.text =
          calcScreenWriter.value.text.substring(
              calcScreenWriter.value.text.lastIndexOf("\n")+1,
              calcScreenWriter.value.text.length
          );
      }
      clickEQ = false;
    }

    if(bName[index] == "AC"){
      calcScreenWriter.text = "";
    }else

    if(bName[index] == "⟲"){
      if(calcScreenWriter.value.text.isNotEmpty){
        if(calcScreenWriter.value.text[calcScreenWriter.value.text.length-1] == " "){
          calcScreenWriter.text = calcScreenWriter.value.text.substring(
              0,calcScreenWriter.value.text.length -2
          );
        }
        calcScreenWriter.text = calcScreenWriter.value.text.substring(
            0,calcScreenWriter.value.text.length -1
        );
      }
    }else

    if(index == 3 || index == 7 || index == 11 || index == 15){
      if((!calcScreenWriter.value.text.contains("+") &&
          !calcScreenWriter.value.text.contains("-")  &&
          !calcScreenWriter.value.text.contains("x") &&
          !calcScreenWriter.value.text.contains("÷") )  &&
          calcScreenWriter.value.text.isNotEmpty ){

        if(index == 11){
          calcScreenWriter.text += " - ";
        }else{
          calcScreenWriter.text += " ${bName[index]} ";
        }
      }
    }else

    if(index == 19){
      if(calcScreenWriter.value.text.isNotEmpty){
        operationMethod(calcScreenWriter.value.text);
      }
    }else{
      calcScreenWriter.text += bName[index];
    }
  }

  void writeWithLongPress(int index){
    if(bName[index] == "AC"){
      calcScreenWriter.text = "";

    }
    if(bName[index] == "⟲"){
      calcScreenWriter.text = "";
    }
  }

  ///

  RichTextController calcScreenWriter = RichTextController(
    patternMatchMap: {
      RegExp(r"[0-9]"):TextStyle(
          color: modeType == "light" ? Colors.black : Colors.white,
          fontSize: 50
      ),
      RegExp(r"[+-ــx÷]"):TextStyle(color:Colors.redAccent.shade700,fontSize: 50),
    },
    onMatch: (List<String> match) { },
  );

  void reInitialRichTextController(){
    calcScreenWriter = RichTextController(
      text: calcScreenWriter.value.text,
      patternMatchMap: {
        RegExp(r"[0-9]"):TextStyle(
            color: modeType == "light" ? Colors.black : Colors.white,
            fontSize: 50
        ),
        RegExp(r"[+-ــx÷]"):TextStyle(color:Colors.redAccent.shade700,fontSize: 50),
      },
      onMatch: (List<String> match) { },
    );
  }

  ///
  void operationMethod(String panelText){

    try{

      String firstOperand = panelText.substring(0,panelText.indexOf(" "));
      String operation = panelText.substring(panelText.indexOf(" ")+1,panelText.lastIndexOf(" "));
      String secondOperand = panelText.substring(panelText.lastIndexOf(" ")+1,panelText.length);
      double result = 0;

      print("firstOperand$firstOperand");
      print("operation$operation");
      print("secondOperand$secondOperand");
      
      if(secondOperand != ""){

        if(operation == "+"){
          result = double.parse(firstOperand) + double.parse(secondOperand);
        }

        if(operation == "-"){
          result = double.parse(firstOperand) - double.parse(secondOperand);
        }

        if(operation == "x"){
          result = double.parse(firstOperand) * double.parse(secondOperand);
        }

        if(operation == "÷"){
          // debugger();
          if(double.parse(secondOperand) != 0){
            result = double.parse(firstOperand) / double.parse(secondOperand);
          }else{
            result = double.infinity;
          }
        }

        calcScreenWriter.text += " \n${result == double.infinity ? "Error" : calcRestNum(result)}";
        clickEQ = true;
        
      }

    }on Exception catch(e){
      print(e);
    }

  }

  String calcRestNum(double result){

    //double numAfterDot = double.parse(result.toString().split(".")[1]);
    String numAfterDot = result.toString().split(".")[1];

    //if(numAfterDot > 0){
    if(double.parse(numAfterDot) > 0){
      return result.toStringAsFixed(numAfterDot.length > 3 ? 3: numAfterDot.length);
    }else{
      return result.toStringAsFixed(0);
    }
  }

}