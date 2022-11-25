import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'examples/route/examples/modal_complex_all.dart';
import 'examples/route/examples/modal_fit.dart';
import 'examples/route/examples/modal_fit_will_scope.dart';
import 'examples/route/examples/modal_inside_modal.dart';
import 'examples/route/examples/modal_will_scope.dart';
import 'examples/route/examples/modal_with_navigator.dart';
import 'examples/route/examples/modal_with_page_view.dart';
import 'examples/route/modals/avatar_sheet.dart';
import 'examples/route/modals/bar_sheet.dart';
import 'examples/route/modals/dialog_sheet.dart';
import 'examples/route/modals/floating_sheet.dart';
import 'examples/route/modals/material_sheet.dart';
import 'src/route/cupertino/sheet_route.dart';
import 'src/sheet.dart';

class RouteExamplePage extends StatelessWidget {
  const RouteExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: CupertinoPageScaffold(
          backgroundColor: Colors.white,
          navigationBar: const CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            middle: Text('Sheet Routes'),
          ),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              primary: true,
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SectionTitle('STYLES'),
                    ListTile(
                      title: const Text('Material fit'),
                      onTap: () => Navigator.of(context).push(
                        MaterialSheetRoute<void>(
                          fit: SheetFit.loose,
                          builder: (BuildContext context) => const ModalFit(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Bar Modal'),
                      onTap: () => Navigator.of(context).push(
                        BarSheetRoute<void>(
                          fit: SheetFit.loose,
                          builder: (BuildContext context) => const ModalInsideModal(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Avatar Modal'),
                      onTap: () {
                        Navigator.of(context).push(
                          AvatarSheetRoute<void>(
                            builder: (BuildContext context) => const ModalInsideModal(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Float Modal'),
                      onTap: () {
                        Navigator.of(context).push(
                          FloatingSheetRoute<void>(
                            builder: (BuildContext context) => const ModalFit(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Cupertino Modal'),
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoSheetRoute<void>(
                            builder: (BuildContext context) => const ModalFit(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Cupertino Sheet with stops'),
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoSheetRoute<void>(
                            initialStop: 0.5,
                            stops: <double>[0, 0.5, 1],
                            builder: (BuildContext context) => const ModalFit(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Cupertino Scrollable Sheet with stops'),
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoSheetRoute<void>(
                            initialStop: 0.5,
                            stops: <double>[0, 0.5, 1],
                            builder: (BuildContext context) => const ModalInsideModal(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Material Sheet with stops'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialSheetRoute<void>(
                            initialStop: 0.5,
                            stops: <double>[0, 0.5, 1],
                            builder: (BuildContext context) => const ModalFit(),
                          ),
                        );
                      },
                    ),
                    const SectionTitle('COMPLEX CASES'),
                    ListTile(
                      title: const Text('Cupertino Modal inside modal'),
                      onTap: () => Navigator.of(context).push(
                        CupertinoSheetRoute<void>(
                          builder: (BuildContext context) => const ModalInsideModal(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Cupertino Modal with inside navigation'),
                      onTap: () => Navigator.of(context).push(
                        CupertinoSheetRoute<void>(
                          builder: (BuildContext context) => const ModalWithNavigator(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Cupertino Navigator + Scroll + WillPopScope'),
                      onTap: () => Navigator.of(context).push(
                        CupertinoSheetRoute<void>(
                          builder: (BuildContext context) => const ComplexModal(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Modal with WillPopScope'),
                      onTap: () => Navigator.of(context).push(
                        CupertinoSheetRoute<void>(
                          builder: (BuildContext context) => const ModalWillScope(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Modal Fit with WillPopScope'),
                      onTap: () => Navigator.of(context).push(
                        CupertinoSheetRoute<void>(
                          fit: SheetFit.loose,
                          builder: (BuildContext context) => const ModalFitWillScope(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Modal with PageView'),
                      onTap: () => Navigator.of(context).push(
                        CupertinoSheetRoute<void>(
                          builder: (BuildContext context) => const ModalWithPageView(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Foldable Screen - Fit'),
                      onTap: () => Navigator.of(context).push(
                        FloatingSheetRoute<void>(
                          builder: (BuildContext context) => const ModalFit(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Dialog Modal for tablet - Expanded'),
                      onTap: () => Navigator.of(context).push(
                        DialogSheetRoute<void>(
                          builder: (BuildContext context) => const ModalInsideModal(),
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Dialog Modal for tablet - Fit'),
                      onTap: () => Navigator.of(context).push(
                        DialogSheetRoute<void>(
                          builder: (BuildContext context) => const ModalFit(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  // ignore: sort_constructors_first
  const SectionTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}

extension ListUtils<T> on List<T> {
  List<T> addItemInBetween(T item) => length <= 1
      ? this
      : sublist(1).fold(
          <T>[first],
          (List<T> r, T element) => <T>[...r, item, element],
        );
}
