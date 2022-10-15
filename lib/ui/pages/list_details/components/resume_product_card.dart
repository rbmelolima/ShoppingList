import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/routes/navigation.dart';
import 'package:shoppinglist/ui/style/style.dart';

class ResumeProductCard extends StatefulWidget {
  final ProductEntity product;
  final String idList;
  final Function onUpdatePage;

  const ResumeProductCard({
    Key? key,
    required this.product,
    required this.idList,
    required this.onUpdatePage,
  }) : super(key: key);

  @override
  State<ResumeProductCard> createState() => _ResumeProductCardState();
}

class _ResumeProductCardState extends State<ResumeProductCard> {
  bool isEmpty(String? str) {
    if (str == null || str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () async {
          var needsUpdatePage = await AppNavigation.navigateToUpdateProduct(
            context,
            widget.product,
            widget.idList,
          );

          if (needsUpdatePage == null || needsUpdatePage == true) {
            widget.onUpdatePage();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 14,
          ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  if (!isEmpty(widget.product.description)) ...[
                    Text(
                      widget.product.description!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                  Visibility(
                    visible: !isEmpty(widget.product.measure) ||
                        !isEmpty(widget.product.brand),
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Wrap(
                        children: [
                          if (!isEmpty(widget.product.unitOfMeasurement) &&
                              !(isEmpty(widget.product.measure)))
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Chip(
                                label: Text(
                                  "${widget.product.measure} ${widget.product.unitOfMeasurement}",
                                ),
                                backgroundColor: AppColors.primaryLight,
                              ),
                            ),
                          if (!isEmpty(widget.product.brand))
                            Chip(
                              label: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 180),
                                child: Text(
                                  "${widget.product.brand}",
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              backgroundColor: AppColors.secundary,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
