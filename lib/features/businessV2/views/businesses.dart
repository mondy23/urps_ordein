import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:urps_ordein/const/constant.dart';
import 'package:urps_ordein/features/business/model/business_model.dart';
import 'package:urps_ordein/features/business/provider/business_provider.dart';
import 'package:urps_ordein/features/business/widget/create_business.dart';
import 'package:urps_ordein/features/businessV2/views/widgets/paginator.dart';
import 'package:urps_ordein/features/user_details/controllers/user_controller.dart';

class Businesses extends ConsumerWidget {
  const Businesses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessesList = ref.watch(businessListProvider);
    return businessesList.when(
      data: (business) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 47,
                left: 16,
                right: 16,
                bottom: 47,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Companies',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        'List of companies on the platform',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(129, 72, 83, 111),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                           Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CreateBusinessPage(),
                          ),
                        );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            primaryColor,
                          ),
                          shape: WidgetStateProperty.all(CircleBorder()),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.all(18),
                          ),
                        ),
                        child: Icon(Icons.add, size: 24, color: Colors.white),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            secondaryColor,
                          ),
                          shape: WidgetStateProperty.all(StadiumBorder()),
                          padding: WidgetStatePropertyAll(EdgeInsets.all(18)),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                itemCount: business.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  BusinessModel data = business[index];
                  return BusinessCard(data: data, ref: ref,);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 42),
              child: Paginator(),
            ),
          ],
        );
      },
      error: (error, stack) => Center(child: Text('No data found')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class BusinessCard extends StatefulWidget {
  final BusinessModel data;
  final WidgetRef ref;
  const BusinessCard({super.key, required this.data, required this.ref});

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final business = widget.data;
    final ref = widget.ref;
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        hoverColor: backgroundColor,
        onTap: () {
               ref.read(businessIDProvider.notifier).state = business.businessID!;
                context.go('/businesses/${business.businessID!}/users');
        },
        child: Container(
          margin: isHovered ? EdgeInsets.all(8) : EdgeInsets.all(12),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: cardBackgroundColor,
          ),
          child: Stack(
            children: [
              Positioned(
                left: 210,
                child: Icon(Icons.circle, size: 16, color: primaryColor),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image(
                    image: AssetImage('assets/images/ottokonek_logo.jpeg'),
                    width: 60,
                    height: 60,
                  ),
                  SizedBox(width: 8),
                  Text(
                    business.businessName.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 70,
                child: Row(
                  children: [
                    Icon(Icons.pix_outlined, color: textColor, size: 18),
                    SizedBox(width: 8),
                    Text(
                      '${business.pointsReleased} pts',
                      style: TextStyle(
                        color: Color.fromARGB(148, 72, 83, 111),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                child: Row(
                  children: [
                    Icon(Icons.people_alt_outlined, color: textColor, size: 18),
                    SizedBox(width: 8),
                    Text(
                      '${business.totalUsers} user’s',
                      style: TextStyle(
                        color: const Color.fromARGB(148, 72, 83, 111),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}