program mas;



uses
  Forms,
  Windows,
  uMain in 'Main Menu\umain.pas' {FrMain},
  Data in 'Data Module\Data.pas' {DataModule1: TDataModule},
  SparePartFunction in 'Tools\functions\SparePartFunction.pas',
  productmaster in 'Product\productmaster.pas' {Frmproductmaster},
  frmProduct in 'Product\frmProduct.pas' {frmProd},
  customermaster in 'Customer\customermaster.pas' {Frmcustomermaster},
  frmCustomer in 'Customer\frmCustomer.pas' {frmCust},
  salesmaster in 'Sales\salesmaster.pas' {Frmsalesmaster},
  frmSalesPerson in 'Sales\frmSalesPerson.pas' {frmSales},
  frmSelling in 'Penjualan\frmSelling.pas' {frmSell},
  retursellmaster in 'Retur Penjualan\retursellmaster.pas' {FrmRtrJualMaster},
  frmReturJual in 'Retur Penjualan\frmReturJual.pas' {frmRtrJual},
  frmDialog in 'Tools\dialog\frmDialog.pas' {frmMessage},
  frmSearchProduct in 'Tools\search product\frmSearchProduct.pas' {frmSrcProd},
  uLogin in 'Admin\User\Login\uLogin.pas' {FLogin},
  UStartup in 'Tools\functions\UStartup.pas',
  userID in 'Admin\User\User ID\userID.pas' {FrmUserID},
  change_password in 'Admin\User\Change Password\change_password.pas' {Frmchangepasswd},
  frmbuying in 'Pembelian\frmbuying.pas' {frmBuy},
  sellmaster in 'Penjualan\sellmaster.pas' {Frmsellmaster},
  buymaster in 'Pembelian\buymaster.pas' {Frmbuymaster},
  suppliermaster in 'Supplier\suppliermaster.pas' {Frmsuppliermaster},
  frmSupplier in 'Supplier\frmSupplier.pas' {frmSupp},
  PgFolderDialog in 'Tools\dialog\PgFolderDialog.pas' {frmFolderDialog},
  frmReturBeli in 'Retur Pembelian\frmReturBeli.pas' {frmRtrBeli},
  returbuymaster in 'Retur Pembelian\returbuymaster.pas' {FrmRtrBeliMaster},
  frmAdjust in 'Adjustment\frmAdjust.pas' {frmAdj},
  piutangmaster in 'Piutang\piutangmaster.pas' {Frmpiutangmaster},
  frmPiutang in 'Piutang\frmPiutang.pas' {frmPtg},
  frmPiutangBG in 'Piutang\frmPiutangBG.pas' {frmPtgbg},
  hutangmaster in 'Hutang\hutangmaster.pas' {Frmhutangmaster},
  operasionalmaster in 'Operasional\operasionalmaster.pas' {Frmoperasionalmaster},
  frmOperasional in 'Operasional\frmOperasional.pas' {frmOpr},
  usergroup in 'Admin\User\User Group\usergroup.pas' {FrmUserGroup},
  pindahgudang in 'Pindah Gudang\pindahgudang.pas' {Frmpindahgudang},
  pindahgudanglist in 'Pindah Gudang\pindahgudanglist.pas' {Frmpindahgudanglist},
  golonganmaster in 'Golongan\golonganmaster.pas' {Frmgolonganmaster},
  Golongan in 'Golongan\Golongan.pas' {frmGolongan},
  stockgudang in 'Inventory\stockgudang.pas' {Frmstockgudanglist},
  promodiskon in 'Promo\promodiskon.pas' {Frmpromodiskon},
  promodiskonlist in 'Promo\promodiskonlist.pas' {Frmpromodiskonlist},
  terimagudang in 'Penerimaan Gudang\terimagudang.pas' {Frmterimagudang},
  terimagudanglist in 'Penerimaan Gudang\terimagudanglist.pas' {Frmterimagudanglist},
  po in 'Purchase Order\po.pas' {Frmpo},
  polist in 'Purchase Order\polist.pas' {Frmpolist},
  ubahharga in 'Ubah Harga\ubahharga.pas' {Frmubahharga},
  ubahhargalist in 'Ubah Harga\ubahhargalist.pas' {Frmubahhargalist},
  frmHutang in 'Hutang\frmHutang.pas' {frmHtg},
  struk in 'Struk\struk.pas' {frmstruk},
  labelharga in 'Tools\label pajangan\labelharga.pas' {frmlabelharga},
  U_Cetak in 'Tools\functions\U_Cetak.pas',
  selltourgroupmaster in 'Tour Group\selltourgroupmaster.pas' {Frmselltourgroupmaster},
  selltourgroup in 'Tour Group\selltourgroup.pas' {frmselltourgroup},
  frmSearchCust in 'Tools\search customer\frmSearchCust.pas' {frmSrcCust},
  Encoder in 'Tools\functions\encoder.pas',
  adjustlist in 'Adjustment\adjustlist.pas' {Frmadjustlist},
  selltourgroupview in 'Tour Group\selltourgroupview.pas' {Frmselltourgroupview},
  useraccessreport in 'Admin\User Access Report\useraccessreport.pas' {FrmUserAccessReport},
  membermaster in 'Member\membermaster.pas' {Frmmembermaster},
  member in 'Member\member.pas' {Frmmember},
  memberabsensi in 'Member\memberabsensi.pas' {frmmemberabsensi},
  memberabsensilist in 'Member\memberabsensilist.pas' {Frmmemberabsensilist},
  memberreward in 'Member\memberreward.pas' {Frmmemberreward},
  memberrewardlist in 'Member\memberrewardlist.pas' {Frmmemberrewardlist};

{$R *.res}

function CanStart: Boolean;
var
  Wdw: HWND;
begin
  Wdw := FindDuplicateMainWdw;
  if Wdw = 0 then
    Result := True
  else
    Result := not SwitchToPrevInst(Wdw);
end;

begin
  if CanStart then
  begin
   Application.Initialize;
   Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrMain, FrMain);
  Application.CreateForm(TFLogin, FLogin);
  Application.CreateForm(TfrmMessage, frmMessage);
  Application.CreateForm(TfrmSrcProd, frmSrcProd);
  Application.CreateForm(TfrmFolderDialog, frmFolderDialog);
  Application.CreateForm(TfrmSrcCust, frmSrcCust);
  Application.Run;
  end;
end.
