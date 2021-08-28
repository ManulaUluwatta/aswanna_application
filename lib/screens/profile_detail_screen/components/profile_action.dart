import 'package:aswanna_application/components/nothing_to_show_container.dart';
import 'package:aswanna_application/components/top_rounded_container.dart';
import 'package:aswanna_application/screens/profile_detail_screen/components/profile_details.dart';
import 'package:aswanna_application/screens/profile_detail_screen/components/profile_pircture.dart';
import 'package:aswanna_application/services/data_streem/address_steam.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProfileActionsSection extends StatefulWidget {
  final String userID;
  const ProfileActionsSection({
    Key key,
    @required this.userID
  }) : super(key: key);

  @override
  _ProfileActionsSectionState createState() => _ProfileActionsSectionState(addressesStream:AddressesStream(userID));
}

class _ProfileActionsSectionState extends State<ProfileActionsSection> {
  final AddressesStream addressesStream;

  _ProfileActionsSectionState({@required this.addressesStream});

  @override
  void initState() {
    addressesStream.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: [
        Stack(
          children: [
            TopRoundedContainer(
              // child: ProfileDetail(userID: widget.userID),
              child: StreamBuilder<List<String>>(
                      stream: addressesStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final addresses = snapshot.data;
                          if (addresses.length == 0) {
                            return Center(
                              child: NothingToShowContainer(
                                iconPath: "assets/icons/add_location.svg",
                                secondaryMessage: "Add your first Address",
                              ),
                            );
                          }
                          return 
                              ProfileDetail(userID: widget.userID, addressId: addresses[0]);
                              
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          final error = snapshot.error;
                          Logger().w(error.toString());
                        }
                        return Center(
                          child: NothingToShowContainer(
                            iconPath: "assets/icons/network_error.svg",
                            primaryMessage: "Something went wrong",
                            secondaryMessage: "Unable to connect to Database",
                          ),
                        );
                      },
                    ), 
            ),
            Align(
              alignment: Alignment.topRight,
              child: ProfilePicture(userID: widget.userID),
            ),
          ],
        ),
      ],
    ); return column;
  }
}