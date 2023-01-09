import 'package:hesham/core/resources/app_constant.dart';
import 'package:equatable/equatable.dart';
class Attachments extends Equatable{
  final int id;
  final String lessonId;
  final String title;
  final String file;
  final String finalDateReceive;

  @override
  List<Object?> get props => [id,lessonId,title,file,finalDateReceive];

  const Attachments(this.id,this.lessonId, this.title, this.file, this.finalDateReceive);
  const Attachments.empty():this(
    AppConstants.defaultEmptyInteger,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyString,
  );


}
class Lesson extends Equatable{
  final int id;
  final String courseId;
  final String title;
  final String video;
  final List<Attachments> attachments;

  @override
  List<Object?> get props => [id,courseId,title,video,attachments];

  const Lesson(this.id,this.courseId ,this.title, this.video, this.attachments);
  const Lesson.empty():this(
    AppConstants.defaultEmptyInteger,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyString,
    const <Attachments>[],
  );
}
class Images extends Equatable{
  final List<String> images;


  @override
  List<Object?> get props => [images];

  const Images(this.images);
  const Images.empty():this(
    const <String>[],
  );
}

class Courses extends Equatable {
  final int id;
  final String subjectId;
  final String title;
  final String description;
  final List<Lesson> lessons;

  @override
  List<Object?> get props => [id, title, description,subjectId,lessons];

  const Courses(this.id,this.subjectId ,this.title, this.description,this.lessons);

  const Courses.empty() :this(
      AppConstants.defaultEmptyInteger,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      const<Lesson>[]
  );
}
class Subject extends Equatable{
  final int id;
  final String title;
  final String description;
  final String state;
  final List<Courses> courses;

  @override

  List<Object?> get props => [id,title,description,state,courses];

 const Subject(this.id, this.title, this.description,this.state,this.courses);
 const Subject.empty():this(AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyString,AppConstants.defaultEmptyString,AppConstants.defaultEmptyString,const <Courses>[]);

}
class HomeContent extends Equatable{
   final List<Subject> subjects;
   final List<String> images;


  @override

  List<Object?> get props => [subjects,images];

  const HomeContent(this.subjects,this.images);
  const HomeContent.empty():this(const <Subject>[],const <String>[]);
}
class HomeData extends Equatable{
   final HomeContent data;


  @override

  List<Object?> get props => [data];

  const HomeData( this.data);
  const HomeData.empty():this(const HomeContent.empty());
}
class SuccessData extends Equatable{
   final String data;


  @override

  List<Object?> get props => [data];

  const SuccessData( this.data);
  const SuccessData.empty():this(AppConstants.defaultEmptyString);
}
class LessonData extends Equatable{
  final List<Lesson> data;


  @override

  List<Object?> get props => [data];

  const LessonData( this.data);
  const LessonData.empty():this(const <Lesson>[]);
}