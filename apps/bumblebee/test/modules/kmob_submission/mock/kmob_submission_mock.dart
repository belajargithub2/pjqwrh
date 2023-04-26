import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_asset_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_consumen_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_local_repository.dart';
import 'package:mockito/mockito.dart';

class KMOBSubmissionRepositoryMock extends Mock implements BumblebeeKMOBSubmissionRepository {}

class DraftRepositoryMock extends Mock implements BumblebeeDraftRepository {}

class KMOBSubmissionControllerMock extends Mock implements BumblebeeKMOBSubmissionController {}

class LocalRepositoryMock extends Mock implements BumblebeeLocalRepository {}

class KMOBConsumerDataSubmissionControllerMock extends Mock implements BumblebeeKMOBConsumerDataSubmissionController {}

class KMOBAssetDataSubmissionControllerMock extends Mock implements BumblebeeKMOBAssetDataSubmissionController {}

class KMOBUploadDocumentSubmissionControllerMock extends Mock implements BumblebeeKMOBUploadDocumentSubmissionController {}