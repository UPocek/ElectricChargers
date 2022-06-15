import 'package:ev_chargers/screens/home_screen.dart';
import 'package:ev_chargers/widgets/action_button.dart';
import 'package:flutter/material.dart';
import '../models/car.dart';

class CarPickingScreen extends StatefulWidget {
  final bool firstTime;
  const CarPickingScreen(this.firstTime, {super.key});

  @override
  State<CarPickingScreen> createState() => _CarPickingScreenState();
}

class _CarPickingScreenState extends State<CarPickingScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  List<Image> images = [
    Image.asset(
      'assets/images/tesla.jpeg',
    ),
    Image.asset('assets/images/ferrari.jpeg'),
    Image.asset('assets/images/audi.jpeg'),
  ];

  var cars;

  int activePage = 0;

  getCars() async {
    cars = await Car.getCars();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cars != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => const HomeScreen()),
                              ),
                            );
                          },
                          icon: const Icon(Icons.close)),
                    ],
                  ),
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
                        "${cars?[activePage].make} ${cars?[activePage].model}",
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      )),
                  ActionButton(
                    "Select",
                    () async => {
                      if (await Car.setUsersCar(
                        cars?[activePage].id,
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
                        },
                      if (widget.firstTime)
                        {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => const HomeScreen()),
                            ),
                          ),
                        }
                      else
                        {
                          Navigator.of(context).pop(),
                        }
                    },
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(
      imagesLength,
      (index) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: currentIndex == index ? Colors.black : Colors.black26,
              shape: BoxShape.circle),
        );
      },
    );
  }

  AnimatedContainer slider(images, pagePosition, active) {
    double margin = active ? 10 : 20;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
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
        ],
      ),
    );
  }
}
