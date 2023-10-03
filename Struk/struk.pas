unit struk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, RzLabel, ExtDlgs, JPEG;

type
  Tfrmstruk = class(TForm)
    Panel: TRzPanel;
    RzPanel2: TRzPanel;
    LblCaption: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel12: TRzLabel;
    RzLabel14: TRzLabel;
    BtnAdd: TAdvSmoothButton;
    Btncancel: TAdvSmoothButton;
    RzLabel2: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    edt_alamat: TRzEdit;
    edt_company: TRzEdit;
    edt_kota: TRzEdit;
    RzLabel1: TRzLabel;
    edt_cabang: TRzEdit;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel7: TRzLabel;
    edt_footer2: TRzEdit;
    edt_footer1: TRzEdit;
    edt_footer3: TRzEdit;
    RzLabel8: TRzLabel;
    edt_footer4: TRzEdit;
    RzLabel9: TRzLabel;
    edt_footer5: TRzEdit;
    Panel1: TPanel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel13: TRzLabel;
    edt_endfooter1: TRzEdit;
    edt_endfooter2: TRzEdit;
    edt_endfooter3: TRzEdit;
    RzLabel15: TRzLabel;
    edt_mintrans: TRzNumericEdit;
    RzLabel16: TRzLabel;
    edt_phone: TRzEdit;
    Panel2: TPanel;
    RzLabel20: TRzLabel;
    edtnum_presentfeebusrental: TRzNumericEdit;
    RzLabel17: TRzLabel;
    edtnum_presentfeebusbesar: TRzNumericEdit;
    RzLabel18: TRzLabel;
    edtnum_presentfeebuskecil: TRzNumericEdit;
    lbl_mt: TRzLabel;
    edtnum_mt: TRzNumericEdit;
    RzLabel19: TRzLabel;
    edtnum_rewardmember: TRzNumericEdit;
    RzLabel21: TRzLabel;
    edtnum_rewardcair: TRzNumericEdit;
    RzLabel22: TRzLabel;
    procedure BtnAddClick(Sender: TObject);
    procedure BtncancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmstruk: Tfrmstruk;

implementation

uses SparePartFunction, Data;

{$R *.dfm}

procedure Tfrmstruk.BtnAddClick(Sender: TObject);
begin
  if trim(edt_company.Text)='' then
  begin
   errordialog('Perusahaan wajib diisi !');
   exit;
  end;

  if trim(edt_alamat.Text)='' then
  begin
   errordialog('Alamat wajib diisi !');
   exit;
  end;

  if trim(edt_kota.Text)='' then
  begin
   errordialog('Kota wajib diisi !');
   exit;
  end;

  if trim(edt_phone.Text)='' then
  begin
   errordialog('Phone wajib diisi !');
   exit;
  end;

  if trim(edt_cabang.Text)='' then
  begin
   errordialog('Cabang wajib diisi !');
   exit;
  end;

  if (edt_mintrans.Value<=0)and(trim(edt_endfooter1.Text)<>'') then
  begin
   errordialog('Minimal transaksi belum diisi !');
   exit;
  end;

  if (edt_mintrans.Value>0)and(trim(edt_endfooter1.Text)='') then
  begin
   errordialog('End Footer Baris 1 belum diisi!');
   exit;
  end;

  if (edtnum_rewardmember.Value<=0) then
  begin
   errordialog('Reward Member harus lebih besar dari 0!');
   exit;
  end;

  if (edtnum_rewardcair.Value<=0) then
  begin
   errordialog('Reward Cair harus lebih besar dari 0!');
   exit;
  end;

  if QuestionDialog('Simpan setting Struk ini?') = False then Exit;

  if Datamodule1.ZConnection1.ExecuteDirect('update struk set '+
  'company='+Quotedstr(trim(edt_company.Text))+
  ',alamat='+Quotedstr(trim(edt_alamat.Text))+
  ',kota='+Quotedstr(trim(edt_kota.Text))+
  ',phone='+Quotedstr(trim(edt_phone.Text))+
  ',cabang='+Quotedstr(trim(edt_cabang.Text))+
  ',footer1='+Quotedstr(trim(edt_footer1.Text))+
  ',footer2='+Quotedstr(trim(edt_footer2.Text))+
  ',footer3='+Quotedstr(trim(edt_footer3.Text))+
  ',footer4='+Quotedstr(trim(edt_footer4.Text))+
  ',footer5='+Quotedstr(trim(edt_footer5.Text))+
  ',mintrans='+Quotedstr(floattostr(edt_mintrans.Value))+
  ',endfooter1='+Quotedstr(trim(edt_endfooter1.Text))+
  ',endfooter2='+Quotedstr(trim(edt_endfooter2.Text))+
  ',endfooter3='+Quotedstr(trim(edt_endfooter3.Text))+
  ',presentfeebusbesar='+Quotedstr(Number2MySQL(edtnum_presentfeebusbesar.value))+
  ',presentfeebuskecil='+Quotedstr(Number2MySQL(edtnum_presentfeebuskecil.value))+
  ',presentfeebusrental='+Quotedstr(Number2MySQL(edtnum_presentfeebusrental.value))+
  ',mt='+Quotedstr(floattostr(edtnum_mt.Value))+
  ',rewardmember='+Quotedstr(floattostr(edtnum_rewardmember.Value))+
  ',rewardcair='+Quotedstr(floattostr(edtnum_rewardcair.Value))+
  ' where isaktif=1') then

 { if (DataModule1.ZConnection1.Catalog='sparepart') then
     Datamodule1.ZConn2.ExecuteDirect('update struk set '+
      'company='+Quotedstr(trim(edt_company.Text))+
      ',alamat='+Quotedstr(trim(edt_alamat.Text))+
      ',kota='+Quotedstr(trim(edt_kota.Text))+
      ',phone='+Quotedstr(trim(edt_phone.Text))+
      ',cabang='+Quotedstr(trim(edt_cabang.Text))+
      ',footer1='+Quotedstr(trim(edt_footer1.Text))+
      ',footer2='+Quotedstr(trim(edt_footer2.Text))+
      ',footer3='+Quotedstr(trim(edt_footer3.Text))+
      ',footer4='+Quotedstr(trim(edt_footer4.Text))+
      ',footer5='+Quotedstr(trim(edt_footer5.Text))+
      ',mintrans='+Quotedstr(floattostr(edt_mintrans.Value))+
      ',endfooter1='+Quotedstr(trim(edt_endfooter1.Text))+
      ',endfooter2='+Quotedstr(trim(edt_endfooter2.Text))+
      ',endfooter3='+Quotedstr(trim(edt_endfooter3.Text))+
      ',presentfeebusbesar='+Quotedstr(Number2MySQL(edtnum_presentfeebusbesar.value))+
      ',presentfeebuskecil='+Quotedstr(Number2MySQL(edtnum_presentfeebuskecil.value))+
      ',presentfeebusrental='+Quotedstr(Number2MySQL(edtnum_presentfeebusrental.value))+
      ' where isaktif=1');     }


  begin
   rewardmember := edtnum_rewardmember.value;
   rewardcair   := edtnum_rewardcair.intvalue;

   InfoDialog('Setting Struk berhasil!');
   LogInfo(UserName,'Setting Struk '+trim(edt_cabang.Text));
   Close;
  end
  else errorDialog('Setting Struk gagal, coba periksa input datanya!');

end;

procedure Tfrmstruk.BtncancelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmstruk.FormShow(Sender: TObject);
begin
  Panel.Color := $0092C9C9;
  edtnum_mt.Visible := true;
  lbl_mt.Visible := true;

  if (DataModule1.ZConnection1.Catalog='sparepart52') then
  begin
      Panel.Color := $00808040;
      edtnum_mt.Visible := false;
      lbl_mt.Visible := false;
  end;

 Datamodule1.ZQrystruk.Close;
 Datamodule1.ZQrystruk.Open;

 edt_company.Text := '';
 edt_alamat.Text := '';
 edt_kota.Text := '';
 edt_cabang.Text := '';
 edt_phone.Text := '';

 edt_footer1.Text := '';
 edt_footer2.Text := '';
 edt_footer3.Text := '';
 edt_footer4.Text := '';
 edt_footer5.Text := '';

 edt_mintrans.Value := 0;

 edt_endfooter1.Text := '';
 edt_endfooter2.Text := '';
 edt_endfooter3.Text := '';

 edtnum_presentfeebusbesar.Value := 0;
 edtnum_presentfeebuskecil.Value := 0;
 edtnum_presentfeebusrental.Value := 0;

 edtnum_mt.Value := 0;
 edtnum_rewardmember.Value := 0;
 edtnum_rewardcair.Value   := 0;

 if Datamodule1.ZQrystrukcompany.IsNull=false then edt_company.Text := Datamodule1.ZQrystrukcompany.AsString;
 if Datamodule1.ZQrystrukalamat.IsNull=false then edt_alamat.Text := Datamodule1.ZQrystrukalamat.AsString;
 if Datamodule1.ZQrystrukkota.IsNull=false then edt_kota.Text := Datamodule1.ZQrystrukkota.AsString;
 if Datamodule1.ZQrystrukcabang.IsNull=false then edt_cabang.Text := Datamodule1.ZQrystrukcabang.AsString;
 if Datamodule1.ZQrystrukphone.IsNull=false then edt_phone.Text := Datamodule1.ZQrystrukphone.AsString;

 if Datamodule1.ZQrystrukfooter1.IsNull=false then edt_footer1.Text := Datamodule1.ZQrystrukfooter1.AsString;
 if Datamodule1.ZQrystrukfooter2.IsNull=false then edt_footer2.Text := Datamodule1.ZQrystrukfooter2.AsString;
 if Datamodule1.ZQrystrukfooter3.IsNull=false then edt_footer3.Text := Datamodule1.ZQrystrukfooter3.AsString;
 if Datamodule1.ZQrystrukfooter4.IsNull=false then edt_footer4.Text := Datamodule1.ZQrystrukfooter4.AsString;
 if Datamodule1.ZQrystrukfooter5.IsNull=false then edt_footer5.Text := Datamodule1.ZQrystrukfooter5.AsString;

 if Datamodule1.ZQrystrukmintrans.IsNull=false then edt_mintrans.Value := Datamodule1.ZQrystrukmintrans.Value;

 if Datamodule1.ZQrystrukendfooter1.IsNull=false then edt_endfooter1.Text := Datamodule1.ZQrystrukendfooter1.AsString;
 if Datamodule1.ZQrystrukendfooter2.IsNull=false then edt_endfooter2.Text := Datamodule1.ZQrystrukendfooter2.AsString;
 if Datamodule1.ZQrystrukendfooter3.IsNull=false then edt_endfooter3.Text := Datamodule1.ZQrystrukendfooter3.AsString;

 if Datamodule1.ZQrystrukpresentfeebusbesar.IsNull=false then edtnum_presentfeebusbesar.Value := Datamodule1.ZQrystrukpresentfeebusbesar.Value;
 if Datamodule1.ZQrystrukpresentfeebuskecil.IsNull=false then edtnum_presentfeebuskecil.Value := Datamodule1.ZQrystrukpresentfeebuskecil.Value;
 if Datamodule1.ZQrystrukpresentfeebusrental.IsNull=false then edtnum_presentfeebusrental.Value := Datamodule1.ZQrystrukpresentfeebusrental.Value;

 if Datamodule1.ZQrystrukmt.IsNull=false then edtnum_mt.Value := Datamodule1.ZQrystrukmt.Value;
 if Datamodule1.ZQrystrukrewardmember.IsNull=false then edtnum_rewardmember.Value := Datamodule1.ZQrystrukrewardmember.Value;
 if Datamodule1.ZQrystrukrewardcair.IsNull=false then edtnum_rewardcair.Value := Datamodule1.ZQrystrukrewardcair.Value;

 Datamodule1.ZQrystruk.Close;

end;

end.
