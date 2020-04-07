import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ReviewerProvider with ChangeNotifier {
  int pageCounter = 1;
  void goBack({@required PageController controller}) {

    var currentPage = controller.page;
    print(currentPage);
    if (currentPage!=1)  {
        controller.previousPage(
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }
    
  }

  void goForward({@required PageController controller}) {
     controller.nextPage(
          duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
