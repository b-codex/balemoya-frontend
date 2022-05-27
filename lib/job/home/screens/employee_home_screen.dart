import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

/// The class SearchCategory has a property called category that is of type String and is nullable
class SearchCategory {
  final String? category;

  SearchCategory({this.category});
}

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

Widget employeeScreenBody(context, role) {
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
            'Hey "$role",',
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
        employeeScreenPopularJobs(context),
        SizedBox(
          height: 10,
        ),
        employeeScreenLatestJobs(context),
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

Widget employeeScreenPopularJobs(context) {
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
            children: [
              employeeScreenPopularJobsCard(context),
              employeeScreenPopularJobsCard(context),
              employeeScreenPopularJobsCard(context),
              employeeScreenPopularJobsCard(context),
              employeeScreenPopularJobsCard(context),
              employeeScreenPopularJobsCard(context),
              employeeScreenPopularJobsCard(context),
              employeeScreenPopularJobsCard(context),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget employeeScreenPopularJobsCard(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/job_detail');
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
                          'Company Name',
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
                  Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text(
                      '\Salary',
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
                          'Job Type',
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

Widget employeeScreenLatestJobs(context) {
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
        employeeScreenLatestJobsCard(context),
        employeeScreenLatestJobsCard(context),
        employeeScreenLatestJobsCard(context),
        employeeScreenLatestJobsCard(context),
        employeeScreenLatestJobsCard(context),
      ],
    ),
  );
}

Widget employeeScreenLatestJobsCard(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/job_detail');
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
                          'Job Title',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_add),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Company Name'),
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
                              '\Salary',
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
                              'Experience',
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
                              'Job Type',
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
