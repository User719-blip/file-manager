import 'package:file_manager/feature/categories/images/data/data_sources/image_source.dart';
import 'package:file_manager/feature/categories/images/data/repo/image_repo_implemenataion.dart';
import 'package:file_manager/feature/categories/images/domain/usecase/image_usecase.dart';
import 'package:file_manager/feature/categories/images/presentation/bloc/images_bloc.dart';
import 'package:file_manager/feature/categories/images/presentation/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final dataSource = ImageDataSource();
        final repository = ImageRepoImpl(dataSource);
        final useCase = GetImages(imageRepo: repository);
        return ImagesBloc(useCase: useCase,)..add(LoadImageEvents());
      },
      child: ImageView(),
    );
  }
}
