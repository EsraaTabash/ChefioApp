import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/models/recipeModel.dart';
import 'package:recipe_book_application/data/recipeRepo.dart';
import 'package:recipe_book_application/presentaion/widgets/recipeCardWidget.dart';

class Home extends StatefulWidget {
  final String name;

  const Home({super.key, required this.name});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  String errorMsg = '';
  List<Recipemodel> recipes = [];
  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: const Color.fromARGB(255, 201, 238, 240),
        title: Image.asset("assets/logoDark.png", width: 150),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_rounded,
              color: Colors.black,
              size: 24,
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_rounded, color: Colors.black, size: 24),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout_rounded, color: Colors.black, size: 24),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF00B4BF)))
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 20,
                    bottom: 10,
                    right: 20,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hello ${widget.name} 👋 What is in your kitchen?",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter some ingredients to search",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff424242),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                      hintText: 'Type your ingredients',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: Color(0xffAEAEAE),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 201, 238, 240),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0XFF00B4BF),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 245,
                      ),
                      itemBuilder: (context, index) {
                        return Recipecardwidget(recipe: recipes[index]);
                      },
                      itemCount: recipes.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> fetchRecipes() async {
    try {
      setState(() {
        isLoading = true;
        errorMsg = '';
      });
      final data = await Reciperepo.fetchRecipes();
      setState(() {
        isLoading = false;
        recipes = data;
      });
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $errorMsg'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
