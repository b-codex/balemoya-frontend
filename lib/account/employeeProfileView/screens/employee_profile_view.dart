import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import 'package:flutter/material.dart';

class EmployeeProfileView extends StatelessWidget {
  const EmployeeProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      bottomSheet: _messageButton(context: context),
    );
  }
}

PreferredSizeWidget _appBar(context) {
  return AppBar(
    actions: [
      PopupMenuButton(
        child: Icon(Icons.more_vert),
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              value: 'Report Account',
              child: Text(
                'Report Account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ];
        },
        onSelected: (clicked) async {
          if (clicked == 'Report Account') {
            final TextEditingController _controller = TextEditingController();
            final _formKey = GlobalKey<FormState>();
            var _alertDialog = AlertDialog(
              title: Text('Are you sure you want to report this account?'),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    label:
                        Text("What is your reason for reporting this account?"),
                    // prefixIcon: _prefixIcon,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field can\'t be empty.';
                    }
                    if (value.length < 10) {
                      return 'Please write more...';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      animatedSnackBar(
                        context: context,
                        message: "Account Reported",
                        animatedSnackBarType: AnimatedSnackBarType.success,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Submit'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return _alertDialog;
              },
            );
          }
        },
      ),
    ],
  );
}

Widget _body(context) {
  String portfolioText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dignissim hendrerit arcu, ut malesuada leo congue id. Nullam pulvinar ligula eu justo sollicitudin, sit amet.';

  List<String> skills = ['flutter', 'web development', 'backend development'];
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _profilePicture(),
        _name(),
        _location(),
        _portfolio(context, portfolioText, skills),
        // _uploadCV(),
      ],
    ),
  );
}

Widget _profilePicture() {
  return Center(
    child: Container(
      margin: EdgeInsets.only(
        top: 20,
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
        backgroundImage: AssetImage('assets/profile_picture_placeholder.png'),
      ),
    ),
  );
}

Widget _name() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          'User\'s Name',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    ],
  );
}

Widget _location() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.location_on),
      SizedBox(width: 7),
      Container(
        margin: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          'Location',
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ),
    ],
  );
}

Widget _portfolio(context, portfolioText, List<String> skills) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Portfolio',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 7,
              ),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$portfolioText',
                overflow: TextOverflow.clip,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 7),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Skills',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 240, 240),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: skills.map(
            (skillText) {
              return _skill(skillText);
            },
          ).toList(),
        ),
      ),
    ],
  );
}

Widget _skill(skillText) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 7),
    child: ListTile(
      leading: Icon(Icons.check),
      title: Text('$skillText'),
    ),
  );
}

Widget _messageButton({required context}) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 7,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, 50),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.message),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
          Text('Message'),
        ],
      ),
    ),
  );
}
