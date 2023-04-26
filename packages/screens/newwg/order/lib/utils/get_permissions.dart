import 'permission_impl/stub.dart'
if (dart.library.io) 'permission_impl/mobile.dart'
if (dart.library.html) 'permission_impl/web.dart';

class GetPermission {
  final PermissionManagerImpl _permissionManagerImpl;

  GetPermission() : _permissionManagerImpl = PermissionManagerImpl();

  Future<bool> status() async {
    return await _permissionManagerImpl.status();
  }
}