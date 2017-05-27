function searchOsaifuMail() {
  //Gmailの検索条件
  var strTerms ="http://n.osaifu.com/contents/clickevent/?id"
  // 0から5件のスレッドを取得する
  var myThreads = GmailApp.search(strTerms, 0, 5);

  var myMessages = GmailApp.getMessagesForThreads(myThreads);

  var clickLinks = [];

  // UrlFetchAppのオプション
  var options = {"method" : "GET" , "followRedirects" : true };

  for(var i = 0; i < myMessages.length; i++){
    clickLinks[i] = myMessages[i][0].getPlainBody().match("http.*/contents/clickevent.*");
    Logger.log(clickLinks[i]);

    var redirect_url = UrlFetchApp.fetch(clickLinks[i], options).getResponseCode();
    Logger.log(redirect_url);
  }

}
