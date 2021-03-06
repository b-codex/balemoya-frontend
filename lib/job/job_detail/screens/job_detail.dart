import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:balemoya/chat/bloc/chat_bloc.dart';
import 'package:balemoya/chat/models/models.dart';
import 'package:balemoya/chat/provider/provider.dart';
import 'package:balemoya/chat/screens/chat_detail_page.dart';
import 'package:balemoya/chat/screens/chat_page.dart';
import 'package:balemoya/job/job_detail/bloc/job_detail_bloc.dart';
import 'package:balemoya/job/job_detail/models/model.dart';
import 'package:balemoya/job/job_detail/screens/edit_job_post.dart';
import 'package:balemoya/static/widgets/snack_bar.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../static/shared_preference.dart';
import '../../home/bloc/home_bloc.dart';
import '../data_provider/provider.dart';

class JobDetail extends StatelessWidget {
  /// Declaring a variable called job and assigning it a value of a map.
  final Map job;
  const JobDetail({Key? key, required this.job}) : super(key: key);

  /// A static variable that is used to identify the route.
  static const routeName = '/job_detail';

  @override
  Widget build(BuildContext context) {
    late String token;
    String receiverID = job['postedBy'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          /// The above code is showing a popup menu button with a list of options.
          PopupMenuButton(
            child: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  value: 'Start Chat With User',
                  child: Text(
                    'Start Chat With User',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ];
            },
            onSelected: (clicked) async {
              if (clicked == 'Start Chat With User') {
                final bloc = BlocProvider.of<ChatBloc>(context);
                bloc.add(
                  StartChat(
                    createConversationModel: CreateConversationModel(
                      senderID: ChatPage.getCurrentUser(),
                      receiverID: receiverID,
                      token: token,
                    ),
                  ),
                );
                print('posted by id is ${job['postedBy']}');
                var chatWith = await ChatProvider.getName(
                    getNameModel: GetNameModel(
                  receiverID: job['postedBy'],
                  token: token,
                ));

                print('chatWith is $chatWith');

                var cID = await ChatProvider.startChat(
                  createConversationModel: CreateConversationModel(
                    senderID: ChatPage.getCurrentUser(),
                    receiverID: receiverID,
                    token: token,
                  ),
                );

                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                      chatWith: chatWith ?? '',
                      sID: ChatPage.getCurrentUser() ?? '',
                      cID: cID['_id'] ?? '',
                      token: token,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: SharedPreference().getSession(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred'),
              );
            } else {
              token = dataSnapshot.data[1];
              return _body(context, job, dataSnapshot.data![3]);
            }
          }
        },
      ),
      // body: _body(context, job),
      // bottomSheet: _applyButton(context),
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
Widget _body(context, job, userId) {
  List reviews = [];
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 10),
      _header(context, job),
      // _tabBar(context),
      _req(job),

      _reviewSection(reviews: reviews, role: job['role'], jobID: job['id']),
      _applyButton(context, job),
      userId == job["postedBy"]
          ? TextButton(
              onPressed: () async {
                final sessionID = await SharedPreference().getSession().then(
                  (value) {
                    return value;
                  },
                );
                var res = await JobDetailProvider()
                    .deleteJob(sessionID: sessionID[1], jobId: job["id"]);
                if (res == true) {
                  final bloc = BlocProvider.of<HomeBloc>(context);
                  bloc.add(GetJobPosts());
                  Navigator.of(context).pop();
                } else {
                  animatedSnackBar(
                    context: context,
                    message: "Job couldn't be deleted",
                    animatedSnackBarType: AnimatedSnackBarType.error,
                  );
                }
              },
              child: Text("Delete Job Post"))
          : Container(),
      userId == job["postedBy"]
          ? TextButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return EditJobPost(
                        id: job["_id"],
                        companyName: job['companyName'],
                        location: job['location'],
                        salary: job['salary'],
                        shortDescription: job['shortDescription'],
                        requirements: job['requirements'],
                        qualification: job['qualification'],
                        jobTitle: job['jobTitle'],
                        tag: job['tag'],
                        companySize: job['companySize'],
                        jobType: job['jobType'],
                      );
                    },
                  ),
                );
              },
              child: Text("Edit Job Post"))
          : Container()
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
Widget _header(context, job) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // _backButton(context),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _profilePicture(),
          _info(job),
        ],
      ),
      _shortDescription(job),
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
// ignore: unused_element
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
                // _reviewSection(),
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
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
    'This is a requirement',
  ];

  return Builder(
    builder: (context) {
      return ListView.builder(
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
      );
    },
  );
}

/// _req() is a function that takes a job as an argument and returns a widget that displays the job's
/// requirements
///
/// Args:
///   job: is a Map&lt;String, dynamic&gt;
///
/// Returns:
///   A list of jobs.
Widget _req(job) {
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
            title: RichText(
              text: TextSpan(
                text: "Requirements: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
                children: [
                  TextSpan(
                    text: '${job["requirements"]}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
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
Widget _applyButton(context, job) {
  return BlocConsumer<JobDetailBloc, JobDetailState>(
    listener: (context, state) {
      /// Checking if the state is AppliedToJobPost, if it is, it will show a snackbar.
      if (state is AppliedToJobPost) {
        animatedSnackBar(
            context: context,
            message: "Application Sent.",
            animatedSnackBarType: AnimatedSnackBarType.success);
      }

      /// Checking if the state is NotAppliedToJobPost, if it is, it will show an error message.
      if (state is NotAppliedToJobPost) {
        animatedSnackBar(
          context: context,
          message: "Task Failed. Please Try Again.",
          animatedSnackBarType: AnimatedSnackBarType.error,
        );
      }
    },
    builder: (context, state) {
      /// Checking if the role of the user is employer, if it is, it will return an empty container.
      if (job["role"] == "employer") {
        return Container();
      }
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
            final _formKey = GlobalKey<FormState>();
            final TextEditingController _emailController =
                TextEditingController();
            final TextEditingController _phoneNumberController =
                TextEditingController();
            final TextEditingController _messageController =
                TextEditingController();

            final AlertDialog _addReference = AlertDialog(
              title: Text('Confirm Your Information...'),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: Text("Email"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // maxLines: null,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 9),
                      TextFormField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          label: Text("Phone Number"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // maxLines: null,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 9),
                      TextFormField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          label: Text("Message"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        // maxLines: null,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field can\'t be empty.';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 9),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      final jobDetailBloc =
                          BlocProvider.of<JobDetailBloc>(context);

                      jobDetailBloc.add(
                        ApplyToJobPostEvent(
                          applyJobPostModel: ApplyJobPostModel(
                              email: _emailController.text.trim(),
                              phoneNumber: _phoneNumberController.text.trim(),
                              text: _messageController.text.trim(),
                              jobID: job['id']),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
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
              builder: (_) {
                return _addReference;
              },
            );
          },
          child: Text('Apply'),
        ),
      );
    },
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
      radius: 50,
      backgroundImage: AssetImage(
        "assets/profile_picture_placeholder.png",
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
Widget _info(job) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${job["jobTitle"]}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on),
          SizedBox(width: 2),
          Text('${job["location"]}'),
        ],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _pill(text: "${job['jobType']}"),
          _pill(text: "${job['salary']} Birr/Month"),
          // _pill(text: "${job['tag']}"),
          // _pill(text: "Company Size: ${job['companySize']}"),
        ],
      ),
      SizedBox(height: 7),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // _pill(text: "${job['jobType']}"),
          // _pill(text: "${job['salary']}"),
          _pill(text: "${job['tag'][0]}"),
          _pill(text: "Company Size: ${job['companySize']}"),
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
Widget _shortDescription(job) {
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
            title: RichText(
              text: TextSpan(
                text: "Description: ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                ),
                children: [
                  TextSpan(
                    text: '\n${job["description"]}\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: GoogleFonts.montserrat().fontFamily,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Text(
              'Posted Date: ${job["postedDate"]}\nPosted By: ${job["companyName"]}',
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
Widget _reviewSection({
  required List reviews,
  required String role,
  required String jobID,
}) {
  // return Builder(builder: (context) {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.5,
  //     child: ListView.builder(
  //       itemBuilder: (context, index) {
  //         return _singleReview();
  //       },
  //     ),
  //   );
  // });

  TextEditingController _reviewController = TextEditingController();

  return Expanded(
    child: Container(
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Reviews",
                style: TextStyle(fontSize: 20),
              ),
            ),
            _reviewField(
                role: role, reviewController: _reviewController, jobID: jobID),
            Column(
              children: reviews.map<Widget>((review) {
                return _singleReview();
              }).toList(),
            )
          ],
        ),
      ),
    ),
  );
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
        radius: 35,
        backgroundImage: AssetImage("assets/profile_picture_placeholder.png"),
      ),
      title: Text("Name"),
      subtitle: Text("Comment Here..."),
    ),
  );
}

/// If the role is employer, return an empty container. Otherwise, return a form with a text field and a
/// button
///
/// Args:
///   role (String): This is the role of the user.
///   reviewController (TextEditingController): TextEditingController()
///   jobID (String): The ID of the job that the user is reviewing.
///
/// Returns:
///   A function that returns a widget.
Widget _reviewField({
  required String role,
  required TextEditingController reviewController,
  required String jobID,
}) {
  if (role == "employer") {
    return Container();
  }

  final _formKey = GlobalKey<FormState>();
  return Form(
    key: _formKey,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          TextFormField(
            controller: reviewController,
            decoration: InputDecoration(
              hintText: "Leave your review",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            // maxLines: null,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field can\'t be empty.';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 7),
          Builder(builder: (context) {
            return Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  final review = BlocProvider.of<JobDetailBloc>(context);
                  if (_formKey.currentState!.validate()) {
                    review.add(
                      PostReviewEvent(
                        postReviewModel: PostReviewModel(
                          fullName: 'fullName',
                          review: reviewController.text.trim(),
                          jobID: jobID,
                        ),
                      ),
                    );
                  }
                },
                child: Text("Post"),
              ),
            );
          })
        ],
      ),
    ),
  );
}
