import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_bloc.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_event.dart';
import '../../../../Controller/bloc/Driverbloc/driverbloc_state.dart';

class Dasgboardmain extends StatefulWidget {
  const Dasgboardmain({super.key});

  @override
  State<Dasgboardmain> createState() => _DasgboardmainState();
}

class _DasgboardmainState extends State<Dasgboardmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<DriverblocBloc, DriverblocState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () {
                context
                    .read<DriverblocBloc>()
                    .add(FetchDrivers(status: true, searchQuery: null));
              },
              child: Text("Refresh"),
            );
          },
        ),
      ),
    );
  }
}
