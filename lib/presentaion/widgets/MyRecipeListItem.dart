import 'package:flutter/material.dart';
import 'package:recipe_book_application/data/models/recipeModel.dart';

class MyRecipeListItem extends StatefulWidget {
  final Recipemodel recipe;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MyRecipeListItem({
    super.key,
    required this.recipe,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<MyRecipeListItem> createState() => _MyRecipeListItemState();
}

class _MyRecipeListItemState extends State<MyRecipeListItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.recipe;

    final imageUrl = r.recipeImage?.trim() ?? '';
    final category = r.recipeCategory?.trim().isEmpty ?? true
        ? "not specified"
        : r.recipeCategory!.trim();
    final time = r.recipeTime ?? 0;
    final description = (r.recipeDescription?.trim().isEmpty ?? true)
        ? "No description added for this recipe."
        : r.recipeDescription!.trim();

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- الصف الأساسي (صورة + عنوان + كاتيجوري + أزرار) --------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصورة
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[300],
                          child: Icon(Icons.image_not_supported),
                        ),
                ),

                SizedBox(width: 12),

                // الاسم + النوع + الوقت
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.recipeName?.trim().isEmpty ?? true
                            ? "Untitled recipe"
                            : r.recipeName!.trim(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 4),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: "Inter",
                                color: Colors.teal,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "$time min",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: "Inter",
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // أزرار التعديل والحذف
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, size: 20),
                      onPressed: widget.onEdit,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                      onPressed: widget.onDelete,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8),

            // زر إظهار/إخفاء التفاصيل
            InkWell(
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    expanded ? "hide details" : "show more",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13,
                      color: Color(0xFF00B4BF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF00B4BF),
                  ),
                ],
              ),
            ),

            // الوصف لما يكون expanded = true
            if (expanded) ...[
              SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF0F9F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFF00B4BF), width: .7),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.notes_rounded,
                      color: Color(0xFF00B4BF),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
