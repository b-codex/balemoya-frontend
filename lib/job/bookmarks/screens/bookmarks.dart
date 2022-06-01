import 'package:flutter/material.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key? key}) : super(key: key);
  static const routeName = '/bookmarks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      drawer: _drawer(context),
    );
  }
}

/// _appBar() returns an AppBar widget with a title of "Bookmarks" and no actions
///
/// Returns:
///   A widget that is an AppBar with a title and no actions.
PreferredSizeWidget _appBar() {
  return AppBar(
    title: Text("Bookmarks"),
    centerTitle: true,
    actions: [],
  );
}

/// It returns a Drawer widget with a DrawerHeader and a ListTile
///
/// Args:
///   context: The BuildContext of the widget that is calling the method.
///
/// Returns:
///   A Widget
Widget _drawer(context) {
  return Drawer(
    child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              CircleAvatar(
                minRadius: 50,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/google.jpg',
                  width: 100,
                ),
              ),
              Text(
                'User',
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context).pushNamed('/home');
          },
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Account'),
          onTap: () {
            Navigator.of(context).pushNamed('/profile_screen');
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text('Bookmarks'),
          onTap: () {
            Navigator.of(context).pushNamed('/bookmarks');
          },
        ),
        ListTile(
          // leading: Icon(Icons.bookmark),
          title: Text('Create Job Post'),
          onTap: () {
            Navigator.of(context).pushNamed('/create_job_post');
          },
        ),
        Expanded(
          child: Container(),
        ),
        Column(
          children: [
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ],
    ),
  );
}

/// _body() returns a SingleChildScrollView that contains a Column that contains a SizedBox and 6
/// _jobCard() widgets.
///
/// Returns:
///   A widget that is a single child scroll view that contains a column of widgets.
Widget _body() {
  return SingleChildScrollView(
    child: Column(
      children: [
        SizedBox(
          height: 1,
        ),
        _jobCard(),
        _jobCard(),
        _jobCard(),
        _jobCard(),
        _jobCard(),
        _jobCard(),
      ],
    ),
  );
}

/// _jobCard() returns a Container with a Card child, which has a Padding child, which has a Row child,
/// which has a Column child, which has an Image child, which has a Column child, which has a Row child,
/// which has a Text child, which has an IconButton child, which has an Icon child, which has a Row
/// child, which has a Text child, which has a Padding child, which has a Row child, which has a
/// Container child, which has a Text child, which has a Container child, which has a Text child, which
/// has a Container child, which has a Text child.</code>
///
///
///
/// I'm trying to make a job card widget in flutter. I'm new to flutter and I'm trying to learn how to
/// make widgets. I'm trying to make a widget that looks like this:
///
/// I'm trying to make a widget that looks like this:
///
/// I'm trying
///
/// Returns:
///   A Container widget with a Card widget as a child.
Widget _jobCard() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1),
    height: 138,
    child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/google.jpg',
                  height: 100,
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
                        icon: Icon(Icons.bookmark_remove),
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
                              borderRadius: BorderRadius.circular(50)),
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
                            borderRadius: BorderRadius.circular(50),
                          ),
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
  );
}
