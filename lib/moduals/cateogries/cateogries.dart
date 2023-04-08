import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categories_model.dart';
import '../../sherd/components/components.dart';
import '../../sherd/cubit/app_cubit.dart';
import '../../sherd/cubit/state.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCatItem(
              ShopAppCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount:
              ShopAppCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
