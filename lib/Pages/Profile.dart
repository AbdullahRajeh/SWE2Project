import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String Fname = '';
  String Lname = '';
  String user = '';
  String email = '';
  String phone = '';
  bool isTeacher = false;
  String date = '';
  late FirebaseFirestore firestore;
  late CollectionReference users;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("Firebase initialization completed");
      setState(() {});
    });
    users = FirebaseFirestore.instance.collection('users');
    _fetchData();
  }

  Future <void> _fetchData() async {
    final QuerySnapshot result = await users.get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      Fname = documents[0]['firstName'];
      Lname = documents[0]['lastName'];
      email = documents[0]['email'];
      phone = documents[0]['phoneNumber'];
      isTeacher = documents[0]['isTeacher'];
      date = documents[0]['dob'] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  

                  Center(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "@"+ Fname + " " + Lname,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),


                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: <Widget>[
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                email,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          Text(
                            "Phone Number",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                phone,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          Text(
                            "Date of Birth",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                date,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),


                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          Text(
                            "Role",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                isTeacher == true ? "Teacher" : "Student",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          // first and last name 

                          Text(
                            "First Name",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Fname,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                          Text(
                            "Last Name",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.04,
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                Lname,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                    
                    
                        ],
                      ),
                    ),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      

                    ],
                  ),


                ]),
          ],
        ),
    );
  }
}
