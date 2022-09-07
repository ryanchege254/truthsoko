import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../src/Widget/Warning_text.dart';
import '../../../src/Widget/constants.dart';
import '../../../src/models/Product.dart';
import '../../Details/details_screen.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.searchController,
    required this.user,
  }) : super(key: key);
  final TextEditingController? searchController;
  final User user;

  @override
  Widget build(BuildContext context) {
    bool _search = false;
    return SizedBox(
      height: 60,
      child: Center(
          child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              right: Global.defaultPadding,
              left: Global.defaultPadding),
          child: InkWell(
            onTap: () {
              _search = true;
              //showSearch(context: context, delegate: MySearchDelegate());
            },
            child: Column(
              children: [
                TextField(
                  onChanged: (query) {
                    query = searchController!.text.toLowerCase();
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      fillColor: Global.white,
                      labelStyle: const TextStyle(color: Global.white),
                      focusColor: Global.orange,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(color: Global.yellow),
                      ),
                      filled: true,
                      hintText: "What are you looking for...",
                      prefixIcon: SizedBox(
                          width: 1,
                          height: 1,
                          child: Image.asset("assets/icons/search_2.gif"))),
                ),
                const SizedBox(
                  height: 10,
                ),
                _search
                    ? Container()
                    : Expanded(
                        child: SizedBox(
                            height: 100,
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Products")
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  final results = searchController!.text.isEmpty
                                      ? snapshot.data!.docs
                                      : snapshot.data!.docs.where((a) =>
                                          a['title'].contains(
                                              searchController!.text));
                                  return ListView(
                                      children: results
                                          .map<Widget>((a) => Text(a['title']))
                                          .toList());
                                })))
              ],
            ),
          ),
        )
      ])),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  final User user;

  MySearchDelegate(this.user);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final list = FirebaseFirestore.instance.collection("Products").snapshots();
    return StreamBuilder(
        stream: list,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final results = query.isEmpty
              ? snapshot.data?.docs
              : snapshot.data?.docs.where((a) => a['title'].contains(query));

          if (snapshot.hasError) {
            if (kDebugMode) {
              print("Error.............${snapshot.error}");
            }
            return WarningText(text: "Something went wrong: ${snapshot.error}");
          }
          return ListView.builder(
            itemCount: results?.length,
            itemBuilder: (context, index) {
              ProductModel product =
                  ProductModel.fromSnapshot(snapshot.data!.docs[index]);

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      reverseTransitionDuration:
                          const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          FadeTransition(
                        opacity: animation,
                        child: DetailsScreen(
                          product: product,
                          user: user,
                        ),
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("${product.title}"),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text("${product.location}"),
                              ),
                              Text("${product.price}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
