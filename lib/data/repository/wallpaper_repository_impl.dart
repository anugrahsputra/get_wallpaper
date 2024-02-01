import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class WallpaperRepositoryImpl implements WallpaperRepository {
  final ApiService apiService;

  WallpaperRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<Wallpaper>>> categorizedWallpaper(
      String category, int page) async {
    try {
      final result = await apiService.categorizedWallpaper(category, page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Wallpaper>> detailWallpaper(int id) async {
    try {
      final result = await apiService.detailWallpaper(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Wallpaper>>> listWallpaper(int page) async {
    try {
      final result = await apiService.listWallpaper(page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Wallpaper>>> searchWallpaper(
      String query, int page) async {
    try {
      final result = await apiService.searchWallpaper(query, page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Wallpaper>>> searchWallpaperLoad(
      String query, int page) async {
    try {
      final result = await apiService.searchWallpaper(query, page);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Server Failure'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
