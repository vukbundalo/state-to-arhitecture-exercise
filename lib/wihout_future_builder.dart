import 'package:flutter/material.dart';

class WithoutFutureBuilder extends StatefulWidget {
  @override
  _WithoutFutureBuilderState createState() => _WithoutFutureBuilderState();
}

class _WithoutFutureBuilderState extends State<WithoutFutureBuilder> {
  List<String> _pageData = List<String>();
  bool isLoading = true;
  //bool get _fetchingData => _pageData == null;
  //We could use _fetching data method instead of isLoading variable but when using
  // _fetching data to check if the future returns a value Circular progress indicator
  //doesn't show up on the screen

  @override
  void initState() {
    // _getListData can return error message, message about no data and actual data
    _getListData(hasError: false, hasData: true).then((data) => setState(() {
          if(data.length == 0){
            data.add('No data found for your account. Please add something and check back');
          }
          _pageData = data;
          isLoading = false;
        })).catchError((error) => setState((){
          _pageData = [error];
          isLoading = false;
    }));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        body: isLoading? //replace with _fetchingData?
        Center(child: CircularProgressIndicator(),):
        //body isLoaded
        ListView.builder(
        itemCount: _pageData.length,
        itemBuilder: (buildContext, index) => _getListItemUI(index),
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



  Widget _getListItemUI(int index) {
    return Container(
      margin: EdgeInsets.all(5.0),
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[600],
      ),
      child: Center(
        child: Text(
          _pageData[index],
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
