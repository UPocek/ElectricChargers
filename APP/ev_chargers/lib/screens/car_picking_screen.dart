import 'package:ev_chargers/screens/home_screen.dart';
import 'package:ev_chargers/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import '../helper.dart';
import '../models/car.dart';
import '../models/user.dart';
import '../widgets/big_text_field.dart';
import '../style.dart';
import '../widgets/padding_card.dart';

class CarPickingScreen extends StatefulWidget {
  const CarPickingScreen({super.key});

  @override
  State<CarPickingScreen> createState() => _CarPickingScreenState();
}

class _CarPickingScreenState extends State<CarPickingScreen> {
  late PageController _pageController;
  List<Image> images = [
    Image.asset(
      'assets/images/tesla.jpeg',
    ),
    Image.asset('assets/images/audi.jpeg'),
    Image.asset('assets/images/ferrari.jpeg'),
  ];
  late List<Car> cars;

  int activePage = 1;

  getCars() async {
    // cars = await User.getCars() as List<Car>;
    cars = [
      Car("1", "R8", "Audi"),
      Car("2", "LaFerrari", "Ferrari"),
      Car("3", "Model3", "Tesla")
    ];
  }

  @override
  initState() {
    super.initState();
    getCars();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(onPressed: null, icon: Icon(Icons.close)),
        Text(
          "Pick your car",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(
          height: 50.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                //checking active position
                bool active = pagePosition == activePage;
                return slider(images, pagePosition, active);
              }),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length, activePage)),
        Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              "${cars[activePage].make} ${cars[activePage].model}",
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            )),
        ActionButton(
            "Select",
            () async => {
                  if (await User.setUsersCar(
                    cars[activePage].id,
                  ))
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Succesfully added your car."),
                        ),
                      ),
                    }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Sorry, couldn't add your car."),
                        ),
                      ),
                    }
                }),
      ],
    )));
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  AnimatedContainer slider(images, pagePosition, active) {
    double margin = active ? 10 : 20;
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
            image: DecorationImage(image: images[pagePosition].image),
            //Border.all
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                offset: Offset(
                  5.0,
                  5.0,
                ), //Offset
                blurRadius: 20.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ]));
  }
}
