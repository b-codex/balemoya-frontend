import "package:flutter/material.dart";

class JobDetail extends StatelessWidget {
  const JobDetail({Key? key}) : super(key: key);
  static const routeName = '/job_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      drawer: _drawer(context),
    );
  }
}

PreferredSizeWidget _appBar(context) {
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
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
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
              ),
            ],
          ),
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            SizedBox(
              width: 2,
            ),
            Text('Location'),
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
                'Job Type',
                style: TextStyle(
                  fontSize: 13,
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
                '\Salary',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        Row(
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Description'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Company'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Review'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(7),
              padding: EdgeInsets.all(7),
              child: Text(
                'Minimum Qualification',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.'),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
