unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, RzLabel, frxpngimage, ExtCtrls, ShellApi,
  RzStatus, jpeg;

type
  TFrMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Master1: TMenuItem;
    Item1: TMenuItem;
    Panel1: TPanel;
    RegisterUser1: TMenuItem;
    UbahPassword1: TMenuItem;
    N3: TMenuItem;
    Logout1: TMenuItem;
    mrqstatus: TRzMarqueeStatus;
    N5: TMenuItem;
    Exit1: TMenuItem;
    Tools1: TMenuItem;
    N1: TMenuItem;
    Customer1: TMenuItem;
    Sales1: TMenuItem;
    N4: TMenuItem;
    Supplier1: TMenuItem;
    Transaction1: TMenuItem;
    InputReturPenjualan1: TMenuItem;
    InputPenjualan1: TMenuItem;
    Reports1: TMenuItem;
    DaftarPenjualan1: TMenuItem;
    DaftarReturPenjualan1: TMenuItem;
    DaftarPembelian1: TMenuItem;
    N6: TMenuItem;
    InputPembelian1: TMenuItem;
    InputReturPembelian1: TMenuItem;
    DaftarReturPembelian1: TMenuItem;
    N8: TMenuItem;
    InputStockAdjustment1: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    PembayaranHutang1: TMenuItem;
    Keuangan1: TMenuItem;
    Operasional1: TMenuItem;
    Image1: TImage;
    BackUpData2: TMenuItem;
    Label1: TLabel;
    GroupUser1: TMenuItem;
    InputPindahGudang1: TMenuItem;
    N2: TMenuItem;
    DaftarPindahGudang1: TMenuItem;
    Golongan1: TMenuItem;
    N12: TMenuItem;
    DaftarStok1: TMenuItem;
    N13: TMenuItem;
    InputPromoDiskon1: TMenuItem;
    DaftarPromoDiskon1: TMenuItem;
    InputOrderPembelian1: TMenuItem;
    N14: TMenuItem;
    DaftarOrderPembelian1: TMenuItem;
    N15: TMenuItem;
    InputUbahHarga1: TMenuItem;
    DaftarUbahHarga1: TMenuItem;
    N11: TMenuItem;
    Struk1: TMenuItem;
    PrintHargaPajangan1: TMenuItem;
    InputBiroRombongan1: TMenuItem;
    DaftarAdjustment1: TMenuItem;
    InputBiroRombonganRental1: TMenuItem;
    Viewtourgroupbus1: TMenuItem;
    N7: TMenuItem;
    InputTTKonsinyasi1: TMenuItem;
    N16: TMenuItem;
    UserAccessReport1: TMenuItem;
    N17: TMenuItem;
    Member1: TMenuItem;
    AbsensiMember1: TMenuItem;
    N18: TMenuItem;
    DaftarAbsensiMember1: TMenuItem;
    InputPrintRewardMember1: TMenuItem;
    DaftarPrintRewardMember1: TMenuItem;
    procedure Item1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BackUpData1Click(Sender: TObject);
    procedure RestoreData1Click(Sender: TObject);
    procedure RegisterUser1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure UbahPassword1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Customer1Click(Sender: TObject);
    procedure Sales1Click(Sender: TObject);
    procedure Supplier1Click(Sender: TObject);
    procedure InputPenjualan1Click(Sender: TObject);
    procedure InputReturPenjualan1Click(Sender: TObject);
    procedure DaftarPenjualan1Click(Sender: TObject);
    procedure DaftarReturPenjualan1Click(Sender: TObject);
    procedure DaftarPembelian1Click(Sender: TObject);
    procedure InputPembelian1Click(Sender: TObject);
    procedure InputReturPembelian1Click(Sender: TObject);
    procedure DaftarReturPembelian1Click(Sender: TObject);
    procedure InputStockAdjustment1Click(Sender: TObject);
    procedure PembayaranHutang1Click(Sender: TObject);
    procedure Operasional1Click(Sender: TObject);
    procedure GroupUser1Click(Sender: TObject);
    procedure InputPindahGudang1Click(Sender: TObject);
    procedure DaftarPindahGudang1Click(Sender: TObject);
    procedure Golongan1Click(Sender: TObject);
    procedure DaftarStok1Click(Sender: TObject);
    procedure InputPromoDiskon1Click(Sender: TObject);
    procedure DaftarPromoDiskon1Click(Sender: TObject);
    procedure InputOrderPembelian1Click(Sender: TObject);
    procedure DaftarOrderPembelian1Click(Sender: TObject);
    procedure InputUbahHarga1Click(Sender: TObject);
    procedure DaftarUbahHarga1Click(Sender: TObject);
    procedure Struk1Click(Sender: TObject);
    procedure PrintHargaPajangan1Click(Sender: TObject);
    procedure InputBiroRombongan1Click(Sender: TObject);
    procedure DaftarAdjustment1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure InputBiroRombonganRental1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Viewtourgroupbus1Click(Sender: TObject);
    procedure InputTTKonsinyasi1Click(Sender: TObject);
    procedure UserAccessReport1Click(Sender: TObject);
    procedure Member1Click(Sender: TObject);
    procedure AbsensiMember1Click(Sender: TObject);
    procedure DaftarAbsensiMember1Click(Sender: TObject);
    procedure InputPrintRewardMember1Click(Sender: TObject);
    procedure DaftarPrintRewardMember1Click(Sender: TObject);
  private
    { Private declarations }
    procedure updatemasterkasir;
  public
    { Public declarations }
    procedure TutupMenu;
    procedure display_happy_birthday;
  end;

var
  FrMain: TFrMain;

implementation

uses sparepartfunction, Data, PgFolderDialog, uLogin, productmaster, customermaster, salesmaster, sellmaster, frmSelling, retursellmaster, frmReturJual, buymaster, frmbuying, frmReturBeli, returbuymaster, hutangmaster, operasionalmaster, frmAdjust, userID, usergroup, change_password,
  suppliermaster, pindahgudang, pindahgudanglist, golonganmaster, stockgudang, promodiskon, promodiskonlist, po, polist, ubahharga, ubahhargalist, struk, labelharga, selltourgroupmaster, adjustlist, selltourgroupview, useraccessreport, membermaster, memberabsensi, memberabsensilist, memberreward, memberrewardlist;

{$R *.dfm}

procedure TFrMain.Item1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmproductmaster=nil then
 application.CreateForm(TFrmproductmaster,Frmproductmaster);
 Frmproductmaster.Align:=alclient;
 Frmproductmaster.Parent:=PANEL1;
 Frmproductmaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Master Item');

 Frmproductmaster.FormShowFirst;
 Frmproductmaster.Show;
end;

procedure TFrMain.TutupMenu;
var i : byte;
begin
 for i := 0 to 8 do Master1.Items[i].visible := false;

 for i := 0 to 15 do Transaction1.Items[i].Visible := false;

 Keuangan1.Items[0].Visible := false;

 for i := 0 to 13 do reports1.Items[i].Visible := false;

 Tools1.Items[0].Visible := false;

 for i := 2 to 4 do File1.Items[i].Visible := false;

 File1.Visible         := false;
 Master1.Visible       := false;
 Transaction1.Visible  := false;
 Keuangan1.Visible     := false;
 Reports1.Visible      := false;
 Tools1.Visible        := false;
end;

procedure TFrMain.display_happy_birthday;
begin
 DataModule1.ZQryUtil.Close;
 DataModule1.ZQryUtil.SQL.Text := 'select f_happy_birthday()';
 DataModule1.ZQryUtil.Open;
 mrqstatus.Caption := DataModule1.ZQryUtil.Fields[0].AsString;
 DataModule1.ZQryUtil.Close;
 mrqstatus.Visible := not (mrqstatus.Caption='');
end;

procedure TFrMain.updatemasterkasir;
begin
//
end;

procedure TFrMain.FormShow(Sender: TObject);
begin
{ if (hostname<>'localhost')and(fileexists(vpathsource+'\mas.exe'))and(fileage(vpathsource+'\mas.exe')<>fileage(vpath+'\mas.exe')) then
 begin
  deletefile(vpath+'\mas.hps');
  renamefile(vpath+'\mas.exe',vpath+'\mas.hps');

  copyfile(PAnsiChar(vpathsource+'\mas.exe'),PAnsiChar(vpath+'\mas.exe'),false);

  DelDir(vpath+'\Report');
  copyDir(vpathsource+'\Report',vpath);

  WarningDialog('Ada Update. Aplikasi akan close otomatis. Silakan jalankan Aplikasi lagi!');
  Close;
  exit;
 end;     }


 TglSkrg := getnow;

 HeaderTitleRep := 'UD. MULTI ANUGERAH';
 UserRight := 'Administrator';

 TutupMenu;
 TUTUPFORM(PANEL1);
 FLogin.Showmodal;

 mrqstatus.Caption := namagudang + ' - Login by ' + UserName + ' at ' + formatdatetime('dd/mm/yyyy hh:nn:ss',Tglskrg);

 if isdblocal=false then
  DataModule1.ZConnection1.ExecuteDirect('update product p, ubahhargadet u set p.`hargajual`=u.`hargajualbaru` ' +
  'where p.`IDproduct`=u.`IDproduct` and u.`tglberlaku`=date(now()) and p.`hargajual`<>u.`hargajualbaru`;')
 else updatemasterkasir;
end;

procedure TFrMain.BackUpData1Click(Sender: TObject);
var BackupPath: string;
begin
  ///Backup Database
  if MessageDlg('Backup Data?',mtConfirmation,[mbOk,mbCancel],0) = mrCancel then Exit;

  LogInfo(UserName,'Enter Menu Tools BackUp Data');

  TUTUPFORM(PANEL1);
  IF FrmFolderDialog=nil then application.CreateForm(TFrmFolderDialog,FrmFolderDialog);
  FrmFolderDialog.isbackup := true;
  FrmFolderDialog.lbl_file.Caption := 'Folder';
//  DM.SQLCon.ExecuteDirect('Flush Tables with Read Lock');

  BackupPath := frmFolderDialog.OpenDialog('BACK UP DATA','.sql');
  if BackupPath = '' then
  begin
   ShowMessage('Proses Backup Database Batal!');
   exit;
  end;
  BackupPath := BackupPath+'\mplus ' + FormatDateTime('dd-MM-yyyy hh nn',getNow) + '.sql';

  if ShellExecute(Handle,'open',PChar(vpath + 'MySQLDump.exe'),PChar('-u "metabrain" -p"meta289976" -P 3337 -R -r "' + BackupPath + '" sparepart'),PChar(vpath),SW_HIDE)>32 then
     ShowMessage('Database berhasil dibackup!')
  else ShowMessage('Proses Backup Database gagal!');

//  DM.SQLCon.ExecuteDirect('Unlock Tables');

  LogInfo(UserName,' Melakukan Backup Database');
end;

procedure TFrMain.RestoreData1Click(Sender: TObject);
var BackupPath: string;
begin
  ///Restore Database
  if MessageDlg('Restore Data?',mtConfirmation,[mbOk,mbCancel],0) = mrCancel then Exit;

  LogInfo(UserName,'Enter Menu Tools Restore Data');

  TUTUPFORM(PANEL1);
  IF FrmFolderDialog=nil then application.CreateForm(TFrmFolderDialog,FrmFolderDialog);
  FrmFolderDialog.isbackup := false;
  FrmFolderDialog.lbl_file.Caption := 'File Name';

//  DM.SQLCon.ExecuteDirect('Flush Tables with Read Lock');

  BackupPath := frmFolderDialog.OpenDialog('RESTORE DATA','.sql');
  if BackupPath = '' then
  begin
    Messagedlg('Database tidak dapat direstore!',mterror,[mbOK],0);
//    DM.SQLCon.ExecuteDirect('Unlock Tables');
    Exit;
  end;

  if ShellExecute(Handle,'open',PChar(vpath + 'MySQL.exe'),PChar('-u "metabrain" -p"meta289976" -P 3337 sparepart < "' + BackupPath + '"'),PChar(vpath),SW_HIDE)>32 then
     ShowMessage('Database berhasil di-restore!')
  else ShowMessage('Proses Restore Database gagal!');

//    DM.SQLCon.ExecuteDirect('Unlock Tables');

  LogInfo(UserName,'Melakukan Restore Database');
end;

procedure TFrMain.RegisterUser1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF FrmUserID=nil then
 application.CreateForm(TFrmUserID,FrmUserID);
 FrmUserID.Align:=alclient;
 FrmUserID.Parent:=PANEL1;
 FrmUserID.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Register User');

 FrmUserID.FormShowFirst;
 FrmUserID.Show;
end;

procedure TFrMain.Logout1Click(Sender: TObject);
begin

 TutupMenu;

 TUTUPFORM(PANEL1);

 LogInfo(UserName,'Logout');

 FLogin.Showmodal;
end;

procedure TFrMain.UbahPassword1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmchangepasswd=nil then
 application.CreateForm(TFrmchangepasswd,Frmchangepasswd);
 Frmchangepasswd.Align:=alclient;
 Frmchangepasswd.Parent:=PANEL1;
 Frmchangepasswd.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Ubah Password');

 Frmchangepasswd.FormShowFirst;
 Frmchangepasswd.Show;
end;

procedure TFrMain.Exit1Click(Sender: TObject);
begin
 close;
end;

procedure TFrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 TUTUPFORM(PANEL1);

 LogInfo(UserName,'Exit System');

// if (Datamodule1.ZConnection1.Port=3337)and(questiondialog('Synchronize Data?')) then Datamodule1.exportexternal;
end;

procedure TFrMain.Customer1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmcustomermaster=nil then
 application.CreateForm(TFrmcustomermaster,Frmcustomermaster);
 Frmcustomermaster.Align:=alclient;
 Frmcustomermaster.Parent:=PANEL1;
 Frmcustomermaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Master Customer');

 Frmcustomermaster.FormShowFirst;
 Frmcustomermaster.Show;

end;

procedure TFrMain.Sales1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmsalesmaster=nil then
 application.CreateForm(TFrmsalesmaster,Frmsalesmaster);
 Frmsalesmaster.Align:=alclient;
 Frmsalesmaster.Parent:=PANEL1;
 Frmsalesmaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Master Sales');

 Frmsalesmaster.FormShowFirst;
 Frmsalesmaster.Show;

end;

procedure TFrMain.Supplier1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmsuppliermaster=nil then
 application.CreateForm(TFrmsuppliermaster,Frmsuppliermaster);
 Frmsuppliermaster.Align:=alclient;
 Frmsuppliermaster.Parent:=PANEL1;
 Frmsuppliermaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Master Supplier');

 Frmsuppliermaster.FormShowFirst;
 Frmsuppliermaster.Show;

end;

procedure TFrMain.InputPenjualan1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF frmSell=nil then
 application.CreateForm(TfrmSell,frmSell);
 frmSell.Align:=alclient;
 frmSell.Parent:=PANEL1;
 frmSell.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Input Penjualan');

 frmSell.Show;
 frmSell.FormShowFirst;
end;

procedure TFrMain.InputReturPenjualan1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF frmRtrJual=nil then
 application.CreateForm(TfrmRtrJual,frmRtrJual);
 frmRtrJual.Align:=alclient;
 frmRtrJual.Parent:=PANEL1;
 frmRtrJual.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Input Retur Penjualan');

 frmRtrJual.Show;

end;

procedure TFrMain.DaftarPenjualan1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmsellmaster=nil then
 application.CreateForm(TFrmsellmaster,Frmsellmaster);
 Frmsellmaster.Align:=alclient;
 Frmsellmaster.Parent:=PANEL1;
 Frmsellmaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Penjualan');

 Frmsellmaster.FormShowFirst;
 Frmsellmaster.Show;

end;

procedure TFrMain.DaftarReturPenjualan1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF FrmRtrJualmaster=nil then
 application.CreateForm(TFrmRtrJualmaster,FrmRtrJualmaster);
 FrmRtrJualmaster.Align:=alclient;
 FrmRtrJualmaster.Parent:=PANEL1;
 FrmRtrJualmaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Retur Penjualan');

 FrmRtrJualmaster.FormShowFirst;
 FrmRtrJualmaster.Show;

end;

procedure TFrMain.DaftarPembelian1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmbuymaster=nil then
 application.CreateForm(TFrmbuymaster,Frmbuymaster);
 Frmbuymaster.Align:=alclient;
 Frmbuymaster.Parent:=PANEL1;
 Frmbuymaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Pembelian');

 Frmbuymaster.FormShowFirst;
 Frmbuymaster.Show;

end;

procedure TFrMain.InputPembelian1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF frmBuy=nil then
 application.CreateForm(TfrmBuy,frmBuy);
 frmBuy.Align:=alclient;
 frmBuy.Parent:=PANEL1;
 frmBuy.BorderStyle:=bsnone;
 frmBuy.SellLblCaption.Caption := 'Input Pembelian';

 LogInfo(UserName,'Enter Menu Input Pembelian');

 Frmbuy.FormShowFirst;
 frmBuy.Show;

end;

procedure TFrMain.InputReturPembelian1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF frmRtrBeli=nil then
 application.CreateForm(TfrmRtrBeli,frmRtrBeli);
 frmRtrBeli.Align:=alclient;
 frmRtrBeli.Parent:=PANEL1;
 frmRtrBeli.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Input Retur Pembelian');

 frmRtrBeli.Show;

end;

procedure TFrMain.DaftarReturPembelian1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF FrmRtrBeliMaster=nil then
 application.CreateForm(TFrmRtrBeliMaster,FrmRtrBeliMaster);
 FrmRtrBeliMaster.Align:=alclient;
 FrmRtrBeliMaster.Parent:=PANEL1;
 FrmRtrBeliMaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Retur Pembelian');

 FrmRtrBeliMaster.FormShowFirst;
 FrmRtrBeliMaster.Show;

end;

procedure TFrMain.InputStockAdjustment1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF frmadj=nil then
 application.CreateForm(Tfrmadj,frmadj);
 frmadj.Align:=alclient;
 frmadj.Parent:=PANEL1;
 frmadj.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Input Stock Adjustment');

 frmadj.Show;
end;

procedure TFrMain.PembayaranHutang1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF frmhutangmaster=nil then
 application.CreateForm(Tfrmhutangmaster,frmhutangmaster);
 frmhutangmaster.Align:=alclient;
 frmhutangmaster.Parent:=PANEL1;
 frmhutangmaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Pembayaran Hutang');

 frmhutangmaster.FormShowFirst;
 frmhutangmaster.Show;
end;

procedure TFrMain.Operasional1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF frmoperasionalmaster=nil then
 application.CreateForm(Tfrmoperasionalmaster,frmoperasionalmaster);
 frmoperasionalmaster.Align:=alclient;
 frmoperasionalmaster.Parent:=PANEL1;
 frmoperasionalmaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Keuangan Operasional');

 frmoperasionalmaster.FormShowFirst;
 frmoperasionalmaster.Show;
end;

procedure TFrMain.GroupUser1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF FrmUserGroup=nil then
 application.CreateForm(TFrmUserGroup,FrmUserGroup);
 FrmUserGroup.Align:=alclient;
 FrmUserGroup.Parent:=PANEL1;
 FrmUserGroup.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu User Group');

 FrmUserGroup.FormShowFirst;
 FrmUserGroup.Show;

end;

procedure TFrMain.InputPindahGudang1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF FrmPindahGudang=nil then
 application.CreateForm(TFrmPindahGudang,FrmPindahGudang);
 FrmPindahGudang.Align:=alclient;
 FrmPindahGudang.Parent:=PANEL1;
 FrmPindahGudang.BorderStyle:=bsnone;
 FrmPindahGudang.tagacc := ADD_ACCESS;

 LogInfo(UserName,'Enter Menu Input Pindah Gudang');

 FrmPindahGudang.Show;

end;

procedure TFrMain.DaftarPindahGudang1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF FrmPindahGudanglist=nil then
 application.CreateForm(TFrmPindahGudanglist,FrmPindahGudanglist);
 FrmPindahGudanglist.Align:=alclient;
 FrmPindahGudanglist.Parent:=PANEL1;
 FrmPindahGudanglist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Pindah Gudang');

 FrmPindahGudanglist.FormShowFirst;
 FrmPindahGudanglist.Show;

end;

{procedure TFrMain.LoadDataFromGudangPusat1Click(Sender: TObject);
var vnmfile : string;
begin
 if OpenDialog1.Execute then
 begin
  vnmfile :=  stringreplace(OpenDialog1.FileName,'\','/',[rfReplaceAll,rfIgnorecase]);
  if Datamodule1.ZConnection1.ExecuteDirect('LOAD DATA INFILE "'+vnmfile+'" INTO TABLE inventoryimp;') then
  infodialog('Proses Loading Data From Gudang Pusat selesai.');
 end;
end;  }

procedure TFrMain.Golongan1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmgolonganmaster=nil then
 application.CreateForm(TFrmgolonganmaster,Frmgolonganmaster);
 Frmgolonganmaster.Align:=alclient;
 Frmgolonganmaster.Parent:=PANEL1;
 Frmgolonganmaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Master Golongan');

 Frmgolonganmaster.FormShowFirst;
 Frmgolonganmaster.Show;
end;

procedure TFrMain.DaftarStok1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmstockgudanglist=nil then
 application.CreateForm(TFrmstockgudanglist,Frmstockgudanglist);
 Frmstockgudanglist.Align:=alclient;
 Frmstockgudanglist.Parent:=PANEL1;
 Frmstockgudanglist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Stock');

 Frmstockgudanglist.FormShowFirst;
 Frmstockgudanglist.Show;

end;

procedure TFrMain.InputPromoDiskon1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmpromodiskon=nil then
 application.CreateForm(TFrmpromodiskon,Frmpromodiskon);
 Frmpromodiskon.Align:=alclient;
 Frmpromodiskon.Parent:=PANEL1;
 Frmpromodiskon.BorderStyle:=bsnone;
 Frmpromodiskon.tagacc := ADD_ACCESS;

 LogInfo(UserName,'Enter Input Promo Diskon');

 Frmpromodiskon.Show;
end;

procedure TFrMain.DaftarPromoDiskon1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmpromodiskonlist=nil then
 application.CreateForm(TFrmpromodiskonlist,Frmpromodiskonlist);
 Frmpromodiskonlist.Align:=alclient;
 Frmpromodiskonlist.Parent:=PANEL1;
 Frmpromodiskonlist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Daftar Promo Diskon');

 Frmpromodiskonlist.FormShowFirst;
 Frmpromodiskonlist.Show;

end;

procedure TFrMain.InputOrderPembelian1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmpo=nil then
 application.CreateForm(TFrmpo,Frmpo);
 Frmpo.Align:=alclient;
 Frmpo.Parent:=PANEL1;
 Frmpo.BorderStyle:=bsnone;
 Frmpo.tagacc := ADD_ACCESS;

 LogInfo(UserName,'Enter Menu Input Order Pembelian');

 Frmpo.Show;

end;

procedure TFrMain.DaftarOrderPembelian1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmpolist=nil then
 application.CreateForm(TFrmpolist,Frmpolist);
 Frmpolist.Align:=alclient;
 Frmpolist.Parent:=PANEL1;
 Frmpolist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Order Pembelian');

 Frmpolist.FormShowFirst;
 Frmpolist.Show;

end;

procedure TFrMain.InputUbahHarga1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmubahharga=nil then
 application.CreateForm(TFrmubahharga,Frmubahharga);
 Frmubahharga.Align:=alclient;
 Frmubahharga.Parent:=PANEL1;
 Frmubahharga.BorderStyle:=bsnone;
 Frmubahharga.tagacc := ADD_ACCESS;

 LogInfo(UserName,'Enter Menu Input Ubah Harga');

 Frmubahharga.Show;
end;

procedure TFrMain.DaftarUbahHarga1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmubahhargalist=nil then
 application.CreateForm(TFrmubahhargalist,Frmubahhargalist);
 Frmubahhargalist.Align:=alclient;
 Frmubahhargalist.Parent:=PANEL1;
 Frmubahhargalist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Ubah Harga');

 Frmubahhargalist.FormShowFirst;
 Frmubahhargalist.Show;

end;

procedure TFrMain.Struk1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmstruk=nil then
 application.CreateForm(TFrmstruk,Frmstruk);
 Frmstruk.Align:=alclient;
 Frmstruk.Parent:=PANEL1;
 Frmstruk.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Master Setting Struk');

 Frmstruk.Show;

end;

procedure TFrMain.PrintHargaPajangan1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmlabelharga=nil then
 application.CreateForm(TFrmlabelharga,Frmlabelharga);
 Frmlabelharga.Align:=alclient;
 Frmlabelharga.Parent:=PANEL1;
 Frmlabelharga.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Label Harga');

 Frmlabelharga.Show;
end;

procedure TFrMain.InputBiroRombongan1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmselltourgroupmaster=nil then
 application.CreateForm(TFrmselltourgroupmaster,Frmselltourgroupmaster);
 Frmselltourgroupmaster.Align:=alclient;
 Frmselltourgroupmaster.Parent:=PANEL1;
 Frmselltourgroupmaster.BorderStyle:=bsnone;
 Frmselltourgroupmaster.isbusrental := false;

 LogInfo(UserName,'Enter Menu Input Biro/Rombongan');

 Frmselltourgroupmaster.FormShowFirst;
 Frmselltourgroupmaster.Show;

end;

procedure TFrMain.DaftarAdjustment1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmadjustlist=nil then
 application.CreateForm(TFrmadjustlist,Frmadjustlist);
 Frmadjustlist.Align:=alclient;
 Frmadjustlist.Parent:=PANEL1;
 Frmadjustlist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Adjustment');

 Frmadjustlist.FormShowFirst;
 Frmadjustlist.Show;

end;

procedure TFrMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if frmsell<>nil then frmsell.OnKeyPress(Sender,Key);
end;

procedure TFrMain.InputBiroRombonganRental1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmselltourgroupmaster=nil then
 application.CreateForm(TFrmselltourgroupmaster,Frmselltourgroupmaster);
 Frmselltourgroupmaster.Align:=alclient;
 Frmselltourgroupmaster.Parent:=PANEL1;
 Frmselltourgroupmaster.BorderStyle:=bsnone;
 Frmselltourgroupmaster.isbusrental := true;

 LogInfo(UserName,'Enter Menu Input Biro/Rombongan Rental');

 Frmselltourgroupmaster.FormShowFirst;
 Frmselltourgroupmaster.Show;

end;

procedure TFrMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if frmsell<>nil then frmsell.OnKeyDown(Sender,Key,Shift);
end;

procedure TFrMain.Viewtourgroupbus1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmselltourgroupview=nil then
 application.CreateForm(TFrmselltourgroupview,Frmselltourgroupview);
 Frmselltourgroupview.Align:=alclient;
 Frmselltourgroupview.Parent:=PANEL1;
 Frmselltourgroupview.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu View Tour Group Bus');

 Frmselltourgroupview.FormShowFirst;
 Frmselltourgroupview.Show;

end;

procedure TFrMain.InputTTKonsinyasi1Click(Sender: TObject);
begin
{ TUTUPFORM(PANEL1);
 IF frmttkonsi=nil then
 application.CreateForm(Tfrmttkonsi,frmttkonsi);
 frmttkonsi.Align:=alclient;
 frmttkonsi.Parent:=PANEL1;
 frmttkonsi.BorderStyle:=bsnone;
 frmttkonsi.SellLblCaption.Caption := 'Input TT Konsinyasi';

 LogInfo(UserName,'Enter Menu Input TT Konsinyasi');

 frmttkonsi.FormShowFirst;
 frmttkonsi.Show;
 }
end;

procedure TFrMain.UserAccessReport1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF FrmUserAccessReport=nil then
 application.CreateForm(TFrmUserAccessReport,FrmUserAccessReport);
 FrmUserAccessReport.Align:=alclient;
 FrmUserAccessReport.Parent:=PANEL1;
 FrmUserAccessReport.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports User Access Report');

 FrmUserAccessReport.FormShowFirst;
 FrmUserAccessReport.Show;
end;

procedure TFrMain.Member1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmmembermaster=nil then
 application.CreateForm(TFrmmembermaster,Frmmembermaster);
 Frmmembermaster.Align:=alclient;
 Frmmembermaster.Parent:=PANEL1;
 Frmmembermaster.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Input Member');

 Frmmembermaster.FormShowFirst;
 Frmmembermaster.Show;
end;

procedure TFrMain.AbsensiMember1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmmemberabsensi=nil then
 application.CreateForm(TFrmmemberabsensi,Frmmemberabsensi);
 Frmmemberabsensi.Align:=alclient;
 Frmmemberabsensi.Parent:=PANEL1;
 Frmmemberabsensi.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Input Absensi Member');

 Frmmemberabsensi.Show;

end;

procedure TFrMain.DaftarAbsensiMember1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmmemberabsensilist=nil then
 application.CreateForm(TFrmmemberabsensilist,Frmmemberabsensilist);
 Frmmemberabsensilist.Align:=alclient;
 Frmmemberabsensilist.Parent:=PANEL1;
 Frmmemberabsensilist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Absensi Member');

 Frmmemberabsensilist.FormShowFirst;
 Frmmemberabsensilist.Show;

end;

procedure TFrMain.InputPrintRewardMember1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmmemberreward=nil then
 application.CreateForm(TFrmmemberreward,Frmmemberreward);
 Frmmemberreward.Align:=alclient;
 Frmmemberreward.Parent:=PANEL1;
 Frmmemberreward.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Input Print Reward Member');

 Frmmemberreward.Show;
end;

procedure TFrMain.DaftarPrintRewardMember1Click(Sender: TObject);
begin
 TUTUPFORM(PANEL1);
 IF Frmmemberrewardlist=nil then
 application.CreateForm(TFrmmemberrewardlist,Frmmemberrewardlist);
 Frmmemberrewardlist.Align:=alclient;
 Frmmemberrewardlist.Parent:=PANEL1;
 Frmmemberrewardlist.BorderStyle:=bsnone;

 LogInfo(UserName,'Enter Menu Reports Daftar Print Reward Member');

 Frmmemberrewardlist.FormShowFirst;
 Frmmemberrewardlist.Show;

end;

end.
