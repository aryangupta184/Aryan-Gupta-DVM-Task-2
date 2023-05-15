import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import './network.dart';

import 'firebase_options.dart';

import 'dart:ui';

import './utils.dart';

import './post.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AG DVM -2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RangeValues _currentrangevalues = const RangeValues(-200, 200);

  List<Post> _posts = <Post>[];
  List<Post> _postsDisplay = <Post>[];

  @override
  void initState() {
    fetchPost().then((value) {
      setState(() {
        _posts.addAll(value);
        _postsDisplay = _posts;
      });
    });
    super.initState();
  }

  bool click = true;

  @override
  Widget build(BuildContext context) {
    CollectionReference friends =
        FirebaseFirestore.instance.collection('friends');

    Future<void> addFriend(nameatindex) {
      // Call the user's CollectionReference to add a new user
      return friends
          .add({
            'friend_name': nameatindex,
          })
          .then((value) => print("Friend Added"))
          .catchError((error) => print("Failed to add friend: $error"));
    }

    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return MaterialApp(
        title: 'Flutter',
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: SingleChildScrollView(
                child: Container(
          padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
          width: double.infinity,
          color: Color(0xff00020c),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: double.infinity,
                height: 140 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 550 * fem,
                          height: 140 * fem,
                          child: Image.asset(
                            'assets/page-1/images/group-48096070.png',
                            width: 550 * fem,
                            height: 140 * fem,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 28 * fem,
                      top: 72 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 77 * fem,
                          height: 39 * fem,
                          child: Text(
                            'Users',
                            style: SafeGoogleFont(
                              'Open Sans',
                              fontSize: 28 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ), //
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 350 * fem,
                height: 40 * fem,
                child: Positioned(
                    left: 0 * fem,
                    top: 0 * fem,
                    child: TextField(
                      onChanged: (text) {
                        text = text.toLowerCase();
                        setState(() {
                          _postsDisplay = _posts.where((post) {
                            var postName = post.name!.toLowerCase();
                            return postName.contains(text);
                          }).toList();
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0x26a36c00),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10 * fem),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search for name...',
                        hintStyle: TextStyle(color: Color(0x38C0C0C0)),
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Colors.white,
                        suffixIcon: Icon(Icons.cancel_outlined),
                        suffixIconColor: Colors.white,
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 350 * fem,
                height: 40 * fem,
                child: Positioned(
                  left: 38 * fem,
                  top: 210 * fem,
                  child: SizedBox(
                      width: 350 * fem,
                      child: StatefulBuilder(builder: (context, state) {
                        return RangeSlider(
                            values: _currentrangevalues,
                            labels: RangeLabels(
                                _currentrangevalues.start.round().toString(),
                                _currentrangevalues.end.round().toString()),
                            divisions: 20,
                            min: -200,
                            max: 200,
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentrangevalues = values;


                                _postsDisplay = _posts.where((post) {
                                  var postLng = double.parse(post.address!.geo!.lng!);
                                  assert(postLng is double);

                                  if ((postLng>=_currentrangevalues.start)&&(postLng<=_currentrangevalues.end)) {
                                    return true;
                                    }
                                  else{
                                    return false;
                                  }
                                }).toList();
                              });
                            });
                      })),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 390 * fem,
                height: 1200 * fem,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: _postsDisplay.length,
                                itemBuilder: (context, index) {
                                  if (_postsDisplay.length > 0) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      child: ClipRect(
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 25 * fem,
                                            sigmaY: 25 * fem,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                21 * fem,
                                                26 * fem,
                                                21 * fem,
                                                27 * fem),
                                            width: 388 * fem,
                                            height: 192 * fem,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff7b7b7b)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20 * fem),
                                              gradient: const RadialGradient(
                                                center: Alignment(0.804, 1.311),
                                                radius: 1.62,
                                                colors: <Color>[
                                                  Color(0x38ffd000),
                                                  Color(0x38353535)
                                                ],
                                                stops: <double>[0, 1],
                                              ),
                                            ),
                                            child: Container(
                                              width: 278.88 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // group48096063q82 (I0:308;490:9461)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        15* fem),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  4 * fem),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Color(
                                                                          0x38353535),
                                                                  foregroundColor:
                                                                      Color(
                                                                          0xffffffff)),
                                                              onPressed:
                                                                  () async {
                                                                await friends.add({
                                                                  'friend_name':
                                                                      _postsDisplay[
                                                                              index]
                                                                          .name!
                                                                }).then((value) =>
                                                                    print(
                                                                        'Friend Added'));
                                                                setState(() {
                                                                  click =
                                                                      !click;
                                                                });
                                                              },
                                                              child: Text(
                                                                _postsDisplay[
                                                                        index]
                                                                    .name!,
                                                                style:
                                                                    SafeGoogleFont(
                                                                  'Open Sans',
                                                                  fontSize:
                                                                      20 * ffem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  height: 1.5 *
                                                                      ffem /
                                                                      fem,
                                                                  color: (click ==
                                                                          true)
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .yellow,
                                                                ),
                                                              )),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  10 * fem),
                                                          child: Text(
                                                            _postsDisplay[index]
                                                                .email!,
                                                            style:
                                                                SafeGoogleFont(
                                                              'Open Sans',
                                                              fontSize:
                                                                  14 * ffem,
                                                              height: 1.5 *
                                                                  ffem /
                                                                  fem,
                                                              color: Color(
                                                                  0xfff8d848),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 600 * fem,
                                                          ),
                                                          child: Text(
                                                            _postsDisplay[index].address!.street! +
                                                                ' - ' +
                                                                _postsDisplay[index].address!.suite! +
                                                                '\n' +
                                                                _postsDisplay[index].address!.city! +
                                                                ' - ' +
                                                                _postsDisplay[index].address!.zipcode!,
                                                            style:
                                                                SafeGoogleFont(
                                                              'Open Sans',
                                                              fontSize:
                                                                  10 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              height: 1 *
                                                                  ffem /
                                                                  fem,
                                                              color: Color(
                                                                  0xffffffff),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 10 * fem,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(

                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  184.43 * fem,
                                                                  0 * fem),
                                                          height:
                                                              double.infinity,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(

                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0 * fem,
                                                                        1 * fem,
                                                                        8.22 *
                                                                            fem,
                                                                        0 * fem),
                                                                width: 12 * fem,
                                                                height:
                                                                    15 * fem,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/page-1/images/vector-6mC.png',
                                                                  width:
                                                                      12 * fem,
                                                                  height:
                                                                      15 * fem,
                                                                ),
                                                              ),
                                                              Text(
                                                                _postsDisplay[
                                                                        index]
                                                                    .address!
                                                                    .geo!
                                                                    .lat!,
                                                                style:
                                                                    SafeGoogleFont(
                                                                  'Open Sans',
                                                                  fontSize:
                                                                      8 * ffem,
                                                                  height: 1.5 *
                                                                      ffem /
                                                                      fem,
                                                                  color: Color(
                                                                      0xffffffff),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(

                                                          height:
                                                              double.infinity,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0 * fem,
                                                                        2 * fem,
                                                                        8.22 *
                                                                            fem,
                                                                        0 * fem),
                                                                width: 14 * fem,
                                                                height:
                                                                    14 * fem,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/page-1/images/vector-HSn.png',
                                                                  width:
                                                                      14 * fem,
                                                                  height:
                                                                      14 * fem,
                                                                ),
                                                              ),
                                                              Text(

                                                                _postsDisplay[index].address!.geo!.lng!,
                                                                style:
                                                                    SafeGoogleFont(
                                                                  'Open Sans',
                                                                  fontSize:
                                                                      8 * ffem,
                                                                  height: 1.5 *
                                                                      ffem /
                                                                      fem,
                                                                  color: Color(
                                                                      0xffffffff),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  /**/
                                }))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ))));
  }
}
