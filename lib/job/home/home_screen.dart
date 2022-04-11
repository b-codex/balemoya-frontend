import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      drawer: _drawer(),
      body: _body(),
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

Widget _drawer() {
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
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('1'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text('2'),
          onTap: () {},
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

Widget _body() {
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
        _popularJobs(),
        SizedBox(
          height: 10,
        ),
        _latestJobs(),
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

Widget _popularJobs() {
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
              _popularJobsCard(),
              _popularJobsCard(),
              _popularJobsCard(),
              _popularJobsCard(),
              _popularJobsCard(),
              _popularJobsCard(),
              _popularJobsCard(),
              _popularJobsCard(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _popularJobsCard() {
  return Container(
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
                Container(
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
            )
          ],
        ),
      ),
    ),
  );
}

Widget _latestJobs() {
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
        _latestJobsCard(),
        _latestJobsCard(),
        _latestJobsCard(),
        _latestJobsCard(),
        _latestJobsCard(),
      ],
    ),
  );
}

Widget _latestJobsCard() {
  return Container(
    height: 128,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Job Title',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        overflow: TextOverflow.visible,
                        softWrap: true,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Company Name'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  )
                ],
              ),
            ],
          )),
    ),
  );
}
