unit frmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, RzLabel, ExtDlgs, JPEG,
  RzChkLst, RzLstBox, DB, RzButton, RzRadChk;

type
  TfrmCust = class(TForm)
    PanelCust: TRzPanel;
    RzPanel2: TRzPanel;
    CustLblCaption: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel12: TRzLabel;
    RzLabel14: TRzLabel;
    CustBtnAdd: TAdvSmoothButton;
    CustBtnDel: TAdvSmoothButton;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    CustTxtAlamat: TRzMemo;
    CustTxtKota: TRzEdit;
    CustTxtPhone: TRzEdit;
    CustTxtFax: TRzEdit;
    CustTxtEmail: TRzEdit;
    CustTxtPos: TRzEdit;
    CustTxtKode: TRzEdit;
    CustTxtNama: TRzEdit;
    RzLabel9: TRzLabel;
    CustTxtWebSite: TRzEdit;
    RzLabel10: TRzLabel;
    CustTxtPhone2: TRzEdit;
    RzLabel11: TRzLabel;
    RzLabel13: TRzLabel;
    CustTxthp: TRzEdit;
    CustTxthp2: TRzEdit;
    RzLabel16: TRzLabel;
    CustTxtAlamat2: TRzMemo;
    RzLabel17: TRzLabel;
    CustTxtnotes: TRzMemo;
    RzLabel19: TRzLabel;
    CustTxtKota2: TRzEdit;
    JasaLblNonEfektif: TRzLabel;
    CustTxtNonEfektif: TRzDateTimeEdit;
    RzLabel15: TRzLabel;
    CustTxttglreg: TRzDateTimeEdit;
    RzLabel18: TRzLabel;
    CustTxtTgllahir: TRzDateTimeEdit;
    RzLabel20: TRzLabel;
    CustTxtHobby: TRzEdit;
    RzLabel21: TRzLabel;
    CustTxtcp: TRzEdit;
    procedure FormActivate(Sender: TObject);
    procedure CustBtnAddClick(Sender: TObject);
    procedure CustBtnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure InsertData;
    procedure UpdateData;
    { Private declarations }
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  frmCust: TfrmCust;

implementation

uses SparePartFunction, Data, customermaster;

{$R *.dfm}

procedure TfrmCust.InsertData;
begin
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into customer');
    SQL.Add('(kode,nama,alamat,alamat2,kota,kota2,cp,kodepos,telephone,telephone2,hobby,hp,hp2,fax,notes,email,website,tgllahir,tglreg,tglnoneffective) values ');
    SQL.Add('(' + QuotedStr(CustTxtKode.Text) + ',');
    SQL.Add(QuotedStr(CustTxtNama.Text) + ',');
    SQL.Add(QuotedStr(CustTxtAlamat.Text) + ',');
    SQL.Add(QuotedStr(CustTxtAlamat2.Text) + ',');
    SQL.Add(QuotedStr(CustTxtKota.Text) + ',');
    SQL.Add(QuotedStr(CustTxtKota2.Text) + ',');
    SQL.Add(QuotedStr(CustTxtcp.Text) + ',');
    SQL.Add(QuotedStr(CustTxtPos.Text) + ',');
    SQL.Add(QuotedStr(CustTxtPhone.Text) + ',');
    SQL.Add(QuotedStr(CustTxtPhone2.Text) + ',');
    SQL.Add(QuotedStr(CustTxtHobby.Text) + ',');
    SQL.Add(QuotedStr(CustTxthp.Text) + ',');
    SQL.Add(QuotedStr(CustTxthp2.Text) + ',');
    SQL.Add(QuotedStr(CustTxtFax.Text) + ',');
    SQL.Add(QuotedStr(CustTxtnotes.Text) + ',');
    SQL.Add(QuotedStr(CustTxtemail.Text) + ',');
    SQL.Add(QuotedStr(CustTxtwebsite.Text) + ',');

    if CustTxtTgllahir.Text = '' then
      SQL.Add('null,')
    else
      SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',CustTxtTgllahir.Date)) + ',');

    if CustTxtTglreg.Text = '' then
      SQL.Add('null,')
    else
      SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',CustTxtTglreg.Date)) + ',');

    if CustTxtNonEfektif.Text = '' then
      SQL.Add('null)')
    else
      SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',CustTxtNonEfektif.Date)) + ')');

    ExecSQL;

  end;

 // if (DataModule1.ZConnection1.Catalog='sparepart') then
 //     DataModule1.ZConn2.ExecuteDirect(DataModule1.ZQryFunction.SQL.Text);
end;

procedure TfrmCust.UpdateData;
begin
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update customer set');
    SQL.Add('nama = ' + QuotedStr(CustTxtNama.Text) + ',');
    SQL.Add('alamat = ' + QuotedStr(CustTxtAlamat.Text) + ',');
    SQL.Add('alamat2 = ' + QuotedStr(CustTxtAlamat2.Text) + ',');
    SQL.Add('kota = ' + QuotedStr(CustTxtKota.Text) + ',');
    SQL.Add('kota2 = ' + QuotedStr(CustTxtKota2.Text) + ',');
    SQL.Add('cp = ' + QuotedStr(CustTxtcp.Text) + ',');
    SQL.Add('kodepos = ' + QuotedStr(CustTxtPos.Text) + ',');
    SQL.Add('telephone = ' + QuotedStr(CustTxtPhone.Text) + ',');
    SQL.Add('telephone2 = ' + QuotedStr(CustTxtPhone2.Text) + ',');
    SQL.Add('hp = ' + QuotedStr(CustTxthp.Text) + ',');
    SQL.Add('hp2 = ' + QuotedStr(CustTxthp2.Text) + ',');
    SQL.Add('hobby = ' + QuotedStr(CustTxthobby.Text) + ',');
    SQL.Add('email = ' + QuotedStr(CustTxtemail.Text) + ',');
    SQL.Add('notes = ' + QuotedStr(CustTxtnotes.Text) + ',');
    SQL.Add('fax = ' + QuotedStr(CustTxtFax.Text) + ',');

    if CustTxttgllahir.Text='' then
       SQL.Add('tgllahir = null,')
    else SQL.Add('tgllahir = ' + QuotedStr(FormatDateTime('yyyy-MM-dd',CustTxtTgllahir.Date)) + ',');

    if CustTxttglreg.Text='' then
       SQL.Add('tglreg = null,')
    else SQL.Add('tglreg = ' + QuotedStr(FormatDateTime('yyyy-MM-dd',CustTxtTglreg.Date)) + ',');

    if CustTxtNonEfektif.Text='' then
       SQL.Add('tglnoneffective = null,')
    else SQL.Add('tglnoneffective = ' + QuotedStr(FormatDateTime('yyyy-MM-dd',CustTxtNonEfektif.Date)) + ',');

    SQL.Add('website = ' + QuotedStr(CustTxtwebsite.Text));
    SQL.Add(' where kode = ' + QuotedStr(CustTxtKode.Text));
    ExecSQL;

  end;

//  if (DataModule1.ZConnection1.Catalog='sparepart') then
//      DataModule1.ZConn2.ExecuteDirect(DataModule1.ZQryFunction.SQL.Text);
  
end;

procedure TfrmCust.FormActivate(Sender: TObject);
begin
{  frmCust.Top := frmcustomermaster.PanelCustomer.Top + 26;
  frmCust.Height := frmcustomermaster.PanelCustomer.Height;
  frmCust.Width := frmcustomermaster.PanelCustomer.Width;
  frmCust.Left := 1; }
end;

procedure TfrmCust.FormShowFirst;
begin
  if CustLblCaption.Caption = 'Tambah Customer' then
  begin
 //   CustTxtKode.Enabled := True;
    CustTxtKode.Text := '';
    CustTxtNama.Text := '';
    CustTxtAlamat.Text := '';
    CustTxtAlamat2.Text := '';
    CustTxtKota.Text := '';
    CustTxtKota2.Text := '';
    CustTxtcp.Text := '';
    CustTxtPos.Text := '';
    CustTxtPhone.Text := '';
    CustTxtPhone2.Text := '';
    CustTxthp.Text := '';
    CustTxthp2.Text := '';
    CustTxtemail.Text := '';
    CustTxtFax.Text := '';
    CustTxtwebsite.Text := '';
    CustTxthobby.Text := '';
    CustTxtnotes.Text := '';

    CustTxtTgllahir.Text := '';
    CustTxtTglreg.Date := TglSkrg;

    CustTxtNonEfektif.Enabled := False;
    CustTxtNonEfektif.Text := '';

  end
  else
  begin
    CustTxtKode.Text := '';
    CustTxtNama.Text := '';
    CustTxtAlamat.Text := '';
    CustTxtAlamat2.Text := '';
    CustTxtKota.Text := '';
    CustTxtKota2.Text := '';
    CustTxtcp.Text := '';
    CustTxtPos.Text := '';
    CustTxtPhone.Text := '';
    CustTxtPhone2.Text := '';
    CustTxthp.Text := '';
    CustTxthp2.Text := '';
    CustTxtemail.Text := '';
    CustTxtFax.Text := '';
    CustTxtwebsite.Text := '';
    CustTxthobby.Text := '';
    CustTxtnotes.Text := '';

//    CustTxtKode.Enabled := False;
    if DataModule1.ZQryCustomerkode.IsNull=false then
    CustTxtKode.Text := DataModule1.ZQryCustomerkode.Text;

    if DataModule1.ZQryCustomernama.IsNull=false then
    CustTxtNama.Text := DataModule1.ZQryCustomernama.Text;

    if DataModule1.ZQryCustomeralamat.IsNull=false then
    CustTxtAlamat.Text := DataModule1.ZQryCustomeralamat.Text;

    if DataModule1.ZQryCustomeralamat2.IsNull=false then
    CustTxtAlamat2.Text := DataModule1.ZQryCustomeralamat2.Text;

    if DataModule1.ZQryCustomerkota.IsNull=false then
    CustTxtKota.Text := DataModule1.ZQryCustomerkota.Text;

    if DataModule1.ZQryCustomerkota2.IsNull=false then
    CustTxtKota2.Text := DataModule1.ZQryCustomerkota2.Text;

    if DataModule1.ZQryCustomercp.IsNull=false then
    CustTxtcp.Text := DataModule1.ZQryCustomercp.Text;

    if DataModule1.ZQryCustomerkodepos.IsNull=false then
    CustTxtPos.Text := DataModule1.ZQryCustomerkodepos.Text;

    if DataModule1.ZQryCustomertelephone.IsNull=false then
    CustTxtPhone.Text := DataModule1.ZQryCustomertelephone.Text;

    if DataModule1.ZQryCustomertelephone2.IsNull=false then
    CustTxtPhone2.Text := DataModule1.ZQryCustomertelephone2.Text;

    if DataModule1.ZQryCustomerhp.IsNull=false then
    CustTxthp.Text := DataModule1.ZQryCustomerhp.Text;

    if DataModule1.ZQryCustomerhp2.IsNull=false then
    CustTxthp2.Text := DataModule1.ZQryCustomerhp2.Text;

    if DataModule1.ZQryCustomeremail.IsNull=false then
    CustTxtemail.Text := DataModule1.ZQryCustomeremail.Text;

    if DataModule1.ZQryCustomerfax.IsNull=false then
    CustTxtFax.Text := DataModule1.ZQryCustomerfax.Text;

    if DataModule1.ZQryCustomerwebsite.IsNull=false then
    CustTxtwebsite.Text := DataModule1.ZQryCustomerwebsite.Text;

    if DataModule1.ZQryCustomerhobby.IsNull=false then
    CustTxthobby.Text := DataModule1.ZQryCustomerhobby.Text;

    if DataModule1.ZQryCustomernotes.IsNull=false then
    CustTxtnotes.Text := DataModule1.ZQryCustomernotes.Text;

    if DataModule1.ZQryCustomertgllahir.Text <> '' then
      CustTxtTgllahir.Date := DataModule1.ZQryCustomertgllahir.Value
    else
      CustTxtTgllahir.Text := '';

    if DataModule1.ZQryCustomertglreg.Text <> '' then
      CustTxtTglreg.Date := DataModule1.ZQryCustomertglreg.Value
    else
      CustTxtTglreg.Text := '';

    if DataModule1.ZQryCustomertglnoneffective.Text <> '' then
      CustTxtNonEfektif.Date := DataModule1.ZQryCustomertglnoneffective.Value
    else
      CustTxtNonEfektif.Text := '';

  end;
end;

procedure TfrmCust.CustBtnAddClick(Sender: TObject);
var
  EmptyValue: Boolean;
begin
{  if CustTxtKode.Text = '' then
  begin
    ErrorDialog('Kode Customer harus diisi!');
    CustTxtKode.SetFocus;
    Exit;
  end;    }
  if CustTxtNama.Text = '' then
  begin
    ErrorDialog('Nama Customer harus diisi!');
    CustTxtNama.SetFocus;
    Exit;
  end;
  if CustTxtTglReg.Text = '' then
  begin
    ErrorDialog('Tgl Registrasi harus diisi!');
    CustTxtTglReg.SetFocus;
    Exit;
  end;

  with DataModule1.ZQrySearch do
  begin
    ///Check if exists
    Close;
    SQL.Clear;
    SQL.Add('select kode from customer');
//    SQL.Add('where kode = ' + QuotedStr(CustTxtKode.Text) + ' or nama = ' + QuotedStr(CustTxtNama.Text));
    SQL.Add('where nama = ' + QuotedStr(CustTxtNama.Text));
    Open;
    EmptyValue := IsEmpty;
  end;

  if CustLblCaption.Caption = 'Tambah Customer' then
  begin
    if EmptyValue = False then
    begin
//      InfoDialog('Kode ' + CustTxtKode.Text + ' atau Nama '+CustTxtNama.Text+' sudah terdaftar');
      InfoDialog('Nama '+CustTxtNama.Text+' sudah terdaftar');
      Exit;
    end;
    InsertData;
    InfoDialog('Tambah Customer ' + CustTxtNama.Text + ' berhasil');
//    LogInfo(UserName,'Insert Customer kode: ' + CustTxtKode.Text + ',nama: ' + CustTxtNama.Text);
    LogInfo(UserName,'Insert Customer nama: ' + CustTxtNama.Text);
  end
  else
  begin
    UpdateData;
    InfoDialog('Edit Customer ' + CustTxtNama.Text + ' berhasil');
//    LogInfo(UserName,'Edit Customer kode: ' + CustTxtKode.Text + ',nama: ' + CustTxtNama.Text);
    LogInfo(UserName,'Edit Customer nama: ' + CustTxtNama.Text);
  end;

 // DataModule1.ZQryCustomer.Locate('nama',CustTxtNama.Text,[]);

  Close;
end;

procedure TfrmCust.CustBtnDelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCust.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 IF Frmcustomermaster=nil then
 application.CreateForm(TFrmcustomermaster,Frmcustomermaster);
 Frmcustomermaster.Align:=alclient;
 Frmcustomermaster.Parent:=Self.Parent;
 Frmcustomermaster.BorderStyle:=bsnone;
 Frmcustomermaster.FormShowFirst;
 Frmcustomermaster.Show;

end;

procedure TfrmCust.FormShow(Sender: TObject);
begin
  PanelCust.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      PanelCust.Color := $00808040;

end;

end.
