import 'package:editable/editable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExamplePageState();
  }
}

class ExamplePageState extends State<ExamplePage> {

  // List rows = [
  //   {
  //     "name": 'James Joe',
  //     "date": '23/09/2020',
  //     "month": 'June',
  //     "status": 'completed'
  //   },
  //   {
  //     "name": 'Daniel Paul',
  //     "month": 'March',
  //     "status": 'new',
  //     "date": '12/4/2020',
  //   },
  //   {
  //     "month": 'May',
  //     "name": 'Mark Zuckerberg',
  //     "date": '09/4/1993',
  //     "status": 'expert'
  //   },
  //   {
  //     "name": 'Jack',
  //     "status": 'legend',
  //     "date": '01/7/1820',
  //     "month": 'December',
  //   },
  // ];
  // List cols = [
  //   {"title": 'Name', 'widthFactor': 0.2, 'key': 'name'},
  //   {"title": 'Date', 'widthFactor': 0.1, 'key': 'date'},
  //   {"title": 'Month', 'widthFactor': 0.1, 'key': 'month'},
  //   {"title": 'Status', 'key': 'status'},
  // ];
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("widget.title"),
  //     ),
  //     body: Editable(
  //       columns: cols,
  //       rows: rows,
  //       zebraStripe: true,
  //       stripeColor2: Colors.grey[200],
  //       onRowSaved: (value) {
  //         print(value);
  //       },
  //       onSubmitted: (value) {
  //         print(value);
  //       },
  //       borderColor: Colors.blueGrey,
  //       showSaveIcon: true,
  //       saveIconColor: Colors.black,
  //       showCreateButton: true,
  //     ),
  //   );
  // }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count, (index) => Container(
        alignment: Alignment.center,
        width: 120.0,
        height: 60.0,
        color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: Text("${index + 1}", style: Theme.of(context).textTheme.title),
      ),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
          (index) => Row(
        children: _buildCells(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRows(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}