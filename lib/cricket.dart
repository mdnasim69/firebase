class CricketMatch {
  int run;
  int wicket;
  double over;
  String id ;
  CricketMatch({required this.run ,required this.wicket ,required this.over , required this.id});

  factory CricketMatch.fromJson(Map<String,dynamic> json,String? ID){
    return CricketMatch(
      run: json['run'],
      wicket: json['wicket'],
      over: json['over'],
      id: ID ??" ##",
    );
  }
}