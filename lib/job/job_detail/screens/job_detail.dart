import "package:flutter/material.dart";

class JobDetail extends StatelessWidget {
  const JobDetail({Key? key}) : super(key: key);

  /// A static variable that is used to identify the route.
  static const routeName = '/job_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(context),
      bottomSheet: _applyButton(context),
    );
  }
}

/// _body() returns a Column widget that contains a _header() widget and a _tabBar() widget
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Column widget with two children.
Widget _body(context) {
  return Column(
    children: [
      SizedBox(height: 5),
      _header(context),
      _tabBar(context),
    ],
  );
}

/// _header() returns a Column widget that contains a Row widget that contains a _profilePicture()
/// widget and a _info() widget, and a _shortDescription() widget.
/// 
/// Args:
///   context: BuildContext
/// 
/// Returns:
///   A Column widget with a Row widget and a Text widget as children.
Widget _header(context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // _backButton(context),
      Row(
        children: [
          _profilePicture(),
          _info(),
        ],
      ),
      _shortDescription(),
    ],
  );
}

/// _tabBar() is a function that returns a DefaultTabController widget that contains a Container widget
/// that contains a Column widget that contains a TabBar widget and an Expanded widget that contains a
/// TabBarView widget that contains two widgets: _requirementsList() and _reviewSection()
/// 
/// Args:
///   context: BuildContext
/// 
/// Returns:
///   A DefaultTabController with a Container with a Column with a TabBar and an Expanded with a
/// TabBarView.
Widget _tabBar(context) {
  return DefaultTabController(
    length: 2,
    child: Container(
      height: MediaQuery.of(context).size.height * 0.648,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Requirements",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Review",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // 1st tab which contains a list of job requirements
                _requirementsList(),

                // 2nd tab which contains a list of reviews
                _reviewSection(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// _requirementsList() returns a SizedBox widget that has a height of half the screen height, and a
/// ListView.builder widget as its child. The ListView.builder widget has a scrollDirection of
/// Axis.vertical, and an itemCount of the length of the requirements list. The itemBuilder function
/// returns a Container widget that has a margin of 7 pixels on the vertical axis, and a ListTile widget
/// as its child. The ListTile widget has an Icon widget as its leading widget, and a Text widget as its
/// subtitle widget. The Text widget has a string interpolation of the requirements list at the index of
/// the itemBuilder function
///
/// Returns:
///   A widget that is a sized box with a list view builder.
Widget _requirementsList() {
  final requirements = [
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement9',
    'This is a requirement',
    'This is a requirement',
  ];

  return Builder(
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: requirements.length,
          itemBuilder: ((context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                title: Text(
                  '${requirements[index]}',
                ),
              ),
            );
          }),
        ),
      );
    },
  );
}

/// _applyButton() is a function that returns a Container widget that contains an ElevatedButton widget
/// that has a TextButton widget as its child
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A Container widget with a child of an ElevatedButton widget.
Widget _applyButton(context) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 7,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
      ),
      onPressed: () {
        var _alertDialog = AlertDialog(
          title: Text('Confirm'),
          content: Text('Apply to this job post?'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return _alertDialog;
          },
        );
      },
      child: Text('Apply'),
    ),
  );
}

/// _profilePicture() returns a Container widget that has a CircleAvatar widget as its child
///
/// Returns:
///   A Container widget with a CircleAvatar widget as a child.
Widget _profilePicture() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 15,
    ),
    padding: EdgeInsets.all(3),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.indigo,
      ),
      borderRadius: BorderRadius.circular(100),
    ),
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          'assets/google.jpg',
          height: 90,
        ),
      ),
    ),
  );
}

/// _info() returns a Column widget that contains a Row widget that contains a Text widget that
/// contains the text 'Job Title' and a SizedBox widget that contains a Row widget that contains an
/// Icon widget that contains the icon Icons.location_on and a SizedBox widget that contains a Text
/// widget that contains the text 'Location' and a SizedBox widget that contains a Row widget that
/// contains a Row widget that contains a _pill() widget that contains the text 'Job Type' and a
/// _pill() widget that contains the text 'Salary'
///
/// Returns:
///   A Column widget with 3 rows.
Widget _info() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Job Title',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on),
          SizedBox(width: 2),
          Text('Location'),
        ],
      ),
      SizedBox(height: 5),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              _pill(text: "Job Type"),
              _pill(text: "Salary"),
            ],
          ),
        ],
      ),
    ],
  );
}

/// _pill() is a function that returns a Container widget with a BoxDecoration and a Text widget as its
/// child
///
/// Args:
///   text (String): The text to be displayed in the pill.
///
/// Returns:
///   A Container widget with a BoxDecoration and a Text widget.
Widget _pill({required String text}) {
  return Container(
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
      '$text',
      style: TextStyle(
        fontSize: 13,
      ),
    ),
  );
}

/// _backButton() is a function that returns a GestureDetector widget that contains a Container widget
/// that contains an Icon widget
///
/// Args:
///   context: The context of the widget.
///
/// Returns:
///   A widget that is a container with a child that is an icon.
// ignore: unused_element
Widget _backButton(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Container(
      // decoration: BoxDecoration(color: Colors.lightBlue),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.035,
      ),
      padding: EdgeInsets.only(
        top: 7,
        bottom: 7,
        left: 10,
        right: 10,
      ),
      alignment: Alignment.topLeft,
      child: Icon(
        Icons.arrow_back,
      ),
    ),
  );
}

/// _shortDescription() returns a Row widget that contains an Expanded widget that contains a Container
/// widget that contains a ListTile widget
///
/// Returns:
///   A Row widget with a single Expanded widget with a Container widget with a ListTile widget.
Widget _shortDescription() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.all(7),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            title: Text(
              'Short Description',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            trailing: Text(
              'Posted Date',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

/// _reviewSection() is a function that returns a widget that is a SizedBox that has a height of half
/// the screen height and a ListView.builder that has a single child that is a _singleReview() function
///
/// Returns:
///   A SizedBox with a ListView.builder inside of it.
Widget _reviewSection() {
  return Builder(builder: (context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _singleReview();
        },
      ),
    );
  });
}

/// _singleReview() returns a Container widget that contains a ListTile widget
///
/// Returns:
///   A Container widget with a ListTile widget as its child.
Widget _singleReview() {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 5,
      horizontal: 7,
    ),
    child: ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage("assets/google.jpg"),
      ),
      title: Text("Name"),
      subtitle: Text("Comment Here..."),
    ),
  );
}
