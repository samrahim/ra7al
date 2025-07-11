import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authbloc/auth_bloc.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 38,
                width: 38,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton(
                  icon: Icon(
                    Icons.menu,
                    color: Color.fromARGB(230, 23, 182, 57),
                  ),

                  itemBuilder: (_) {
                    return [
                      PopupMenuItem(
                        child: TextButton.icon(
                          onPressed: () {
                            context.read<AuthBloc>().add(LogoutRequested());
                          },
                          label: const Text("تسجيل الخروج"),
                          icon: const Icon(Icons.logout, color: Colors.black),
                        ),
                      ),
                    ];
                  },
                ),
              ),
              SizedBox(width: 4),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: Color.fromARGB(230, 23, 182, 57),
                        content: Text(
                          'الميزة قيد التطوير',
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.notifications,
                    color: Color.fromARGB(230, 23, 182, 57),
                  ),
                ),
              ),
            ],
          ),

          Image.asset(
            'assets/ddddd.png',

            width: MediaQuery.of(context).size.width * .3,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated &&
                  (state.user.photoURL != null ||
                      state.user.displayName != null)) {
                return Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(state.user.displayName!),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.network(
                          state.user.photoURL!,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is Authenticated && state.user.displayName != null) {
                return Text(state.user.displayName!);
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
