import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/store_details/view_model/store_details_view_model.dart';

import '../../../app/dependency_injection.dart';
import '../../../domain/model/models.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.storeDetails,
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) =>
                snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                _getContentWidget(),
          ),
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<StoreDetails>(
      stream: _viewModel.outputStoreDetails,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12, vertical: AppPadding.p12),
          child: Column(
            children: [
              _getMainPhoto(snapshot.data?.image),
              _getSection(AppStrings.details, snapshot.data?.details),
              _getSection(AppStrings.services, snapshot.data?.services),
              _getSection(AppStrings.about, snapshot.data?.about),
            ],
          ),
        );
      },
    );
  }

  Widget _getSection(String title, String? content) {
    return content != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getSectionTitle(title),
              _getParagraphWidget(content),
            ],
          )
        : Container();
  }

  Widget _getMainPhoto(String? photoPath) {
    return Padding(
      padding:
          const EdgeInsets.only(top: AppPadding.p10, bottom: AppPadding.p20),
      child: SizedBox(
        height: AppSize.s190,
        width: double.infinity,
        child: photoPath != null
            ? Image.network(
                photoPath,
                fit: BoxFit.cover,
              )
            : Image.asset(
                ImageAssets.emptyImage,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _getSectionTitle(String sectionName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: Text(
        sectionName,
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget _getParagraphWidget(String paragraph) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: AppPadding.p20, top: AppPadding.p10),
      child: Text(
        paragraph,
        softWrap: true,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
