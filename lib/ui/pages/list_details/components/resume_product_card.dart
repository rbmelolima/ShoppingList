import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/main/routes/navigation.dart';
import 'package:shoppinglist/ui/style/style.dart';

class ResumeProductCard extends StatefulWidget {
  final ProductEntity product;
  final String idList;

  const ResumeProductCard({
    Key? key,
    required this.product,
    required this.idList,
  }) : super(key: key);

  @override
  State<ResumeProductCard> createState() => _ResumeProductCardState();
}

class _ResumeProductCardState extends State<ResumeProductCard> {
  bool isEmpty(String? str) {
    if (str == null) return true;
    if (str.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      child: InkWell(
        onTap: () {
          AppNavigation.navigateToUpdateProduct(
            context,
            widget.product,
            widget.idList,
          );
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 14,
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
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        widget.product.description!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                  if (!isEmpty(widget.product.unitOfMeasurement) &&
                      !(isEmpty(widget.product.measure))) ...[
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: Chip(
                        label: Text(
                          "${widget.product.measure} ${widget.product.unitOfMeasurement}",
                        ),
                        backgroundColor: AppColors.primaryLight,
                      ),
                    )
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
