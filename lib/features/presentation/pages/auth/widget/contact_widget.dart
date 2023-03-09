part of '../login.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Positioned(
          bottom: MediaQuery.of(context).size.height / 5,
          child: MaterialButton(
            child: Row(
              children: [
                Text("Liên hệ tổng đài :  113 ",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Theme.of(context).hintColor)))
              ],
            ),
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Gọi cho VILL để được hỗ trợ'),
                      content: Row(
                        children: [
                          Icon(
                            Icons.contact_phone,
                            color: Theme.of(context).hintColor,
                            size: 20,
                          ),
                          const Text(' Tel: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 2.0),
                          const Text(
                            "113",
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          child: SizedBox(
                            width: 45.0,
                            height: 45.0,
                            // ignore: deprecated_member_use
                            child: MaterialButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                //launchUrlString("tel:${state.setting!.phone}");
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              shape: const StadiumBorder(),
                              child: Icon(
                                Icons.call,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black.withOpacity(0.7)
                                    : Theme.of(context).primaryColor,
                                size: 25.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // final _phone = setting.phone;
                            // launch("tel:$_phone");
                          },
                        ),
                      ],
                    )),
          ),
        );
      },
    );
  }
}
