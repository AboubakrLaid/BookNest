import 'package:e_books/models/category.dart';
import 'package:e_books/screens/profile/profile_provider.dart';
import 'package:e_books/util/export.dart';
import 'package:e_books/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>?> categoriesData;
  @override
  void initState() {
    super.initState();
    categoriesData = getCategories(context);
  }

  Future<List<Category>?> getCategories(BuildContext context) async {
    final state = Provider.of<ProfileProvider>(context, listen: false);
    return await state.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, state, child) {
        return FutureBuilder<List<Category>?>(
          future: categoriesData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return InkWell(
                onTap: () {
                  setState(() {
                    categoriesData = getCategories(context);
                  });
                },
                child: const Center(
                  child: Text("Error loading categories"),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CustomCircularIndicator(
                  dimension: 15.dm,
                  color: context.theme.primaryColor,
                ),
              );
            } else {
              final categories = snapshot.data!;
              return SizedBox(
                height: 200.h,
                child:MasonryGridView.count(
                      itemCount: categories.length,
                      mainAxisSpacing: 8.w,
                      crossAxisSpacing: 8.w,
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 5,
                      itemBuilder: (context, index) {
                        Category genre = categories[index];
                        return InkWell(
                      onTap: () => state.toggleGenre(genre),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                         horizontal: 22.w,
                          vertical: 7.h,
                        ), 
                        decoration: BoxDecoration(
                          color: state.isGenreSelected(genre)
                              ? context.theme.primaryColor
                              : const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: FittedBox(
                          child: Text(
                            categories[index].name,
                            style: const TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                                          );
                      },
                    
                  
                ),
              );
            }
          },
        );
      },
    );
  }
}
