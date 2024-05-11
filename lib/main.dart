import 'package:flutter/material.dart';
import 'dart:io';

class MainScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('Реализация асинхронной логики')),

      body: Container ( color: Colors.lime[900], 
        child: Center(child:  Column(children: [

        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/screen_5');}, child: Text('Реализация метода async-await',style: TextStyle(fontSize: 14, color: Colors.indigo) )),
        Text(' ', style: TextStyle(fontSize: 22, color: Colors.green)),
        ElevatedButton(onPressed: (){Navigator.pushNamed(context, '/screen_6');}, child: Text('Реализация метода Future API',style: TextStyle(fontSize: 14, color: Colors.indigo) ))

      ],))),

    );

  }

}


class Screen_5 extends StatefulWidget {
 
  @override
  _Screen_5s createState() => _Screen_5s();
}


class _Screen_5s extends State<Screen_5>{

  TextEditingController _nameController = TextEditingController();

  final sp1 = List.generate(15,(index)=>'Эллемент № ${index + 1}');

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('Реализация метода async-await',style: TextStyle(fontSize: 18, color: Colors.indigo))),

      body: new Column (  
	children: [
        Container ( color: Colors.cyan,   height:100,
        child: Center(child:  Column(
        children: [
          new TextField(  controller: _nameController,  decoration: InputDecoration(    hintText: 'Новый эллемент списка или номер удаляемого',  ),),
          ElevatedButton(onPressed: (){ setState(() => sp1.add( _nameController.text)); }, child: Text('Добавить в список',style: TextStyle(fontSize: 20, color: Colors.indigo))),
          ]))),

	Expanded(
        child: Container ( color: Colors.grey[800],   height:380, 
	child: ListView.builder(
            itemCount: sp1.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(index.toString()+'  '+sp1[index], style: TextStyle(fontSize: 16, color: Colors.white));
            }),
       ),),

        Container ( color: Colors.lime,   height:120, 
       child: Center(child:  Column(
        children: [
          ElevatedButton(onPressed: (){ do_Future(context,sp1); }, child: Text('Записать в файл (асинхронноая работа)',style: TextStyle(fontSize: 28, color: Colors.red))),
          ElevatedButton(onPressed: (){ setState(() => sp1.removeAt(int.parse( _nameController.text))); }, child: Text('Удалить из списка по номеру',style: TextStyle(fontSize: 20, color: Colors.green))),
          ElevatedButton(onPressed: (){ Navigator.pop(context);}, child: Text('Назад',style: TextStyle(fontSize: 24, color: Colors.blue)))
   ])), 

       ),
    ]
    ),
    );

  }

}




class Screen_6 extends StatefulWidget {
 
  @override
  _Screen_6s createState() => _Screen_6s();
}


class _Screen_6s extends State<Screen_6>{

  TextEditingController _nameController = TextEditingController();

  final sp1 = List.generate(15,(index)=>'Эллемент № ${index + 1}');

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text('Реализация метода Future API',style: TextStyle(fontSize: 18, color: Colors.indigo))),

      body: new Column (  
	children: [
        Container ( color: Colors.cyan,   height:100,
        child: Center(child:  Column(
        children: [
          new TextField(  controller: _nameController,  decoration: InputDecoration(    hintText: 'Новый эллемент списка или номер удаляемого',  ),),
          ElevatedButton(onPressed: (){ setState(() => sp1.add( _nameController.text)); }, child: Text('Добавить в список',style: TextStyle(fontSize: 20, color: Colors.indigo))),
          ]))),
 
	Expanded(
        child: Container ( color: Colors.grey[800],   height:380, 
	child: ListView.separated(
            itemCount: sp1.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 10, color: Colors.cyan,  thickness: 2,),
            itemBuilder: (BuildContext context, int index) {
              return Text(index.toString()+'  '+sp1[index], style: TextStyle(fontSize: 16, color: Colors.white));
            }),
       ),),

        Container ( color: Colors.lime,   height:120, 
       child: Center(child:  Column(
        children: [
          ElevatedButton(onPressed: (){ do_Asinc(context,sp1); }, child: Text('Записать в файл (асинхронноая работа)',style: TextStyle(fontSize: 28, color: Colors.red))),
          ElevatedButton(onPressed: (){ setState(() => sp1.removeAt(int.parse( _nameController.text))); }, child: Text('Удалить из списка по номеру',style: TextStyle(fontSize: 20, color: Colors.green))),
          ElevatedButton(onPressed: (){ Navigator.pop(context);}, child: Text('Назад',style: TextStyle(fontSize: 24, color: Colors.blue)))
   ])), 

       ),
    ]
    ),
    );

  }

}


// Процедура асинхронной рвботы методом async - await
Future<void> do_Asinc(BuildContext context, List sp2) async
{

String messageF = await sFile(sp2); // вызов процедуры ваводв списка в файл
_popupDialog(context);              // вызов процедуры вывода сообщения
}


// Процедура асинхронной рвботы методом Future API
void do_Future(BuildContext context, List sp2) 
{
Future<String> messageF = sFile(sp2);                // вызов процедуры ваводв списка в файл
messageF.then((message){_popupDialog(context);});    // вызов процедуры вывода сообщения
}


// Процедура вывода списка в файл
Future<String> sFile(List sp2) 
async
{
String text = "Список  \n";
File file0 = File("test.txt");
await file0.writeAsString(text); //создание файла
for (int i = 0; i < sp2.length; i++)
{
   text=sp2[i]+"\n";   
   await file0.writeAsString(text,mode : FileMode.append); // Добавление в файл одной записи
}
return Future.delayed(Duration(seconds: 3), ()=> "Запись завершена"); // пауза 3 секунды
}

// Процедура вывода сообщения об окончании
void _popupDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Подтверждение записи'),
            content: Text('Запись завершена'),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK')),
            ],
          );
        });
}



void main() {

  runApp(MaterialApp(

    initialRoute: '/',

    routes: {

      '/':(BuildContext context) => MainScreen(),

      '/screen_5':(BuildContext context) => Screen_5(),
      '/screen_6':(BuildContext context) => Screen_6()
     }

  ));

}











