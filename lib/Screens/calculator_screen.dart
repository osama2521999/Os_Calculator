import 'package:calculator_app/BloC/calculator_screen_controller/cubit.dart';
import 'package:calculator_app/BloC/calculator_screen_controller/states.dart';
import 'package:calculator_app/Screens/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorScreenController(context),
      child: BlocConsumer<CalculatorScreenController,CalculatorScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var controller = CalculatorScreenController.get(context);

          Size size = MediaQuery.of(context).size;
          Orientation orientation = MediaQuery.of(context).orientation;

          return Scaffold(
            backgroundColor: modeColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: (size.width * .2)),
                  alignment: Alignment.center,

                  child: ToggleButtons(
                    // color: modeColor,
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    isSelected: controller.selectedMode,
                    onPressed: (index) => controller.selectMode(index),
                    highlightColor: controller.reModeColor,
                    selectedColor: controller.reModeColor,
                    color: modeType == "light" ?
                      const Color.fromRGBO(238, 231, 230, 1) :
                      const Color.fromRGBO(86, 140, 168, 1.0),

                    children: controller.iconsMode,
                  ),
                ),

                ///calculator panel
                Container(
                  height: (size.height * .25),
                  width: size.width,
                  color: Colors.transparent,
                  child: calculatorPanel(
                    ///controller.calcScreenWriter,
                    controller.calcScreenWriter,
                    fontSize: 50,
                    fontColor: controller.reModeColor,
                    cursorColor: controller.reModeColor,
                    expands: true,
                    readOnly: true,
                    cursorHeight: 50,
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.end
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    width: size.width,
                    child: Container /*Card*/(
                      //shadowColor: Colors.deepPurple,
                      //color: Colors.red,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      //   side: const BorderSide()
                      // ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        //borderRadius: BorderRadius.circular(15),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: modeType == "light" ?
                          //const Color.fromRGBO(255, 252, 252, 1.0) :
                          const Color.fromRGBO(255, 251, 251, 1.0) :
                          const Color.fromRGBO(19, 18, 18, 1.0)
                      ),


                      child: Container(
                        margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: GridView.builder(
                          itemCount: controller.bName.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: (orientation == Orientation.portrait) ? 4 : 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (BuildContext context, int index) {

                            return Container(
                              // margin: const EdgeInsets.all(4),
                              margin: EdgeInsets.all(controller.bSpaceing(index)),
                              child: ElevatedButton(
                                onLongPress: () => controller.writeWithLongPress(index),
                                onPressed: () => controller.writeOnPanel(index),
                                style: fixedButtonStyle(
                                  20,
                                  buttonColor: modeType == "light" ?
                                  const Color.fromRGBO(255, 255, 255, 1.0) :
                                  const Color.fromRGBO(24, 23, 23, 1.0)
                                  //Colors.red
                                ),
                                child: Text(
                                  controller.bName[index],
                                  style: TextStyle(
                                    color: controller.bTextColor(index),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );

                          },
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}
