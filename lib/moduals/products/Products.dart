import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:earthcuacke/sherd/cubit/app_cubit.dart';
import 'package:earthcuacke/sherd/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categories_model.dart';
import '../../models/home_model.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
              condition: ShopAppCubit.get(context).homeData != null,
              builder: ((context) =>
                  bulderScreen(ShopAppCubit.get(context).homeData, context)),
              fallback: (context) {
                return const Center(child: CircularProgressIndicator());
              }),
        );
      },
    );
  }
}

Widget bulderScreen(HomeData model, context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        CarouselSlider(
          items: model.data?.banners.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: Image(
                      image: NetworkImage(i.image),
                    ));
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Products',
                style: TextStyle(fontSize: 25),
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.5,
                  children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildGridProduct(model.data!.products[index], context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildGridProduct(ProductModel model, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 170.0,
              width: 170.0,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                child: Text(
                  'Discount',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${model.name} ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Text(
              '${model.price.round()}',
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            if (model.discount != 0)
              Text(
                '${model.oldPrice.round()}',
                style: const TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 15.0,
                backgroundColor: ShopAppCubit.get(context).favorites[model.id]!
                    ? Colors.blue
                    : Colors.grey,
                child: Icon(
                  Icons.favorite_border,
                  size: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
