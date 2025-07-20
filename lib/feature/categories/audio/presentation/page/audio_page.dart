import 'package:file_manager/feature/categories/audio/data/datasource/audio_datasource.dart';
import 'package:file_manager/feature/categories/audio/data/repo/audio_repo_impl.dart';
import 'package:file_manager/feature/categories/audio/domain/usecase/get_audio_files.dart';
import 'package:file_manager/feature/categories/audio/presentation/bloc/audio_bloc.dart';
import 'package:file_manager/feature/categories/audio/presentation/widget/audio_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataSource = AudioLocalDataSource();
        final audioRepository = AudioRepoImpl(localDataSource: dataSource);
        final useCase = GetAudioFiles(audioRepo: audioRepository);
        return  AudioBloc(useCase)..add(LoadAudioEvent());
      },
      child: AudioView(),
    );
  }
}
