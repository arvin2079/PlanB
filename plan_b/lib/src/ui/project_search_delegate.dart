import 'package:flutter/material.dart';
import 'package:planb/src/ui/uiComponents/projectCard.dart';

class ProjectSearchDelegate extends SearchDelegate{


  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: <Widget>[
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/no_result_project.png"),
          Text("!نتیجه ای یافت نشد", style: Theme.of(context).textTheme.headline1,),
        ],
      ),
    );
  }

}