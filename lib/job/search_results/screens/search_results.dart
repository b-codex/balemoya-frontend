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
                  text: '9 results found for: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Programming',
                      style: TextStyle(
                        color: Colors.blue,
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

Widget _results(context) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 7,
      vertical: 14,
    ),
    child: Column(
      children: [
        // _resultsCard(context),
        // _resultsCard(context),
        // _resultsCard(context),
        // _resultsCard(context),
        // _resultsCard(context),
        // _resultsCard(context),
        // _resultsCard(context),
        // _resultsCard(context),
        buildCard(
          title: "Senior Database Manager",
          company: "Google",
          companyLogo:
              "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
          location: "Addis Ababa",
          jobPosition: "Full Time",
          salary: "40k",
          date: "2012",
          experience: "2+",
        ),
        buildCard(
          title: "Senior Database Manager",
          company: "Google",
          companyLogo:
              "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
          location: "Addis Ababa",
          jobPosition: "Full Time",
          salary: "40k",
          date: "2012",
          experience: "2+",
        ),
        buildCard(
          title: "Senior Database Manager",
          company: "Google",
          companyLogo:
              "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
          location: "Addis Ababa",
          jobPosition: "Full Time",
          salary: "40k",
          date: "2012",
          experience: "2+",
        ),
        buildCard(
          title: "Senior Database Manager",
          company: "Google",
          companyLogo:
              "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
          location: "Addis Ababa",
          jobPosition: "Full Time",
          salary: "40k",
          date: "2012",
          experience: "2+",
        ),
      ],
    ),
  );
}

Widget _resultsCard(context) {
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
