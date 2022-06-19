import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../static/shared_preference.dart';
import '../../home/data_provider/provider.dart';
import '../../home/screens/employer_home_screen.dart';

class SearchResults extends StatefulWidget {
  final Map leParams;
  SearchResults({Key? key, required this.leParams}) : super(key: key);
  static const routeName = '/search_results';
  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late String role;
  late Future searchResult;
  dynamic getSearchResults() async {
    final sessionID = await SharedPreference().getSession().then(
      (value) {
        return value;
      },
    );
    role = sessionID[3];
    var res = await JobSearchProvider().searchJob(
        sessionID: sessionID,
        query: widget.leParams["query"],
        jobType: widget.leParams["jobType"]);
    if (res["success"] == false) {
      throw "Faild to fetch reults";
    } else {
      return jsonDecode(res["data"]);
    }
  }

  @override
  void initState() {
    super.initState();
    searchResult = getSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    // searchResult = getSearchResults();
    return Scaffold(
        appBar: _appBar(context),
        body: FutureBuilder<dynamic>(
          future: searchResult,
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An error occured'),
                );
              }
              if (dataSnapshot.data.length == 0) {
                return Center(child: Text("No results found"));
              } else {
                return _body(context, dataSnapshot.data, widget.leParams, role);
              }
            }
          },
        ));
  }
}

class SearchCategory {
  final String? category;

  SearchCategory({this.category});
}

PreferredSizeWidget _appBar(context) {
  return AppBar();
}

Widget _body(context, jobs, params, role) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 15,
                right: 7,
                left: 7,
              ),
              child: RichText(
                text: TextSpan(
                  text: '${jobs.length} results found for: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: params["query"],
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 7,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Filters: '),
              ...params["jobType"].map((e) => Text(e + ", ")),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          children: jobs.map<Widget>((job) {
            final postedDate = DateFormat.yMMMMd().format(
              DateTime.parse(
                job['createdAt'],
              ),
            );
            return employerScreenJobsCard(
                context: context,
                id: job["_id"],
                jobTitle: job["jobTitle"],
                companyName: job["companyName"],
                salary: job["salary"],
                qualification: job["qualification"],
                jobType: job["jobType"],
                description: job["description"],
                companySize: job["companySize"],
                tag: job["tag"],
                location: job["location"],
                requirements: job["requirements"],
                postedDate: postedDate,
                role: role,
                postedBy: job["postedBy"]);
          }).toList(),
        ),
      ],
    ),
  );
}
