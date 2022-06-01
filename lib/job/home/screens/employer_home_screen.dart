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
PreferredSizeWidget employerScreenAppBar(context) {
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
              queryString = query;
              return true;
              // return category.category!
              //     .toLowerCase()
              //     .contains(query.toLowerCase());
            },
            onApplyButtonClick: (list) {
              selectedUserList = List.from(list!);
              // selectedUserList.forEach((c) => print(c.category));
              // print(queryString);
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
/// The Column has a Container and a SizedBox as its children.
///
/// The Container has a Text widget as its child.
///
/// The Text widget has a String as its child.
///
/// The SizedBox has no children.
///
/// The SingleChildScrollView has a Column as its child.
///
/// The Column has a Container and a SizedBox as its children.
///
/// The Container has a Text widget as its child.
///
/// The Text widget has a String as its child.
///
/// The SizedBox has no children.
///
/// The SingleChildScrollView has a Column as its child.
///
/// The Column has a Container and a SizedBox as its children.
///
/// The Container has a Text widget as its child.
///
/// The Text widget has a String as its child.
///
/// Args:
///   context: BuildContext
///   role: String
///
/// Returns:
///   A widget.
Widget employerScreenBody(context, role, jobs) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   margin: EdgeInsets.only(
        //     top: 15,
        //     left: 8,
        //   ),
        //   child: Text(
        //     'Hey "$fullName",',
        //     textAlign: TextAlign.left,
        //     style: TextStyle(
        //       fontSize: 24,
        //     ),
        //   ),
        // ),
        
        SizedBox(
          height: 10,
        ),
        employerScreenPostedJobs(context, jobs, role),
      ],
    ),
  );
}

/// It returns a container with a column with a row with a text and a text button, and a single child
/// scroll view with a row with a bunch of cards.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Container widget with a Column widget as its child.
Widget employerScreenPopularUsers(context) {
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
              "Popular Users",
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
            children: [
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
              employerScreenPopularUsersCard(context),
            ],
          ),
        ),
      ],
    ),
  );
}

/// This function returns a card that displays a user's profile picture, name, location, job title, and
/// experience.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A widget that is a container with a card inside of it.
Widget employerScreenPopularUsersCard(context) {
  return GestureDetector(
    onTap: () {
      // Navigator.of(context).pushNamed('/job_detail');
    },
    child: Container(
      height: 205,
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
                          'User\'s Name',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                        Text(
                          'Location',
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
                      'Job Title',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          'Experience',
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

/// It returns a container with a column inside it. The column has a row with two children, a text and a
/// text button. Then there's a sized box, and then five cards.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A widget.
Widget employerScreenPostedJobs(context, jobs, role) {
  
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
              "Posted Jobs",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'See all',
            //     style: TextStyle(
            //       fontSize: 13,
            //     ),
            //   ),
            // ),
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
            );
          }).toList(),
        ),
      ],
    ),
  );
}

/// It returns a GestureDetector widget that contains a Container widget that contains a Card widget
/// that contains a Padding widget that contains a Row widget that contains a Column widget that
/// contains a Container widget that contains an Image widget.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A widget.
Widget employerScreenJobsCard({
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
  required String role,
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
        "role" : role,
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
                      backgroundImage: AssetImage(
                        'assets/profile_picture_placeholder.png',
                      ),
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
                              '$salary',
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
                              '$companySize',
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
