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
                  bulderCrousel(ShopAppCubit.get(context).homeData, context)),
              fallback: (context) {
                return const Center(child: CircularProgressIndicator());
              }),
        );
      },
    );
  }
}

Widget bulderCrousel(HomeData model, context) {
  return Column(
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
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 1.58,
          children: List.generate(
            model.data!.products.length,
            (index) => buildGridProduct(model.data!.products[index], context),
          ),
        ),
      ),
    ],
  );
}

Widget buildGridProduct(DataModel model, BuildContext context) {
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(model.image!),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(
          .8,
        ),
        width: 100.0,
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
