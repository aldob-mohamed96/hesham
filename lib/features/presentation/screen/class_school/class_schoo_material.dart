
import 'dart:async';
import 'dart:io';

import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../business_logic/bloc/home/home_bloc.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../common/widget/full_empty_screen.dart';
import '../../common/widget/full_error_screen.dart';
import '../../common/widget/loading_widget.dart';
import '../../common/widget/main_scaffold_auth.dart';
import '../home/home_screen.dart';

class ClassScreenMaterial extends StatelessWidget {
  const ClassScreenMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageClassScreenMaterial();
  }
}
class PageClassScreenMaterial extends StatelessWidget {
  const PageClassScreenMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   BlocProvider(create: (_) => instance<HomeBloc>(),child:const  HomeScaffold(widget:ContentMaterial()),);
  }
}
class ContentMaterial extends StatelessWidget {
  const ContentMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: BlocBuilder<HomeBloc, HomeState>(
           builder: (context, state) {

                return const ItemsContentMaterial();






  },
),), onRefresh: ()async{

    });
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height/2,
      child: FullEmptyScreen(retryActionFunction: (){
      },),
    );
  }
}
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return FullErrorScreen(error: state.failure.message,retryActionFunction: (){

          },);
        },
      ),
    );
  }
}

class ItemsContentMaterial extends StatelessWidget {
  const ItemsContentMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Lesson lesson=ModalRoute.of(context)!.settings.arguments as Lesson;
    return SingleChildScrollView(
      child: SizedBox(
        height: 380,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 120,left: 10,right: 10),
            child:  GridView.builder(
                physics:const AlwaysScrollableScrollPhysics(),
                itemCount: lesson.attachments.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, position) {
                  return _cardGrid(context,lesson.attachments[position]);
                })

        ),
      ),
    );
  }
}

_cardGrid(BuildContext context,Attachments courses){
  return  GestureDetector(
    onTap: (){

      if(courses.file.endsWith(".pdf"))
        {
          Navigator.of(context).pushNamed(Routes.classPdfShow,arguments: courses.file);
        }
      else
        {
         Navigator.of(context).pushNamed(Routes.classImageShow,arguments: courses.file,);

        }
    },
    child: Container(
      alignment: Alignment.center,
      margin:const EdgeInsets.all(AppPadding.appPadding4),
      decoration: BoxDecoration(
          borderRadius:const BorderRadius.all(Radius.circular(AppSize.appSize10)),
          gradient: LinearGradient(
            colors: [
              ColorManager.whiteColor,
              ColorManager.primaryColorgreen,


            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
      ),
      height: AppSize.appSize100,

      child: Text(courses.title,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color:
        ColorManager.whiteColor,fontWeight: FontWeight.bold,fontSize: FontSize.fontSize16,),),

    ),
  );


}

class ImageView extends StatelessWidget {
  const ImageView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String img=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(img),
      ),
    );
  }
}
class PdfViewFile extends StatefulWidget {
  final String url;
  const PdfViewFile({Key? key,required this.url}) : super(key: key);

  @override
  State<PdfViewFile> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfViewFile> {
  String? localPath;
  @override
  void initState() {

    super.initState();
    createFileOfPdfUrl(widget.url).then((value) {
      setState(() {
        localPath = value.path;
      });
    });

  }

  Future<File> createFileOfPdfUrl(String url) async {
    Completer<File> completer = Completer();

    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }






  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: localPath != null
          ? PDFView(
        filePath: localPath,
      )
          :const Center(child: CircularProgressIndicator()),
    );
  }

}