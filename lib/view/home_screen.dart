import 'package:flutter/material.dart';
import 'package:apod/model/service.dart';
import 'package:date_time_picker/date_time_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Service serve = Service();
  Future _date;
  String intialDate;
  String searchedDate;
  final DateTime currentDate = DateTime.now();

  @override
  void initState() {
    _date = serve.getDetails('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.blue[100],
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Astronomy Picture of the Day',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Select Date :',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: 300,
                    child: DateTimePicker(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0)),
                      ).copyWith(hintText: 'Select Date'),
                      type: DateTimePickerType.date,
                      dateMask: 'yyyy-MM-dd',
                      //controller: _c,
                      initialValue: currentDate.toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onChanged: (val) => setState(() {
                        searchedDate = val;
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                    child: Text(
                      'Find APOD',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    onPressed: () {
                      setState(() {
                        _date = serve.getDetails(searchedDate);
                      });

                      print(searchedDate);
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                    future: _date,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              snapshot.data['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data['date'],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Image.network(
                              snapshot.data['url'],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data['explanation'],
                              style: TextStyle(
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
