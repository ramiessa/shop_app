import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:earthcuacke/sherd/cubit/app_cubit.dart';
import 'package:earthcuacke/sherd/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        options: CarouselOptions(
          height: 400.0,
          viewportFraction: .98,
        ),
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
      ),
      const SizedBox( height:  3,),
      Text('${i.}')
    ],
  );
}
