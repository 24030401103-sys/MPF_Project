import 'package:flutter/material.dart';
import 'database.dart';

class Reg extends StatefulWidget {
  final Map<String, dynamic>? user;

  const Reg({super.key, this.user});

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();

  String? city;
  String gender = "";
  String dob = "";

  String? dobError;

  bool reading = false;
  bool music = false;
  bool sports = false;

  @override
  void initState() {
    super.initState();

    // UPDATE MODE
    if (widget.user != null) {
      nameController.text = widget.user!["name"] ?? "";
      addressController.text = widget.user!["address"] ?? "";
      emailController.text = widget.user!["email"] ?? "";
      mobileController.text = widget.user!["mobile"] ?? "";

      city = widget.user!["city"];
      gender = widget.user!["gender"] ?? "";
      dob = widget.user!["dob"] ?? "";

      String hobbies = widget.user!["hobbies"] ?? "";

      if (hobbies.contains("Reading")) {
        reading = true;
      }

      if (hobbies.contains("Music")) {
        music = true;
      }

      if (hobbies.contains("Sports")) {
        sports = true;
      }
    }
  }

  // =========================================================
  // SAVE / UPDATE
  // =========================================================

  Future<void> saveUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (gender == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select gender"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    if (dob == "") {
      setState(() {
        dobError = "Please select DOB";
      });

      return;
    }

    List<String> hobbyList = [];

    if (reading) {
      hobbyList.add("Reading");
    }

    if (music) {
      hobbyList.add("Music");
    }

    if (sports) {
      hobbyList.add("Sports");
    }

    String hobbies = hobbyList.join(", ");

    // =======================================================
    // UPDATE USER
    // =======================================================

    if (widget.user != null) {
      Map<String, dynamic> user = {
        "name": nameController.text,
        "address": addressController.text,
        "email": emailController.text,
        "mobile": mobileController.text,
        "city": city,
        "gender": gender,
        "dob": dob,
        "hobbies": hobbies,
      };

      await databaseHelper.updateUser(
        widget.user!["id"],
        user,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Updated Successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

      return;
    }

    // =======================================================
    // INSERT USER
    // =======================================================

    Map<String, dynamic> user = {
      "name": nameController.text,
      "address": addressController.text,
      "email": emailController.text,
      "mobile": mobileController.text,
      "city": city,
      "gender": gender,
      "dob": dob,
      "hobbies": hobbies,
      "favourite": 0,
    };

    await databaseHelper.insertUser(user);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("User Saved Successfully"),
        backgroundColor: Colors.green,
      ),
    );

    resetForm();
  }

  // =========================================================
  // RESET
  // =========================================================

  void resetForm() {
    nameController.clear();
    addressController.clear();
    emailController.clear();
    mobileController.clear();

    setState(() {
      city = null;
      gender = "";
      dob = "";
      dobError = null;

      reading = false;
      music = false;
      sports = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    mobileController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    bool isUpdate = widget.user != null;

    return Scaffold(
      backgroundColor: const Color(0xfffff5f7),

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            Container(
              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(
                20,
                15,
                20,
                25,
              ),

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    Colors.red,
                    Colors.pinkAccent,
                  ],
                ),

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),

              child: Column(
                children: [
                  // TOP ROW
                  Row(
                    children: [
                      // BACK BUTTON

                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },

                        borderRadius:
                        BorderRadius.circular(15),

                        child: Container(
                          height: 45,
                          width: 45,

                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.20),

                            borderRadius:
                            BorderRadius.circular(15),
                          ),

                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Text(
                          isUpdate
                              ? "Update Profile"
                              : "Create Profile",

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // HEART

                      Container(
                        height: 45,
                        width: 45,

                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.20),

                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // PROFILE ICON

                  Container(
                    height: 80,
                    width: 80,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      shape: BoxShape.circle,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.15),
                          blurRadius: 12,
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    isUpdate
                        ? "Edit your information"
                        : "Find your perfect match ❤️",

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // FORM
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),

                child: Form(
                  key: _formKey,

                  child: Column(
                    children: [
                      // =================================================
                      // PERSONAL INFORMATION
                      // =================================================

                      sectionTitle(
                        Icons.person_outline,
                        "Personal Information",
                      ),

                      const SizedBox(height: 12),

                      // NAME

                      customTextField(
                        controller: nameController,
                        label: "Full Name",
                        hint: "Enter your full name",
                        icon: Icons.person_outline,

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter Name";
                          }

                          if (!RegExp(
                            r'^[a-zA-Z ]+$',
                          ).hasMatch(value)) {
                            return "Only alphabets allowed";
                          }

                          if (value.length < 3) {
                            return "Name must be at least 3 characters";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      // ADDRESS

                      customTextField(
                        controller: addressController,
                        label: "Address",
                        hint: "Enter your address",
                        icon: Icons.location_on_outlined,
                        maxLines: 2,

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter Address";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      // EMAIL

                      customTextField(
                        controller: emailController,
                        label: "Email",
                        hint: "example@gmail.com",
                        icon: Icons.email_outlined,
                        keyboardType:
                        TextInputType.emailAddress,

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter Email";
                          }

                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return "Enter Valid Email";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      // MOBILE

                      customTextField(
                        controller: mobileController,
                        label: "Mobile Number",
                        hint: "Enter 10 digit mobile",
                        icon: Icons.phone_outlined,
                        keyboardType:
                        TextInputType.phone,

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return "Enter Mobile";
                          }

                          if (value.length != 10) {
                            return "Enter 10 Digit Mobile";
                          }

                          if (!RegExp(
                            r'^[0-9]+$',
                          ).hasMatch(value)) {
                            return "Only numbers allowed";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // =================================================
                      // LOCATION
                      // =================================================

                      sectionTitle(
                        Icons.location_city,
                        "Location",
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),

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

                        child:
                        DropdownButtonFormField<String>(
                          value: city,

                          decoration:
                          const InputDecoration(
                            border: InputBorder.none,

                            labelText: "City",

                            prefixIcon: Icon(
                              Icons.location_city,
                              color: Colors.red,
                            ),
                          ),

                          items: const [
                            DropdownMenuItem(
                              value: "Rajkot",
                              child: Text("Rajkot"),
                            ),

                            DropdownMenuItem(
                              value: "Surat",
                              child: Text("Surat"),
                            ),

                            DropdownMenuItem(
                              value: "Ahmedabad",
                              child: Text("Ahmedabad"),
                            ),
                          ],

                          onChanged: (value) {
                            setState(() {
                              city = value;
                            });
                          },

                          validator: (value) {
                            if (value == null) {
                              return "Select City";
                            }

                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =================================================
                      // GENDER
                      // =================================================

                      sectionTitle(
                        Icons.people_outline,
                        "Gender",
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: genderCard(
                              title: "Male",
                              icon: Icons.male,
                              selected:
                              gender == "Male",

                              onTap: () {
                                setState(() {
                                  gender = "Male";
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: genderCard(
                              title: "Female",
                              icon: Icons.female,
                              selected:
                              gender == "Female",

                              onTap: () {
                                setState(() {
                                  gender = "Female";
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // =================================================
                      // DATE OF BIRTH
                      // =================================================

                      sectionTitle(
                        Icons.cake_outlined,
                        "Date of Birth",
                      ),

                      const SizedBox(height: 12),

                      InkWell(
                        onTap: selectDate,

                        borderRadius:
                        BorderRadius.circular(18),

                        child: Container(
                          width: double.infinity,

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
                            children: [
                              Container(
                                height: 45,
                                width: 45,

                                decoration:
                                BoxDecoration(
                                  color: Colors.pink
                                      .withOpacity(0.10),

                                  borderRadius:
                                  BorderRadius
                                      .circular(13),
                                ),

                                child: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.pink,
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,

                                  children: [
                                    const Text(
                                      "Date of Birth",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      dob == ""
                                          ? "Select your birth date"
                                          : dob,

                                      style:
                                      TextStyle(
                                        fontSize: 16,

                                        fontWeight:
                                        FontWeight.w600,

                                        color: dob == ""
                                            ? Colors.grey
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (dobError != null)
                        Align(
                          alignment:
                          Alignment.centerLeft,

                          child: Padding(
                            padding:
                            const EdgeInsets.only(
                              top: 5,
                              left: 10,
                            ),

                            child: Text(
                              dobError!,

                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      // =================================================
                      // HOBBIES
                      // =================================================

                      sectionTitle(
                        Icons.favorite_border,
                        "Hobbies",
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: hobbyCard(
                              title: "Reading",
                              icon: Icons.menu_book,
                              selected: reading,

                              onTap: () {
                                setState(() {
                                  reading = !reading;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: hobbyCard(
                              title: "Music",
                              icon: Icons.music_note,
                              selected: music,

                              onTap: () {
                                setState(() {
                                  music = !music;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: hobbyCard(
                              title: "Sports",
                              icon: Icons.sports_cricket,
                              selected: sports,

                              onTap: () {
                                setState(() {
                                  sports = !sports;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // =================================================
                      // BUTTONS
                      // =================================================

                      Row(
                        children: [
                          Expanded(
                            flex: 2,

                            child: ElevatedButton(
                              onPressed: saveUser,

                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.red,

                                foregroundColor:
                                Colors.white,

                                elevation: 5,

                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  vertical: 16,
                                ),

                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                    18,
                                  ),
                                ),
                              ),

                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [
                                  Icon(
                                    isUpdate
                                        ? Icons.save
                                        : Icons.person_add,

                                    size: 20,
                                  ),

                                  const SizedBox(width: 8),

                                  Text(
                                    isUpdate
                                        ? "Update Profile"
                                        : "Save Profile",

                                    style:
                                    const TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: OutlinedButton(
                              onPressed: resetForm,

                              style:
                              OutlinedButton.styleFrom(
                                foregroundColor:
                                Colors.red,

                                side: const BorderSide(
                                  color: Colors.red,
                                ),

                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  vertical: 16,
                                ),

                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                    18,
                                  ),
                                ),
                              ),

                              child: const Text(
                                "Reset",
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Create meaningful connections ❤️",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DATE PICKER
  // ==========================================================

  Future<void> selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(1950),

      lastDate: DateTime.now(),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.red,
            ),
          ),

          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        dob =
        "${date.day}/${date.month}/${date.year}";

        dobError = null;
      });
    }
  }

  // ==========================================================
  // SECTION TITLE
  // ==========================================================

  Widget sectionTitle(
      IconData icon,
      String title,
      ) {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,

          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.10),

            borderRadius:
            BorderRadius.circular(10),
          ),

          child: Icon(
            icon,
            color: Colors.red,
            size: 20,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,

          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // TEXT FIELD
  // ==========================================================

  Widget customTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType =
        TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.05),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: TextFormField(
        controller: controller,

        keyboardType: keyboardType,

        maxLines: maxLines,

        validator: validator,

        decoration: InputDecoration(
          labelText: label,

          hintText: hint,

          prefixIcon: Icon(
            icon,
            color: Colors.red,
          ),

          border: InputBorder.none,

          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 17,
          ),

          errorStyle: const TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // GENDER CARD
  // ==========================================================

  Widget genderCard({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius:
      BorderRadius.circular(18),

      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 200),

        padding:
        const EdgeInsets.symmetric(
          vertical: 15,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Colors.red
              : Colors.white,

          borderRadius:
          BorderRadius.circular(18),

          border: Border.all(
            color: selected
                ? Colors.red
                : Colors.grey.shade200,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.04),

              blurRadius: 8,

              offset:
              const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Icon(
              icon,

              color: selected
                  ? Colors.white
                  : Colors.red,
            ),

            const SizedBox(width: 8),

            Text(
              title,

              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.black87,

                fontWeight:
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // HOBBY CARD
  // ==========================================================

  Widget hobbyCard({
    required String title,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      borderRadius:
      BorderRadius.circular(16),

      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 200),

        padding:
        const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 5,
        ),

        decoration: BoxDecoration(
          color: selected
              ? Colors.red
              : Colors.white,

          borderRadius:
          BorderRadius.circular(16),

          border: Border.all(
            color: selected
                ? Colors.red
                : Colors.grey.shade200,
          ),
        ),

        child: Column(
          children: [
            Icon(
              icon,

              color: selected
                  ? Colors.white
                  : Colors.red,

              size: 25,
            ),

            const SizedBox(height: 6),

            Text(
              title,

              style: TextStyle(
                fontSize: 12,

                color: selected
                    ? Colors.white
                    : Colors.black87,

                fontWeight:
                FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}