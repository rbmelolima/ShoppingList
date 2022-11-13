import 'package:flutter/material.dart';
import 'package:shoppinglist/domain/entities/entities.dart';
import 'package:shoppinglist/ui/components/leading_btn.dart';
import 'package:shoppinglist/ui/components/prevent_navigation.dart';
import 'package:shoppinglist/ui/style/color.dart';
import 'package:shoppinglist/utils/utils.dart';

import 'update_list_presenter.dart';

class UpdateListPage extends StatefulWidget {
  final UpdateListPresenter presenter;
  final ShoppingListEntity list;

  const UpdateListPage({
    Key? key,
    required this.presenter,
    required this.list,
  }) : super(key: key);

  @override
  State<UpdateListPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateListPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.presenter.fill(widget.list);
    super.initState();
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundScaffold,
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        centerTitle: false,
        leading: LeadingBtn(
          onBack: () {
            if (widget.presenter.isEditing) {
              preventNavigation(
                context,
                title: 'Alerta',
                content: "Você ainda não terminou de editar a lista.\n\nDeseja realmente sair?",
              );
            } else {
              if (widget.presenter.wasEdited) Navigator.pop(context, true);
              if (!widget.presenter.wasEdited) Navigator.pop(context, false);
            }
          },
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 36),
              child: Text(
                "Sobre a lista",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            TextFormField(
              controller: widget.presenter.listName,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              onChanged: (_) {
                widget.presenter.isEditing = true;
              },
              decoration: const InputDecoration(
                hintText: "Nome da lista",
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                maxLines: 3,
                controller: widget.presenter.listDescription,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                onChanged: (_) {
                  setState(() {
                    widget.presenter.isEditing = true;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Características da sua lista, como propósito, data de uso e outros",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                readOnly: true,
                initialValue: formatDate(DateTime.parse(widget.list.createdAt)),
                decoration: const InputDecoration(
                  labelText: "Data de criação",
                  enabled: false,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                readOnly: true,
                initialValue: formatDate(DateTime.parse(widget.list.updatedAt)),
                decoration: const InputDecoration(
                  labelText: "Última atualização",
                  enabled: false,
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(bottom: 16, top: 12),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    FocusScope.of(context).unfocus();
                    await widget.presenter.save();
                    if (mounted) Navigator.pop(context, true);
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Não foi possível salvar as alterações",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text("salvar".toUpperCase()),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                onPressed: () async {
                  try {
                    await widget.presenter.delete();
                    if (mounted) Navigator.pop(context, true);
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Não foi possível excluir a lista",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: Text("excluir lista".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
