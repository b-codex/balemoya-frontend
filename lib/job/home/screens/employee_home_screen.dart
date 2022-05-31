import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// The class SearchCategory has a property called category that is of type String and is nullable
class SearchCategory {
  final String? category;

  SearchCategory({this.category});
}

/// It displays a dialog with a search bar and a list of items. The user can select multiple items from
/// the list and click on the apply button to get the selected items
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A list of SearchCategory objects.
PreferredSizeWidget employeeScreenAppBar(context) {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () {
          List<SearchCategory> searchCategories = [
            SearchCategory(category: 'One-time'),
            SearchCategory(category: 'Contractual'),
            SearchCategory(category: 'Full-time'),
          ];
          List<SearchCategory> selectedUserList = [];
          String queryString = "";
          FilterListDialog.display<SearchCategory>(
            context,
            listData: searchCategories,
            selectedListData: selectedUserList,
            choiceChipLabel: (category) => category!.category,
            validateSelectedItem: (list, val) => list!.contains(val),
            onItemSearch: (category, query) {
              // print(query);
              queryString = query;
              return true;
              // return category.category!
              //     .toLowerCase()
              //     .contains(query.toLowerCase());
            },
            onApplyButtonClick: (list) {
              selectedUserList = List.from(list!);
              selectedUserList.forEach((c) => print(c.category));
              print(queryString);
              Navigator.pop(context);
            },
          );
        },
        icon: Icon(Icons.search),
      )
    ],
  );
}

/// It returns a SingleChildScrollView with a Column as its child.
///
/// The Column has a Container with a Text widget as its child.
///
/// The Text widget has a String as its child.
///
/// The String is a variable.
///
/// The variable is a parameter of the function.
///
/// The function is a parameter of the widget.
///
/// The widget is a parameter of the function.
///
/// The function is a parameter of the widget.
///
/// The widget is a parameter of the function.
///
/// The function is a parameter of the widget.
///
/// The widget is a parameter of the function.
///
/// The function is a parameter of the widget.
///
/// The widget is a parameter of the function.
///
/// The function is a parameter of the widget.
///
/// The widget is a parameter of the function.
///
/// The function is a parameter of the widget.
///
/// Args:
///   context: BuildContext
///   role: String
///
/// Returns:
///   A widget.
Widget employeeScreenBody(context, role, fullName, jobs) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 8,
          ),
          child: Text(
            'Hey "$fullName",',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        // Container(
        //   margin: EdgeInsets.only(
        //     top: 15,
        //     bottom: 30,
        //     left: 20,
        //     right: 20,
        //   ),
        //   child: employeeScreenSearchField(context),
        // ),
        employeeScreenPopularJobs(context, jobs),
        SizedBox(
          height: 10,
        ),
        employeeScreenLatestJobs(context, jobs),
      ],
    ),
  );
}

// Widget employeeScreenSearchField(context) {
//   GlobalKey<FormState> employeeScreenFormKey = GlobalKey();

//   return Form(
//     key: employeeScreenFormKey,
//     child: Container(
//       child: TextFormField(
//         decoration: InputDecoration(
//           suffixIcon: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.auto_fix_high),
//           ),
//           labelText: 'Search',
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ),
//         validator: (value) {
//           // print(value);
//           return '';
//         },
//         onChanged: (value) {
//           // print(value);
//         },
//       ),
//     ),
//   );
// }

/// It returns a container with a column with a row with a text and a text button, and a single child
/// scroll view with a row with a bunch of cards.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Container widget with a Column widget as its child.
Widget employeeScreenPopularJobs(context, jobs) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 8,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Jobs",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: jobs.map<Widget>((job) {
              final postedDate = DateFormat.yMMMMd().format(
                DateTime.parse(
                  job['createdAt'],
                ),
              );
              return employeeScreenPopularJobsCard(
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
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

/// This function returns a card widget that has a gesture detector that navigates to a new page when
/// tapped.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A widget that is a container with a card inside of it.
Widget employeeScreenPopularJobsCard({
  required context,
  required String id,
  required String jobTitle,
  required String companyName,
  required String salary,
  required String qualification,
  required String jobType,
  required String description,
  required String companySize,
  required List tag,
  required String location,
  required String requirements,
  required String postedDate,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/job_detail', arguments: {
        "id": id,
        "jobTitle": jobTitle,
        "companyName": companyName,
        "salary": salary,
        "qualification": qualification,
        "jobType": jobType,
        "companySize": companySize,
        "description": description,
        "location": location,
        "tag": tag,
        "requirements": requirements,
        "postedDate": postedDate,
      });
    },
    child: Container(
      height: 215,
      width: 300,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage('assets/profile_picture_placeholder.png'),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$companyName',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                        Text(
                          '$location',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text(
                      '$jobTitle',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text(
                      '$salary Birr/Month',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 218, 218),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '$jobType',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 223, 218, 218),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          '$qualification',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

/// It returns a container with a column inside it. The column has a row inside it. The row has a text
/// and a text button inside it. The column also has a sized box and 5 cards inside it.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Container widget with a Column widget as its child.
Widget employeeScreenLatestJobs(context, jobs) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Latest Jobs",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ],
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

            // print(postedDate);
            return employeeScreenLatestJobsCard(
              context: context,
              id: job['_id'],
              jobTitle: job['jobTitle'],
              companyName: job['companyName'],
              salary: job['salary'],
              qualification: job['qualification'],
              jobType: job['jobType'],
              companySize: job['companySize'],
              description: job['description'],
              location: job['location'],
              tag: job['tag'],
              requirements: job['requirements'],
              postedDate: postedDate,
            );
          }).toList(),
        ),
      ],
    ),
  );
}

/// It returns a GestureDetector that contains a Container that contains a Card that contains a Padding
/// that contains a Row that contains a Column that contains a Container that contains a CircleAvatar
/// that contains an AssetImage.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A widget.
Widget employeeScreenLatestJobsCard({
  required context,
  required String id,
  required String jobTitle,
  required String companyName,
  required String salary,
  required String qualification,
  required String jobType,
  required String description,
  required String companySize,
  required List tag,
  required String location,
  required String requirements,
  required String postedDate,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/job_detail', arguments: {
        "id": id,
        "jobTitle": jobTitle,
        "companyName": companyName,
        "salary": salary,
        "qualification": qualification,
        "jobType": jobType,
        "companySize": companySize,
        "description": description,
        "location": location,
        "tag": tag,
        "requirements": requirements,
        "postedDate": postedDate,
      });
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      height: 138,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage('assets/profile_picture_placeholder.png'),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '$jobTitle',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(Icons.bookmark_add),
                        // ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('$companyName'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 223, 218, 218),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '$salary Birr/Month',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 223, 218, 218),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              'qualification',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 223, 218, 218),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              '$jobType',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
