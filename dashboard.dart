import 'package:flutter/material.dart';
import 'registration.dart';
import 'user_list.dart';
import 'favourite.dart';
import 'about_us.dart';

class dashboard extends StatelessWidget {
  dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffffe4ec),
              Color(0xfffff5f7),
              Color(0xffffd6df),
            ],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              // ================= HEADER =================

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),

                child: Row(
                  children: [

                    // Logo
                    Container(
                      height: 55,
                      width: 55,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 15),

                    // Title
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Welcome ❤️",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),

                        SizedBox(height: 2),

                        Text(
                          "Matrimonial",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Notification
                    Container(
                      height: 45,
                      width: 45,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.notifications_none,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= SUBTITLE =================

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),

                child: Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Find your perfect match 💕",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ================= MENU =================

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  child: GridView.count(
                    crossAxisCount: 2,

                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,

                    childAspectRatio: 1.05,

                    children: [

                      // ADD USER
                      dashboardCard(
                        icon: Icons.person_add_alt_1,
                        title: "Add User",
                        subtitle: "Create profile",
                        iconColor: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reg(),
                            ),
                          );
                        },
                      ),

                      // USER LIST
                      dashboardCard(
                        icon: Icons.people_alt_outlined,
                        title: "User List",
                        subtitle: "View profiles",
                        iconColor: Colors.deepPurple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserList(),
                            ),
                          );
                        },
                      ),

                      // FAVOURITE
                      dashboardCard(
                        icon: Icons.favorite,
                        title: "Favourite",
                        subtitle: "Your favourites",
                        iconColor: Colors.red,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Favourite(),
                            ),
                          );
                        },
                      ),

                      // ABOUT US
                      dashboardCard(
                        icon: Icons.info_outline,
                        title: "About Us",
                        subtitle: "Know about us",
                        iconColor: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUs(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // ================= BOTTOM TEXT =================

              const Padding(
                padding: EdgeInsets.only(bottom: 15),

                child: Text(
                  "Made with ❤️ for beautiful relationships",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ======================================================
// DASHBOARD CARD
// ======================================================

class dashboardCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const dashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(28),

      child: Container(

        decoration: BoxDecoration(

          color: Colors.white.withOpacity(0.90),

          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // ICON CIRCLE

            Container(
              height: 65,
              width: 65,

              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 32,
                color: iconColor,
              ),
            ),

            const SizedBox(height: 14),

            // TITLE

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 5),

            // SUBTITLE

            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}