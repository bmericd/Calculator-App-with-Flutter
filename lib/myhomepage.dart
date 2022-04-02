import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String inputString = '';
  String showString = '';
  static const List<String> symbols = ['C','DEL','%','/','7','8','9','X','4','5','6','-','1','2','3','+','+/-','0','.','='];
  static const List<String> operators = ['%','/','X','-','+'];
  List<double> numbers = [];
  List<String> ops = [];
  List<Object> objects = [];
  bool negativeFlag = false;

  bool isOperator(String o){
    return operators.contains(o);
  }

  void calculate(String s){
    //print(s);

    if (s == "C") { //Check if Clear
      clear();
      return;
    }

    if(showString.isNotEmpty && showString.substring(showString.length-1,showString.length) == "="){
      clear();
    }
    if(s == "DEL" && showString.isEmpty){
      return;
    }
    if (s == "DEL" && showString.isNotEmpty) {
      showString = showString.substring(0, showString.length-1);
      inputString = inputString.substring(0, inputString.length-1);
      setState(() {});
      return;
    }

    if(isOperator(s) && showString.isEmpty){
      return;
    }

    if(s == "+/-" && isOperator(showString.substring(showString.length-1,showString.length))){
      return;
    }

   if (s == "+/-" && showString.isNotEmpty ) {
        //numbers[numbers.length - 1] *= -1;
        if (!negativeFlag) { 
          if (numbers.isEmpty) {
            showString = "-"+showString;
            inputString = "-"+inputString;
            negativeFlag = true;
            setState(() {});
          }else{
            showString = showString.substring(0,showString.length - inputString.length) + "-" + showString.substring(showString.length - inputString.length, showString.length);
            inputString = "-"+inputString;
            negativeFlag = true;
            setState(() {});
          }
        }else{
          showString = showString.substring(0,showString.length - inputString.length) + showString.substring(showString.length - inputString.length+1, showString.length);
          inputString = inputString.substring(1,inputString.length);
          negativeFlag = false;
          setState(() {});
        }
    }
    
    if(s == "=" && isOperator(showString.substring(showString.length-1,showString.length))){
      return;
    }

    if(s == "="){
      if (showString.isEmpty) {
      return;
      }
      if(showString.substring(showString.length-1, showString.length) == "="){
        return;
      }
      if(isOperator(showString.substring(showString.length-1, showString.length))){
        showString = showString.substring(0, showString.length-1);
      }
      if(!isOperator(showString.substring(showString.length-1,showString.length))){
        numbers.add(double.parse(inputString));
      }
      
     
      
      print(numbers);
      print(ops);

      //CALCULATION PART
      int mulIndex, sumIndex, divIndex, subIndex, modIndex;
      var loopAmount = ops.length;
      for (var i = 0; i < loopAmount; i++) {
        mulIndex = ops.indexOf("X");
        divIndex = ops.indexOf("/");
        sumIndex = ops.indexOf("+");
        subIndex = ops.indexOf("-");
        modIndex = ops.indexOf("%");

        if(modIndex != -1){ //FOR %
          numbers[modIndex] = numbers[modIndex] % numbers[modIndex+1];
          numbers.removeAt(modIndex+1);
          ops.removeAt(modIndex);
        } else if(mulIndex != -1){ //FOR X
          numbers[mulIndex] = numbers[mulIndex] * numbers[mulIndex+1];
          numbers.removeAt(mulIndex+1);
          ops.removeAt(mulIndex);
        } else if(divIndex != -1){ //FOR /
          numbers[divIndex] = numbers[divIndex] / numbers[divIndex+1];
          numbers.removeAt(divIndex+1);
          ops.removeAt(divIndex);
        } else if(sumIndex != -1){ //FOR +
          numbers[sumIndex] = numbers[sumIndex] + numbers[sumIndex+1];
          numbers.removeAt(sumIndex+1);
          ops.removeAt(sumIndex);
        } else if(subIndex != -1){ //FOR -
          numbers[subIndex] = numbers[subIndex] - numbers[subIndex+1];
          numbers.removeAt(subIndex+1);
          ops.removeAt(subIndex);
        }
        
      }
      
      /*
      for(int i = 0; i < objects.where((e) => e.runtimeType == String).toList().length; i++){
        
      }
      */
      
    print(numbers);
    print(ops);
   
    double num = numbers[0];
    if(num - num.floor() == 0){
      showString = numbers[0].floor().toString();
    }else if(numbers[0].toString().length < 6){
      showString = numbers[0].toString();
    }else{
      showString = numbers[0].toString().substring(0,6);
    }
    }

     

    if(showString.isNotEmpty && isOperator(showString.substring(showString.length-1, showString.length)) && isOperator(s) || s == "+/-"){
        return;
    }   
    inputString += s;
    showString += s;

    

 
  
    if(operators.contains(s)){
      //numbers.add(double.parse(inputString.substring(0,inputString.length -1)));
      //objects.add(double.parse(inputString.substring(0,inputString.length -1)));
      //objects.add(s);
      if(negativeFlag){
        
      numbers.add(double.parse(inputString.substring(0,inputString.length -1)));
      negativeFlag = false;
      }else{
      numbers.add(double.parse(inputString.substring(0,inputString.length -1)));
      }
      ops.add(s);
      inputString = '';
      //print(numbers);
      //print(objects);

      //print(numbers);
      //print(ops);
    }

    
    setState(() {});

    //print(numbers);
  }

  void clear(){
    setState(() {
      showString = '';
      inputString = '';
      //objects.clear();
      numbers.clear();
      ops.clear();
      negativeFlag = false;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: 1000,
        child: Column(
          children: [
            Container(
              height: 270,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(10),
              child: Text(showString, style: TextStyle(fontSize: 45),),
            ),
            Container(
              height: 409,
              child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 6 / 5,
                          crossAxisCount: 4),
                          itemCount: symbols.length,
                          itemBuilder: (BuildContext ctx, index){
                            return Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Text(symbols[index], style: TextStyle(fontSize: 28, color: symbols[index] == '=' ? Colors.white : (symbols[index] == 'C' ? Colors.cyan : Color.fromARGB(255, 50, 50, 50)) )),
                                onPressed: (){calculate(symbols[index]);},
                                style: TextButton.styleFrom(fixedSize: Size.fromRadius(150), primary: Color.fromARGB(255, 50, 50, 50)),
                                ),  
                              decoration: BoxDecoration(
                                color: symbols[index] == '=' ? Colors.cyan : Colors.white,
                                borderRadius: BorderRadius.zero,
                                border: Border.all(color: Colors.grey, width: 0.5
                                )
                              ),
                            );
                          }),
                        ),
          ],
        ),
      ),
      );
  }
}