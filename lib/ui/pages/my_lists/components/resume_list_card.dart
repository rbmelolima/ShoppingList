import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/routes/navigation.dart';
import 'package:shoppinglist/ui/style/color.dart';
import 'package:shoppinglist/ui/style/text.dart';

enum Options { clone, delete, share }

//TODO: melhorar a área de click
class ResumeListCard extends StatefulWidget {
  final ShoppingListEntity list;

  final Function onDelete;
  final Function onClone;
  final Function onShare;
  final Function onUpdatePage;

  const ResumeListCard({
    Key? key,
    required this.list,
    required this.onDelete,
    required this.onClone,
    required this.onShare,
    required this.onUpdatePage,
  }) : super(key: key);

  @override
  State<ResumeListCard> createState() => _ResumeListCardState();
}

class _ResumeListCardState extends State<ResumeListCard> {
  String getListOfProducts() {
    var prod = widget.list.products;
    String names = "";

    if (prod.isNotEmpty) {
      for (var i = 0; i < prod.length; i++) {
        if (i != prod.length - 1) {
          names += "${prod[i].name}, ";
        } else {
          names += prod[i].name;
        }
      }
    }

    return names;
  }

  @override
  Widget build(BuildContext context) {
    bool hasProducts = widget.list.products.isNotEmpty;

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color.fromARGB(16, 0, 0, 0),
            spreadRadius: 0,
            offset: Offset(0, 2),
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () async {
                  var needsUpdatePage =
                      await AppNavigation.navigateToListDetails(
                    context,
                    widget.list,
                  );

                  if (needsUpdatePage) {
                    widget.onUpdatePage();
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.list.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    if (hasProducts) ...[
                      Text(
                        getListOfProducts(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: Chip(
                          label: Text(
                            widget.list.products.length.toString() +
                                " itens".toUpperCase(),
                          ),
                          backgroundColor: AppColors.primaryLight,
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
            const Spacer(),
            PopupMenuButton<Options>(
              child: Icon(
                Icons.more_vert_outlined,
                size: 18,
                color: AppColors.black01,
              ),
              itemBuilder: (context) => _generatePopupItensList,
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuEntry<Options>> get _generatePopupItensList {
    return <PopupMenuEntry<Options>>[
      PopupMenuItem<Options>(
        value: Options.delete,
        onTap: () => widget.onDelete(),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(
                Icons.delete,
                color: Color(0xFF8e8e8e),
              ),
            ),
            Text(
              'Excluir',
              style: AppText.popup(AppColors.black02),
            ),
          ],
        ),
      ),
      PopupMenuItem<Options>(
        value: Options.clone,
        onTap: () => widget.onClone(),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(
                Icons.copy,
                color: Color(0xFF8e8e8e),
              ),
            ),
            Text(
              'Clonar',
              style: AppText.popup(AppColors.black02),
            ),
          ],
        ),
      ),
      PopupMenuItem<Options>(
        value: Options.share,
        onTap: () => widget.onShare(),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(
                Icons.share,
                color: Color(0xFF8e8e8e),
              ),
            ),
            Text(
              'Compartilhar',
              style: AppText.popup(AppColors.black02),
            ),
          ],
        ),
      ),
    ];
  }
}
