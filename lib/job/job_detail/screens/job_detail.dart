import "package:flutter/material.dart";

class JobDetail extends StatelessWidget {
  const JobDetail({Key? key}) : super(key: key);
  static const routeName = '/job_detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }
}

PreferredSizeWidget _appBar(context) {
  return AppBar();
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
            // Apply Button
            _applyButton(context),
          ],
        ),
      ],
    ),
  );
}

Widget _applyButton(context) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 7,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(400, 50),
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
              onPressed: () {},
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
