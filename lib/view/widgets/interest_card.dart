part of 'widgets.dart';

class InterestCard extends StatelessWidget {
  final UserInterest userInterest;
  final Function onTap;

  InterestCard(this.userInterest, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(5.0),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: userInterest.urlIcon,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            userInterest.category,
            style: blackTextFont,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
