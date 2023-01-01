import 'package:flutter/material.dart';
import 'package:shopmobile/ui/features/chat/app.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:shopmobile/ui/features/chat/widgets/unread_indicator.dart' as unread;
import '../screens/chat_screen.dart';
import '../theme.dart';
import '../widgets/widgets.dart';
import '../helpers.dart';

class MessagesPage extends StatefulWidget {
  MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final channelListController = ChannelListController();

  @override
  Widget build(BuildContext context) {
    return ChannelListCore(
      channelListController: channelListController,
      filter: Filter.and(
        [
          Filter.equal('type', 'messaging'),
          Filter.in_('members', [
            StreamChatCore.of(context).currentUser!.id,
          ])
        ],
      ),
      errorBuilder: (context, error) => DisplayErrorMessage(
        error: error,
      ),
      emptyBuilder: (context) => const Center(
          child: Text(
        "So empty.\n Go and message someone.",
        textAlign: TextAlign.center,
      )),
      loadingBuilder: (context) => const Center(
          child: SizedBox(
              height: 100, width: 100, child: CircularProgressIndicator())),
      listBuilder: (p0, channel) => CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: _Stories(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MessageTitle(
                      channel: channel[index],
                    ),
                childCount: channel.length
                // _delegate,
                ),
          )
        ],
      ),
    );
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.2, color: Colors.grey))),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Avatar.medium(
                  url: Helpers.getChannelImage(channel, context.currentUser!),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        Helpers.getChannelName(channel, context.currentUser!),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            wordSpacing: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: _buildLastMessage(),
                    )
                  ],
                ),
              ),
              // const SizedBox(
              //   width: 5,
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    _buildLastMessageAt(),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: unread.UnreadIndicator(
                        channel: channel,
                      )
                    )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 20.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const Text(
                //         "messageData.dateMessage.toUpperCase()",
                //         style: const TextStyle(
                //             fontSize: 12,
                //             color: AppColors.textFaded,
                //             letterSpacing: -0.2,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       const SizedBox(
                //         height: 8,
                //       ),
                //       Container(
                //         height: 18,
                //         width: 18,
                //         decoration: const BoxDecoration(
                //             color: AppColors.secondary, shape: BoxShape.circle),
                //         child: const Center(
                //           child: Text(
                //             "1",
                //             overflow: TextOverflow.ellipsis,
                //             style: TextStyle(
                //                 fontSize: 14, color: AppColors.textLigth),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastMessage() {
    return BetterStreamBuilder<int>(
      stream: channel.state!.unreadCountStream,
      initialData: channel.state?.unreadCount ?? 0,
      builder: (context, count) {
        return BetterStreamBuilder<Message>(
          stream: channel.state!.lastMessageStream,
          initialData: channel.state!.lastMessage,
          builder: (context, lastMessage) {
            return Text(
              lastMessage.text ?? '',
              overflow: TextOverflow.ellipsis,
              style: (count > 0)
                  ? const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondary,
                    )
                  : const TextStyle(
                      fontSize: 12,
                      color: AppColors.textFaded,
                    ),
            );
          },
        );
      },
    );
  }

  Widget _buildLastMessageAt() {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy(lastMessageAt.toLocal()).jm;
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch) {
          stringDate = 'YESTERDAY';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
        } else {
          stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: AppColors.textFaded,
          ),
        );
      },
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 0,
        child: SizedBox(
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 16),
                child: Text(
                  'Stories',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: AppColors.textFaded,
                  ),
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       var faker = Faker();
              //       return SizedBox(
              //           width: 60,
              //           child: _StoryCard(
              //               storyData: StoryData(
              //             name: faker.person.firstName(),
              //             url: Helpers.randomPictureUrl(),
              //           )));
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// class _StoryCard extends StatelessWidget {
//   const _StoryCard({
//     Key? key,
//     required this.storyData,
//   }) : super(key: key);
//
//   final StoryData storyData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Avatar.medium(
//           url: storyData.url,
//           onTap: () {},
//         ),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Text(
//               storyData.name,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 fontSize: 11,
//                 letterSpacing: 0.3,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
