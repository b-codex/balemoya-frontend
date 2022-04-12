import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _drawer(context),
      body: _body(context),
    );
  }
}

PreferredSizeWidget _appBar() {
  return AppBar(
    actions: [
      IconButton(
        onPressed: () {
          // redirect to profile page
        },
        icon: Image.asset('assets/start_screen.png'),
      )
    ],
  );
}

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
                  'assets/start_screen.png',
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
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: Text('Bookmarks'),
          onTap: () {
            Navigator.of(context).pushNamed('/bookmarks');
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

Widget _body(context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 15,
            left: 15,
          ),
          child: Text(
            'Hey "User",',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 15,
            bottom: 30,
            left: 20,
            right: 20,
          ),
          child: _searchField(),
        ),
        _popularJobs(context),
        SizedBox(
          height: 10,
        ),
        _latestJobs(context),
      ],
    ),
  );
}

Widget _searchField() {
  GlobalKey<FormState> _formKey = GlobalKey();

  return Form(
    key: _formKey,
    child: Container(
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.auto_fix_high),
          ),
          labelText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        validator: (value) {
          print(value);
          return '';
        },
        onChanged: (value) {
          print(value);
        },
      ),
    ),
  );
}

Widget _popularJobs(context) {
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
              _popularJobsCard(context),
              _popularJobsCard(context),
              _popularJobsCard(context),
              _popularJobsCard(context),
              _popularJobsCard(context),
              _popularJobsCard(context),
              _popularJobsCard(context),
              _popularJobsCard(context),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _popularJobsCard(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/job_detail');
      print('popular jobs');
    },
    child: Container(
      height: 210,
      width: 250,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/start_screen.png',
                    height: 100,
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
                  Text(
                    'Job Title',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$ Money',
                    style: TextStyle(
                      fontSize: 13,
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

Widget _latestJobs(context) {
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
        _latestJobsCard(context),
        _latestJobsCard(context),
        _latestJobsCard(context),
        _latestJobsCard(context),
        _latestJobsCard(context),
      ],
    ),
  );
}

Widget _latestJobsCard(context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/job_detail');
      print('latest jobs');
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
                children: [
                  Image.asset(
                    'assets/start_screen.png',
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
                              '\$ Money',
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