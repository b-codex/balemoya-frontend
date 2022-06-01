import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({Key? key}) : super(key: key);
  static const routeName = '/search_results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }
}

class SearchCategory {
  final String? category;

  SearchCategory({this.category});
}

PreferredSizeWidget _appBar(context) {
  return AppBar();
}

/// _body() is a function that returns a widget.
///
/// The widget is a SingleChildScrollView widget.
///
/// The SingleChildScrollView widget has a child property that takes a widget.
///
/// The widget is a Column widget.
///
/// The Column widget has a children property that takes a list of widgets.
///
/// The list of widgets is a list of Row widgets.
///
/// The Row widget has a children property that takes a list of widgets.
///
/// The list of widgets is a list of Container widgets.
///
/// The Container widget has a child property that takes a widget.
///
/// The widget is a RichText widget.
///
/// The RichText widget has a text property that takes a TextSpan widget.
///
/// The TextSpan widget has a children property that takes a list of widgets.
///
/// The list of widgets is a list of TextSpan widgets.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A list of widgets.
Widget _body(context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 15,
                right: 7,
                left: 7,
              ),
              // child: Text(
              //   '9 results for: " Programming "',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
              child: RichText(
                text: TextSpan(
                  text: '4 results found for: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Web Developer',
                      style: TextStyle(
                        color: Colors.indigo,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 7,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Filters: '),
              Text('One-time, Addis Ababa'),
            ],
          ),
        ),
        _results(context),
      ],
    ),
  );
}

/// It returns a container with a column of 4 cards.
///
/// Args:
///   context: BuildContext
///
/// Returns:
///   A list of cards.
Widget _results(context) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7,
      vertical: 14,
    ),
    child: Column(
      children: [
        _resultsCard(
          context: context,
          jobTitle: 'ReactJS Web Developer',
          companyName: 'Google',
          jobType: 'One-time',
          salary: '20,000',
          postedDate: '2-22-2022',
          experience: '2+ years',
          location: 'Addis Ababa',
          companyLogo: 'assets/google.jpg',
        ),
        _resultsCard(
          context: context,
          jobTitle: 'ReactJS Web Developer',
          companyName: 'Noob-Dev',
          jobType: 'One-time',
          salary: '15,000',
          postedDate: '2-22-2022',
          experience: '5+ years',
          location: 'Addis Ababa',
          companyLogo: 'assets/profile_picture_placeholder.png',
        ),
        _resultsCard(
          context: context,
          jobTitle: 'HTML, CSS & JS Web Developer',
          companyName: 'New Tech',
          jobType: 'One-time',
          salary: '10,000',
          postedDate: '2-22-2022',
          experience: '4+ years',
          location: 'Addis Ababa',
          companyLogo: 'assets/profile_picture_placeholder.png',
        ),
        _resultsCard(
          context: context,
          jobTitle: 'WordPress Website Developer',
          companyName: 'Private',
          jobType: 'One-time',
          salary: '5,000',
          postedDate: '2-22-2022',
          experience: '0 years',
          location: 'Addis Ababa',
          companyLogo: 'assets/profile_picture_placeholder.png',
        ),
      ],
    ),
  );
}

/// _resultsCard() is a function that returns a GestureDetector widget that contains a Container widget
/// that contains a Card widget that contains a Padding widget that contains a Row widget that contains
/// a Column widget that contains a Container widget that contains a CircleAvatar widget that contains
/// an AssetImage widget.
///
/// Args:
///   context: BuildContext
///   jobTitle (String): String
///   companyName (String): String
///   jobType (String): Full Time, Part Time, Contract, Internship, Temporary
///   salary (String): '$1000',
///   postedDate (String): String
///   experience (String): String
///   location (String): String,
///   companyLogo (String): String
///
/// Returns:
///   A list of widgets.
Widget _resultsCard({
  required context,
  required String jobTitle,
  required String companyName,
  required String jobType,
  required String salary,
  required String postedDate,
  required String experience,
  required String location,
  required String companyLogo,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushNamed('/job_detail');
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      height: 158,
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
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("$companyLogo"),
                    ),
                  ),
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
                        Expanded(
                          child: Text(
                            jobTitle,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            // softWrap: true,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_add),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          companyName,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text('Posted: $postedDate'),
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
                              '$salary ETB/Month',
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
                              experience,
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
                              jobType,
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

/// `buildCard` is a function that takes in a bunch of required parameters and returns a `Container`
/// widget with a `Column` child
///
/// Args:
///   title (String): The title of the job.
///   jobPosition (String): The job position of the job.
///   salary (String): String
///   company (String): String
///   companyLogo (String):
/// https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png
///   location (String): "Addis Ababa, Ethiopia"
///   date (String): String
///   experience (String): String
///
/// Returns:
///   A Container widget with a Column widget as its child.
Widget buildCard({
  required String title,
  required String jobPosition,
  required String salary,
  required String company,
  required String companyLogo,
  required String location,
  required String date,
  required String experience,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.black12,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_add_outlined),
            )
          ],
        ),
        Wrap(
          children: [
            buildChips(jobPosition),
            buildChips("$salary ETB/month"),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: Image.network(companyLogo),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(company),
                    const SizedBox(width: 5),
                    const Icon(Icons.verified, color: Colors.blue),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue.shade900),
                    Text(
                      location,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Posted on: $date",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                buildChips("Experience: $experience Years"),
              ],
            )
          ],
        ),
      ],
    ),
  );
}

/// It returns a Container with a Text child
///
/// Args:
///   text (String): The text to display in the chip.
///
/// Returns:
///   A Container widget with a Text widget as a child.
Widget buildChips(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 3,
      horizontal: 5,
    ),
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Text(text),
  );
}
