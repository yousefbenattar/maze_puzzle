import 'package:flutter/material.dart';
import 'package:maze_puzzle/model/data.dart';

import 'bar.dart';
import 'elmaze.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



    String userName = 'User Name';

  void updateUserName(String newName) {
    setState(() {
      userName = newName;
    });
    debugPrint('User name updated: $newName');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text(""),),
        drawer: SideBar(
        userName: userName,
        onNameUpdated: updateUserName,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          itemCount: dataList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, i) {
              Data data = dataList[i];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> ElMaze( data: data,)));
                },
                child: Card(
                  child: Image(image: AssetImage(dataList[i].img_1)),
                ),
              );
            }),
      ),

    );
  }
  
}
