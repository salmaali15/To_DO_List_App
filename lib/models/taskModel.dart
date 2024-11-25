class taskModel{
  final int? id;
  final String? title;
  final String? level;
  final bool isDone;
  final String? datetime;
  taskModel({
    this.id,
    this.title,
    this.level,
    this.isDone = false,
    this.datetime,
  });

  Map<String,dynamic> toMap(){
    return{
      if(title != null )"title": title,
      if(datetime != null )"datetime": datetime,
      if(level != null )"level": level,
      "isDone": isDone?1:0,
    };
  }
  factory taskModel.fromMap(Map<String,dynamic> map){
    return taskModel(
      id: map["id"],
      title: map["title"],
      level: map["level"],
      datetime: map["datetime"],
      isDone: map["isDone"] == 0 ? false : true,
    );
  }
}