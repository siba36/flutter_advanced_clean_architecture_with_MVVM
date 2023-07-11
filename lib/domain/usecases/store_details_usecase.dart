import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/Failure.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async {
    return await repository.getStoreDetails();
  }
}
