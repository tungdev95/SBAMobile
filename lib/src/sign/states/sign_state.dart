// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:sba/src/models/assets/assets.dart';

class SignState<T extends BaseDetailModel> extends Equatable {
  AssetsModel? assetsModel;
  Uint8List? chuKyChuyenVien;
  Uint8List? chuKyKhachHang;
  AttachmentFile? attachment;
  List<AssetsDetailModel<T>>? assets;
  List<dynamic>? data;
  SignState({
    required this.assetsModel,
    this.chuKyChuyenVien,
    this.chuKyKhachHang,
    this.attachment,
    this.assets,
    this.data,
  });

  SignState<T> copyWith({
    AssetsModel? assetsModel,
    Uint8List? chuKyChuyenVien,
    Uint8List? chuKyKhachHang,
    AttachmentFile? attachment,
    List<AssetsDetailModel<T>>? assets,
    List<dynamic>? data,
  }) {
    return SignState<T>(
      assetsModel: assetsModel ?? this.assetsModel,
      chuKyChuyenVien: chuKyChuyenVien ?? this.chuKyChuyenVien,
      chuKyKhachHang: chuKyKhachHang ?? this.chuKyKhachHang,
      attachment: attachment ?? this.attachment,
      assets: assets ?? this.assets,
      data: data ?? this.data,
    );
  }

  SignState<T> deleteCustomerSign() {
    return SignState<T>(
      assetsModel: assetsModel,
      chuKyChuyenVien: chuKyChuyenVien,
      chuKyKhachHang: null,
      attachment: attachment,
      data: data,
    );
  }

  SignState<T> deleteStaffSign() {
    return SignState(
      assetsModel: assetsModel,
      chuKyChuyenVien: null,
      chuKyKhachHang: chuKyKhachHang,
      attachment: attachment,
      data: data,
    );
  }

  @override
  List<Object?> get props => [chuKyChuyenVien, chuKyKhachHang];
}
