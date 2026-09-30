import 'package:flutter/material.dart';
import 'database.dart';
import 'registration.dart';

class UserList extends StatefulWidget {
  UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsers();

    searchController.addListener(() {
      searchUsers();
    });
  }

  // =========================================================
  // LOAD USERS
  // =========================================================

  Future<void> loadUsers() async {
    List<Map<String, dynamic>> data =
    await databaseHelper.getUsers();

    setState(() {
      users = data;
      filteredUsers = data;
    });
  }

  // =========================================================
  // SEARCH
  // =========================================================

  void searchUsers() {
    String search =
    searchController.text.toLowerCase();

    setState(() {
      filteredUsers = users.where((user) {

        String name =
        user["name"].toString().toLowerCase();

        String email =
        user["email"].toString().toLowerCase();

        String mobile =
        user["mobile"].toString().toLowerCase();

        String city =
        user["city"].toString().toLowerCase();

        return name.contains(search) ||
            email.contains(search) ||
            mobile.contains(search) ||
            city.contains(search);
      }).toList();
    });
  }

  // =========================================================
  // FAVOURITE
  // =========================================================

  Future<void> makeFavourite(
      int id,
      int favourite,
      ) async {

    await databaseHelper.updateFavourite(
      id,
      favourite,
    );

    await loadUsers();
  }

  // =========================================================
  // DELETE
  // =========================================================

  Future<void> deleteUser(int id) async {

    await databaseHelper.deleteUser(id);

    await loadUsers();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("User Deleted"),
        backgroundColor: Colors.red,
      ),
    );
  }

  // =========================================================
  // UPDATE
  // =========================================================

  Future<void> updateUser(
      Map<String, dynamic> user,
      ) async {

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Reg(user: user),
      ),
    );

    await loadUsers();
  }

  // =========================================================
  // USER DETAILS
  // =========================================================

  void showUserDetails(Map<String, dynamic> user) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UserDetails(user: user),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xfffff5f7),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(

        elevation: 0,

        backgroundColor: Colors.transparent,

        foregroundColor: Colors.black87,

        title: const Text(
          "User Profiles",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 15),

            child: Center(
              child: Container(

                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  "${users.length} Users",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: Column(
        children: [

          // =================================================
          // SEARCH BAR
          // =================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              5,
              18,
              15,
            ),

            child: Container(

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(18),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: TextField(

                controller: searchController,

                decoration: InputDecoration(

                  hintText:
                  "Search by name, city, email...",

                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),

                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.red,
                  ),

                  suffixIcon:
                  searchController.text.isNotEmpty
                      ? IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                      : null,

                  border: InputBorder.none,

                  contentPadding:
                  const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
                ),
              ),
            ),
          ),

          // =================================================
          // LIST
          // =================================================

          Expanded(

            child: filteredUsers.isEmpty

                ? const Center(

              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.person_search,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),

                  Text(
                    "No Users Found",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )

                : ListView.builder(

              padding: const EdgeInsets.fromLTRB(
                15,
                0,
                15,
                20,
              ),

              itemCount:
              filteredUsers.length,

              itemBuilder:
                  (context, index) {

                Map<String, dynamic> user =
                filteredUsers[index];

                int id = user["id"];

                String name =
                user["name"].toString();

                String city =
                user["city"].toString();

                String gender =
                user["gender"].toString();

                int favourite =
                user["favourite"];

                return GestureDetector(

                  // =====================================
                  // CLICK CARD
                  // =====================================

                  onTap: () {
                    showUserDetails(user);
                  },

                  child: Container(

                    margin:
                    const EdgeInsets.only(
                      bottom: 15,
                    ),

                    padding:
                    const EdgeInsets.all(15),

                    decoration:
                    BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(22),

                      boxShadow: [

                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.07),

                          blurRadius: 15,

                          offset:
                          const Offset(0, 7),
                        ),
                      ],
                    ),

                    child: Row(

                      children: [

                        // =================================
                        // PROFILE ICON
                        // =================================

                        Container(

                          height: 65,
                          width: 65,

                          decoration:
                          BoxDecoration(

                            gradient:
                            const LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.pinkAccent,
                              ],
                            ),

                            shape: BoxShape.circle,

                            boxShadow: [

                              BoxShadow(
                                color: Colors.red
                                    .withOpacity(0.25),

                                blurRadius: 10,
                              ),
                            ],
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

                                fontSize: 27,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        // =================================
                        // USER INFO
                        // =================================

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

                                  const SizedBox(width: 4),

                                  Text(
                                    city,
                                    style:
                                    const TextStyle(
                                      color:
                                      Colors.black54,
                                    ),
                                  ),

                                  const SizedBox(width: 12),

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
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 7),

                              const Row(
                                children: [

                                  Icon(
                                    Icons
                                        .touch_app,
                                    size: 15,
                                    color:
                                    Colors.grey,
                                  ),

                                  SizedBox(width: 4),

                                  Text(
                                    "Tap to view profile",
                                    style:
                                    TextStyle(
                                      fontSize: 12,
                                      color:
                                      Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // =================================
                        // ACTIONS
                        // =================================

                        Column(

                          children: [

                            // Favourite

                            IconButton(

                              visualDensity:
                              VisualDensity
                                  .compact,

                              onPressed: () {

                                if (favourite == 0) {

                                  makeFavourite(
                                    id,
                                    1,
                                  );

                                } else {

                                  makeFavourite(
                                    id,
                                    0,
                                  );
                                }
                              },

                              icon: Icon(

                                favourite == 1
                                    ? Icons.favorite
                                    : Icons
                                    .favorite_border,

                                color: Colors.red,
                              ),
                            ),

                            // More menu

                            PopupMenuButton<String>(

                              icon: const Icon(
                                Icons.more_vert,
                              ),

                              onSelected:
                                  (value) {

                                if (value ==
                                    "edit") {

                                  updateUser(
                                    user,
                                  );

                                } else if (
                                value ==
                                    "delete") {

                                  deleteUser(
                                    id,
                                  );
                                }
                              },

                              itemBuilder:
                                  (context) => [

                                const PopupMenuItem(
                                  value: "edit",
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color:
                                        Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Edit"),
                                    ],
                                  ),
                                ),

                                const PopupMenuItem(
                                  value: "delete",
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color:
                                        Colors.red,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Delete"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// USER DETAILS PAGE
// ============================================================

class UserDetails extends StatelessWidget {

  final Map<String, dynamic> user;

  const UserDetails({
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

    int favourite =
    user["favourite"];

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
          "Profile Details",
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

                  // Profile circle

                  Container(

                    height: 95,
                    width: 95,

                    decoration:
                    BoxDecoration(

                      color: Colors.white,

                      shape:
                      BoxShape.circle,

                      border: Border.all(
                        color: Colors.white,
                        width: 4,
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

                          fontSize: 42,

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

                      fontSize: 25,

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

                      fontSize: 14,

                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Favourite status

                  Container(

                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 7,
                    ),

                    decoration:
                    BoxDecoration(

                      color:
                      Colors.white
                          .withOpacity(0.20),

                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),
                    ),

                    child: Row(

                      mainAxisSize:
                      MainAxisSize.min,

                      children: [

                        Icon(
                          favourite == 1
                              ? Icons.favorite
                              : Icons.favorite_border,

                          color:
                          Colors.white,

                          size: 18,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          favourite == 1
                              ? "Favourite"
                              : "Not Favourite",

                          style:
                          const TextStyle(
                            color:
                            Colors.white,
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

            detailCard(
              icon: Icons.email_outlined,
              title: "Email",
              value: email,
              color: Colors.blue,
            ),

            detailCard(
              icon: Icons.phone_outlined,
              title: "Mobile",
              value: mobile,
              color: Colors.green,
            ),

            detailCard(
              icon: Icons.location_on_outlined,
              title: "Address",
              value: address,
              color: Colors.orange,
            ),

            detailCard(
              icon: Icons.location_city,
              title: "City",
              value: city,
              color: Colors.purple,
            ),

            detailCard(
              icon: Icons.person_outline,
              title: "Gender",
              value: gender,
              color: Colors.teal,
            ),

            detailCard(
              icon: Icons.cake_outlined,
              title: "Date of Birth",
              value: dob,
              color: Colors.pink,
            ),

            detailCard(
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

  Widget detailCard({
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

      decoration:
      BoxDecoration(

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

          // Icon

          Container(

            height: 45,
            width: 45,

            decoration:
            BoxDecoration(

              color:
              color.withOpacity(0.10),

              borderRadius:
              BorderRadius.circular(
                13,
              ),
            ),

            child: Icon(
              icon,
              color: color,
              size: 23,
            ),
          ),

          const SizedBox(width: 15),

          // Text

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

                    fontWeight:
                    FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style:
                  const TextStyle(

                    fontSize: 16,

                    color: Colors.black87,

                    fontWeight:
                    FontWeight.w600,
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