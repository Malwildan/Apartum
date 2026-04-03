import 'package:apartum/core/network/dio_client.dart';
import 'package:apartum/core/network/token_storage.dart';
import 'package:apartum/core/router.dart';
import 'package:apartum/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:apartum/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:apartum/features/auth/domain/repositories/auth_repository.dart';
import 'package:apartum/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:apartum/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:apartum/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:apartum/features/profile/domain/repositories/profile_repository.dart';
import 'package:apartum/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:apartum/features/konseling/data/datasources/konseling_remote_data_source.dart';
import 'package:apartum/features/konseling/data/repositories/konseling_repository_impl.dart';
import 'package:apartum/features/konseling/domain/repositories/konseling_repository.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_cubit.dart';
import 'package:apartum/features/konseling/presentation/cubit/konseling_detail_cubit.dart';
import 'package:apartum/features/riwayat_catatan/data/datasources/sleep_remote_data_source.dart';
import 'package:apartum/features/riwayat_catatan/data/repositories/sleep_repository_impl.dart';
import 'package:apartum/features/riwayat_catatan/domain/repositories/sleep_repository.dart';
import 'package:apartum/features/riwayat_catatan/data/datasources/symptom_remote_data_source.dart';
import 'package:apartum/features/riwayat_catatan/data/repositories/symptom_repository_impl.dart';
import 'package:apartum/features/homepage/presentation/bloc/homepage_bloc.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/sleep_bloc.dart';
import 'package:apartum/features/riwayat_catatan/domain/repositories/symptom_repository.dart';
import 'package:apartum/features/riwayat_catatan/presentation/bloc/symptom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const secureStorage = FlutterSecureStorage();
  final tokenStorage = TokenStorage(secureStorage);
  final dioClient = DioClient(tokenStorage);

  final authDataSource = AuthRemoteDataSourceImpl(dioClient);
  final authRepository = AuthRepositoryImpl(authDataSource, tokenStorage);

  final profileDataSource = ProfileRemoteDataSourceImpl(dioClient);
  final profileRepository = ProfileRepositoryImpl(profileDataSource);

  final konselingDataSource = KonselingRemoteDataSourceImpl(dioClient);
  final konselingRepository = KonselingRepositoryImpl(konselingDataSource);

  final sleepDataSource = SleepRemoteDataSourceImpl(dioClient);
  final sleepRepository = SleepRepositoryImpl(sleepDataSource);

  final symptomDataSource = SymptomRemoteDataSourceImpl(dioClient);
  final symptomRepository = SymptomRepositoryImpl(symptomDataSource);

  runApp(
    MainApp(
      authRepository: authRepository,
      tokenStorage: tokenStorage,
      profileRepository: profileRepository,
      konselingRepository: konselingRepository,
      sleepRepository: sleepRepository,
      symptomRepository: symptomRepository,
    ),
  );
}

class MainApp extends StatelessWidget {
  final AuthRepository authRepository;
  final TokenStorage tokenStorage;
  final ProfileRepository profileRepository;
  final KonselingRepository konselingRepository;
  final SleepRepository sleepRepository;
  final SymptomRepository symptomRepository;

  const MainApp({
    super.key,
    required this.authRepository,
    required this.tokenStorage,
    required this.profileRepository,
    required this.konselingRepository,
    required this.sleepRepository,
    required this.symptomRepository,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) =>
                  AuthCubit(authRepository, tokenStorage)..checkAuthStatus(),
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(profileRepository),
            ),
            BlocProvider<KonselingCubit>(
              create: (context) => KonselingCubit(konselingRepository),
            ),
            BlocProvider<KonselingDetailCubit>(
              create: (context) => KonselingDetailCubit(konselingRepository),
            ),
            BlocProvider<SleepBloc>(
              create: (context) => SleepBloc(sleepRepository),
            ),
            BlocProvider<SymptomBloc>(
              create: (context) => SymptomBloc(symptomRepository),
            ),
            BlocProvider<HomepageBloc>(
              create: (context) => HomepageBloc(
                symptomRepository: symptomRepository,
                sleepRepository: sleepRepository,
                tokenStorage: tokenStorage,
              ),
            ),
          ],
          child: const AppRouter(),
        );
      },
    );
  }
}
