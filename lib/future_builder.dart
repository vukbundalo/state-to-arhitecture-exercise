import 'package:flutter/material.dart';

class WithFutureBuilder extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        body: FutureBuilder(
          future: _getListData(),
          builder: (buildContext, snapshot){
            if(snapshot.hasError){
              return _getInformationMessage(snapshot.error);
            }

            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            var listItems = snapshot.data;
            return ListView.builder(
                itemCount: listItems.length,
                itemBuilder: (buildContext, index) => _getListItemUI(index, listItems),
              );
          }
        ),
    );
  }

  Widget _getInformationMessage(String message){
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Future<List<String>> _getListData({
    bool hasError = false,
    bool hasData = true,
      }) async {
    await Future.delayed(Duration(seconds: 2));

    if (hasError){
      return Future.error('An error occurred while fetching the data. Please try again later');
    }

    if(!hasData){
      return List<String>();
    }

    return List<String>.generate(10, (index) => '$index title');

  }



  Widget _getListItemUI(int index, List<String> listItems) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[600],
      ),
      child: Center(
        child: Text(
          listItems[index],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
