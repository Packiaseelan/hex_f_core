import 'package:flutter/material.dart';

import 'package:example_mobile_app/features/landing/view/widgets/landing_view_base_attribute.dart';

class LandingViewBaseWidget extends StatelessWidget {
  final LandingViewBaseAttribute attribute;

  const LandingViewBaseWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...attribute.menu
                .map(
                  (e) => InkWell(
                    onTap: () => attribute.onPressed(e),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.name.toUpperCase(),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const Icon(Icons.chevron_right)
                        ],
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final List<String> categories;
  const Categories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories'),
          SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(categories[index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
