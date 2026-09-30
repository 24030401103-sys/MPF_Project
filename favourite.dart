import 'package:flutter/material.dart';
import 'database.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();

    loadFavouriteUsers();
  }

  // =========================================================
  // LOAD FAVOURITE USERS
  // =========================================================

  Future<void> loadFavouriteUsers() async {
    List<Map<String, dynamic>> data =
    await databaseHelper.getFavouriteUsers();

    setState(() {
      users = data;
    });
  }

  // =========================================================
  // REMOVE FAVOURITE
  // =========================================================

  Future<void> removeFavourite(int id) async {
    await databaseHelper.updateFavourite(id, 0);

    await loadFavouriteUsers();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Removed from Favourite"),
        backgroundColor: Colors.red,
      ),
    );
  }

  // =========================================================
  // SHOW DETAILS
  // =========================================================

  void showUserDetails(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavouriteUserDetails(
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff5f7),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,

        foregroundColor: Colors.black87,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Favourites",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 2),

            Text(
              "People you liked ❤️",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),

            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: Colors.red.shade50,

                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 17,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      "${users.length}",
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: users.isEmpty
          ? const EmptyFavourite()
          : ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          15,
          10,
          15,
          20,
        ),

        itemCount: users.length,

        itemBuilder: (context, index) {
          Map<String, dynamic> user =
          users[index];

          int id = user["id"];

          String name =
          user["name"].toString();

          String city =
          user["city"].toString();

          String gender =
          user["gender"].toString();

          String mobile =
          user["mobile"].toString();

          return GestureDetector(
            onTap: () {
              showUserDetails(user);
            },

            child: Container(
              margin: const EdgeInsets.only(
                bottom: 15,
              ),

              padding:
              const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                BorderRadius.circular(23),

                boxShadow: [
                  BoxShadow(
                    color: Colors.red
                        .withOpacity(0.08),

                    blurRadius: 15,

                    offset:
                    const Offset(0, 7),
                  ),
                ],
              ),

              child: Row(
                children: [
                  // =================================================
                  // PROFILE IMAGE / INITIAL
                  // =================================================

                  Stack(
                    children: [
                      Container(
                        height: 70,
                        width: 70,

                        decoration:
                        const BoxDecoration(
                          shape:
                          BoxShape.circle,

                          gradient:
                          LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.pinkAccent,
                            ],
                          ),
                        ),

                        child: Center(
                          child: Text(
                            name.isNotEmpty
                                ? name[0]
                                .toUpperCase()
                                : "U",

                            style:
                            const TextStyle(
                              color:
                              Colors.white,

                              fontSize: 28,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Small heart

                      Positioned(
                        right: 0,
                        bottom: 0,

                        child: Container(
                          height: 25,
                          width: 25,

                          decoration:
                          BoxDecoration(
                            color:
                            Colors.white,

                            shape:
                            BoxShape.circle,

                            boxShadow: [
                              BoxShadow(
                                color: Colors
                                    .black12,
                                blurRadius: 4,
                              ),
                            ],
                          ),

                          child:
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 15),

                  // =================================================
                  // USER INFORMATION
                  // =================================================

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Text(
                          name,

                          maxLines: 1,

                          overflow:
                          TextOverflow.ellipsis,

                          style:
                          const TextStyle(
                            fontSize: 19,

                            fontWeight:
                            FontWeight.bold,

                            color:
                            Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 7),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.red,
                            ),

                            const SizedBox(
                                width: 4),

                            Text(
                              city,

                              style:
                              const TextStyle(
                                color:
                                Colors.black54,
                              ),
                            ),

                            const SizedBox(
                                width: 10),

                            Container(
                              padding:
                              const EdgeInsets
                                  .symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),

                              decoration:
                              BoxDecoration(
                                color: Colors
                                    .pink.shade50,

                                borderRadius:
                                BorderRadius
                                    .circular(
                                  10,
                                ),
                              ),

                              child: Text(
                                gender,

                                style:
                                const TextStyle(
                                  fontSize: 11,
                                  color:
                                  Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(
                              Icons.phone_outlined,
                              size: 15,
                              color: Colors.grey,
                            ),

                            const SizedBox(
                                width: 5),

                            Text(
                              mobile,

                              style:
                              const TextStyle(
                                fontSize: 12,
                                color:
                                Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        const Text(
                          "Tap to view full profile",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // =================================================
                  // REMOVE FAVOURITE
                  // =================================================

                  IconButton(
                    onPressed: () {
                      removeFavourite(id);
                    },

                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 28,
                    ),

                    tooltip:
                    "Remove Favourite",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


// ============================================================
// EMPTY FAVOURITE SCREEN
// ============================================================

class EmptyFavourite extends StatelessWidget {
  const EmptyFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [
          Container(
            height: 110,
            width: 110,

            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),

            child: const Icon(
              Icons.favorite_border,
              size: 60,
              color: Colors.red,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "No Favourite Users",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Start adding people to your favourites ❤️",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// FAVOURITE USER DETAILS
// ============================================================

class FavouriteUserDetails extends StatelessWidget {
  final Map<String, dynamic> user;

  const FavouriteUserDetails({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    String name =
    user["name"].toString();

    String address =
    user["address"].toString();

    String email =
    user["email"].toString();

    String mobile =
    user["mobile"].toString();

    String city =
    user["city"].toString();

    String gender =
    user["gender"].toString();

    String dob =
    user["dob"].toString();

    String hobbies =
    user["hobbies"].toString();

    return Scaffold(
      backgroundColor:
      const Color(0xfffff5f7),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor:
        Colors.transparent,

        elevation: 0,

        foregroundColor:
        Colors.black87,

        title: const Text(
          "Favourite Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // =================================================
            // PROFILE HEADER
            // =================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                gradient:
                const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Colors.red,
                    Colors.pinkAccent,
                  ],
                ),

                borderRadius:
                BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color: Colors.red
                        .withOpacity(0.25),

                    blurRadius: 15,

                    offset:
                    const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                children: [
                  // Profile

                  Container(
                    height: 100,
                    width: 100,

                    decoration:
                    const BoxDecoration(
                      color: Colors.white,

                      shape:
                      BoxShape.circle,
                    ),

                    child: Center(
                      child: Text(
                        name.isNotEmpty
                            ? name[0]
                            .toUpperCase()
                            : "U",

                        style:
                        const TextStyle(
                          fontSize: 45,

                          fontWeight:
                          FontWeight.bold,

                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    name,

                    style:
                    const TextStyle(
                      fontSize: 26,

                      fontWeight:
                      FontWeight.bold,

                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "$city • $gender",

                    style:
                    const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),

                    decoration:
                    BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.20),

                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: const Row(
                      mainAxisSize:
                      MainAxisSize.min,

                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 18,
                        ),

                        SizedBox(width: 7),

                        Text(
                          "Favourite Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // DETAILS
            // =================================================

            favouriteDetailCard(
              icon: Icons.email_outlined,
              title: "Email",
              value: email,
              color: Colors.blue,
            ),

            favouriteDetailCard(
              icon: Icons.phone_outlined,
              title: "Mobile",
              value: mobile,
              color: Colors.green,
            ),

            favouriteDetailCard(
              icon: Icons.location_on_outlined,
              title: "Address",
              value: address,
              color: Colors.orange,
            ),

            favouriteDetailCard(
              icon: Icons.location_city,
              title: "City",
              value: city,
              color: Colors.purple,
            ),

            favouriteDetailCard(
              icon: Icons.person_outline,
              title: "Gender",
              value: gender,
              color: Colors.teal,
            ),

            favouriteDetailCard(
              icon: Icons.cake_outlined,
              title: "Date of Birth",
              value: dob,
              color: Colors.pink,
            ),

            favouriteDetailCard(
              icon: Icons.favorite_border,
              title: "Hobbies",
              value: hobbies,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DETAIL CARD
  // ==========================================================

  Widget favouriteDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: double.infinity,

      margin:
      const EdgeInsets.only(bottom: 12),

      padding:
      const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.05),

            blurRadius: 10,

            offset:
            const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          Container(
            height: 45,
            width: 45,

            decoration: BoxDecoration(
              color:
              color.withOpacity(0.10),

              borderRadius:
              BorderRadius.circular(13),
            ),

            child: Icon(
              icon,
              color: color,
              size: 23,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style:
                  const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style:
                  const TextStyle(
                    fontSize: 16,

                    fontWeight:
                    FontWeight.w600,

                    color:
                    Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}