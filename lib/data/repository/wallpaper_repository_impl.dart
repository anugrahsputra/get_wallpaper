import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class WallpaperRepositoryImpl implements WallpaperRepository {
  final WallpaperRemoteDataSource apiService;

  WallpaperRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<Wallpaper>>> categorizedWallpaper(
      String category, int page) async {
    try {
      final result = await apiService.categorizedWallpaper(category, page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        return const Left(AuthFailure(message: ErrorMessage.authFailure));
      } else if (e.error is ServerException) {
        return const Left(ServerFailure(message: ErrorMessage.serverFailure));
      } else if (e.error is NetworkException) {
        return const Left(NetworkFailure(message: ErrorMessage.networkFailure));
      } else if (e.error is NotFoundException) {
        return const Left(RequestFailure(message: ErrorMessage.requestFailure));
      } else {
        return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
      }
    } catch (e) {
      return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
    }
  }

  @override
  Future<Either<Failure, Wallpaper>> detailWallpaper(int id) async {
    try {
      final result = await apiService.detailWallpaper(id);
      return Right(result.toEntity());
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        return const Left(AuthFailure(message: ErrorMessage.authFailure));
      } else if (e.error is ServerException) {
        return const Left(ServerFailure(message: ErrorMessage.serverFailure));
      } else if (e.error is NetworkException) {
        return const Left(NetworkFailure(message: ErrorMessage.networkFailure));
      } else if (e.error is NotFoundException) {
        return const Left(RequestFailure(message: ErrorMessage.requestFailure));
      } else {
        return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
      }
    } catch (e) {
      return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
    }
  }

  @override
  Future<Either<Failure, List<Wallpaper>>> listWallpaper(int page) async {
    try {
      final result = await apiService.listWallpaper(page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        return const Left(AuthFailure(message: ErrorMessage.authFailure));
      } else if (e.error is ServerException) {
        return const Left(ServerFailure(message: ErrorMessage.serverFailure));
      } else if (e.error is NetworkException) {
        return const Left(NetworkFailure(message: ErrorMessage.networkFailure));
      } else if (e.error is NotFoundException) {
        return const Left(RequestFailure(message: ErrorMessage.requestFailure));
      } else {
        return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
      }
    } catch (e) {
      return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
    }
  }

  @override
  Future<Either<Failure, List<Wallpaper>>> searchWallpaper(
      String query, int page) async {
    try {
      final result = await apiService.searchWallpaper(query, page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        return const Left(AuthFailure(message: ErrorMessage.authFailure));
      } else if (e.error is ServerException) {
        return const Left(ServerFailure(message: ErrorMessage.serverFailure));
      } else if (e.error is NetworkException) {
        return const Left(NetworkFailure(message: ErrorMessage.networkFailure));
      } else if (e.error is NotFoundException) {
        return const Left(RequestFailure(message: ErrorMessage.requestFailure));
      } else {
        return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
      }
    } catch (e) {
      return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
    }
  }

  @override
  Future<Either<Failure, List<Wallpaper>>> searchWallpaperLoad(
      String query, int page) async {
    try {
      final result = await apiService.searchWallpaper(query, page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        return const Left(AuthFailure(message: ErrorMessage.authFailure));
      } else if (e.error is ServerException) {
        return const Left(ServerFailure(message: ErrorMessage.serverFailure));
      } else if (e.error is NetworkException) {
        return const Left(NetworkFailure(message: ErrorMessage.networkFailure));
      } else if (e.error is NotFoundException) {
        return const Left(RequestFailure(message: ErrorMessage.requestFailure));
      } else {
        return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
      }
    } catch (e) {
      return const Left(UnknownFailure(message: ErrorMessage.unknownFailure));
    }
  }
}
