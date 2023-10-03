unit selltourgroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, RzLabel, ExtDlgs, JPEG, DB,
  RzButton, RzRadChk;

type
  Tfrmselltourgroup = class(TForm)
    Panelsales: TRzPanel;
    RzPanel2: TRzPanel;
    LblCaption: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel12: TRzLabel;
    RzLabel14: TRzLabel;
    BtnAdd: TAdvSmoothButton;
    BtnDel: TAdvSmoothButton;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    edt_namatour: TRzEdit;
    edt_nogroup: TRzEdit;
    RzLabel1: TRzLabel;
    dte_tgl: TRzDateTimeEdit;
    RzLabel4: TRzLabel;
    edtnum_jumlorg: TRzNumericEdit;
    RzLabel5: TRzLabel;
    edt_leader: TRzEdit;
    RzLabel6: TRzLabel;
    edt_driver: TRzEdit;
    RzLabel7: TRzLabel;
    edt_asal: TRzEdit;
    RzLabel8: TRzLabel;
    edt_tujuan: TRzEdit;
    RzLabel9: TRzLabel;
    mem_keterangan: TRzMemo;
    lbl_jenisbus: TRzLabel;
    cb_jenisbus: TRzComboBox;
    RzLabel11: TRzLabel;
    edtnum_presentfee: TRzNumericEdit;
    lbl_norental: TRzLabel;
    RzLabel10: TRzLabel;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb_jenisbusChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function  getNoRental : string;
    procedure InsertData;
    procedure UpdateData;
    { Private declarations }
  public
    { Public declarations }
    isbusrental : boolean;
    procedure FormShowFirst;
  end;

var
  frmselltourgroup: Tfrmselltourgroup;

implementation

uses selltourgroupmaster, SparePartFunction, Data;

{$R *.dfm}

function Tfrmselltourgroup.getNoRental : string;
var Year,Month,Day: Word;
begin
    DataModule1.ZQrySearch.Close;

    DecodeDate(TglSkrg,Year,Month,Day);

    with DataModule1.ZQrySearch do
    begin
      Close;
      SQL.Clear;

      SQL.Add('select max(right(norental,3)) from selltourgroup ');
      SQL.Add('where norental like "R' + FormatCurr('00',Month) + Copy(IntToStr(Year),3,2)  + '%' + '" ');

      Open;
      if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsString = '') then
        result := 'R' + FormatCurr('00',Month) + Copy(IntToStr(Year),3,2) + '-001'
      else
        result := 'R' + FormatCurr('00',Month) + Copy(IntToStr(Year),3,2) + '-' + FormatCurr('000',Fields[0].AsInteger + 1);
      Close;
    end;
end;

procedure Tfrmselltourgroup.InsertData;
begin
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into selltourgroup ');
    SQL.Add('(nogroup,norental,tgl,namatour,jumlorg,leader,driver,asal,tujuan,jenisbus,presentfee,keterangan) values ');
    SQL.Add('(' + QuotedStr(trim(edt_nogroup.Text)) );
    SQL.Add(',' + QuotedStr(lbl_norental.Caption) );
    SQL.Add(',' + QuotedStr(getmysqldatestr(dte_tgl.Date)) );
    SQL.Add(',' + QuotedStr(trim(edt_namatour.Text)) );
    SQL.Add(',' + QuotedStr(floattostr(edtnum_jumlorg.Value)) );
    SQL.Add(',' + QuotedStr(trim(edt_leader.Text)) );
    SQL.Add(',' + QuotedStr(trim(edt_driver.Text)) );
    SQL.Add(',' + QuotedStr(trim(edt_asal.Text)) );
    SQL.Add(',' + QuotedStr(trim(edt_tujuan.Text)) );
    if isbusrental then SQL.Add(',' + QuotedStr('0') )
    else SQL.Add(',' + QuotedStr(inttostr(cb_jenisbus.itemindex+1)) );
    SQL.Add(',' + QuotedStr(Number2MySQL(edtnum_presentfee.value)) );
    SQL.Add(',' + QuotedStr(trim(mem_keterangan.Text)) + ')');
    ExecSQL;
  end;
end;

procedure Tfrmselltourgroup.UpdateData;
begin
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update selltourgroup set ');
    SQL.Add('nogroup=' + QuotedStr(trim(edt_nogroup.Text)) );
    SQL.Add(',norental=' + QuotedStr(lbl_norental.Caption) );
    SQL.Add(',tgl=' + QuotedStr(getmysqldatestr(dte_tgl.Date)) );
    SQL.Add(',namatour=' + QuotedStr(trim(edt_namatour.Text)) );
    SQL.Add(',jumlorg=' + QuotedStr(floattostr(edtnum_jumlorg.Value)) );
    SQL.Add(',leader=' + QuotedStr(trim(edt_leader.Text)) );
    SQL.Add(',driver=' + QuotedStr(trim(edt_driver.Text)) );
    SQL.Add(',asal=' + QuotedStr(trim(edt_asal.Text)) );
    SQL.Add(',tujuan=' + QuotedStr(trim(edt_tujuan.Text)) );

    if isbusrental then SQL.Add(',jenisbus=' + QuotedStr('0') )
    else SQL.Add(',jenisbus=' + QuotedStr(inttostr(cb_jenisbus.itemindex+1)) );
    SQL.Add(',presentfee=' + QuotedStr(Number2MySQL(edtnum_presentfee.value)) );
    SQL.Add(',keterangan=' + QuotedStr(trim(mem_keterangan.Text)) + ' ');
    SQL.Add('where IDselltourgroup = ' + Datamodule1.ZQryselltourgroupIDselltourgroup.AsString );
    ExecSQL;
  end;
end;


procedure Tfrmselltourgroup.FormShowFirst;
begin
  if LblCaption.Caption = 'Tambah Tour Group' then
  begin
    edt_nogroup.ReadOnly := false;
    edt_namatour.ReadOnly := false;

    dte_tgl.Date := tglskrg;
    edt_nogroup.Text := '';
    edt_namatour.Text := '';
    edtnum_jumlorg.Value := 0;
    edt_leader.Text := '';
    edt_driver.Text := '';
    edt_asal.Text := '';
    edt_tujuan.Text := '';
    mem_keterangan.Text := '';

    cb_jenisbus.Visible  := isbusrental=false;
    lbl_norental.Caption := '';
    lbl_norental.Visible := false;
    edt_nogroup.Left := 168;
    lbl_jenisbus.Caption:='Jenis Bus';
    if isbusrental then
    begin
     lbl_jenisbus.Caption:='Jenis Bus Rental';
     lbl_norental.Visible := true;
     lbl_norental.Caption := getnorental;
     edt_nogroup.Left := 240;
    end;
    cb_jenisbus.ItemIndex := 0;
    cb_jenisbusChange(cb_jenisbus);
  end
  else
  begin
    dte_tgl.Date := tglskrg;

    edt_nogroup.Text := '';
    edt_namatour.Text := '';
    edtnum_jumlorg.Value := 0;
    edt_leader.Text := '';
    edt_driver.Text := '';
    edt_asal.Text := '';
    edt_tujuan.Text := '';
    mem_keterangan.Text := '';

    cb_jenisbus.Visible := isbusrental=false;
    lbl_norental.Caption := '';
    lbl_norental.Visible := false;
    edt_nogroup.Left := 168;
    lbl_jenisbus.Caption:='Jenis Bus';
    if isbusrental then
    begin
     lbl_jenisbus.Caption:='Jenis Bus Rental';
     lbl_norental.Visible := true;
     lbl_norental.Caption := '';
     edt_nogroup.Left := 240;
    end;

    cb_jenisbus.ItemIndex := 0;

    if DataModule1.ZQryselltourgrouptgl.IsNull=false then
    dte_tgl.Date := DataModule1.ZQryselltourgrouptgl.AsDateTime;

    if DataModule1.ZQryselltourgroupnamatour.IsNull=false then
    edt_namatour.Text := DataModule1.ZQryselltourgroupnamatour.Value;

    if DataModule1.ZQryselltourgroupjumlorg.IsNull=false then
    edtnum_jumlorg.Value := DataModule1.ZQryselltourgroupjumlorg.Value;

    if DataModule1.ZQryselltourgroupnogroup.IsNull=false then
    edt_nogroup.Text := DataModule1.ZQryselltourgroupnogroup.Value;

    if DataModule1.ZQryselltourgroupnorental.IsNull=false then
    lbl_norental.Caption := DataModule1.ZQryselltourgroupnorental.Value;

    if DataModule1.ZQryselltourgroupleader.IsNull=false then
    edt_leader.Text := DataModule1.ZQryselltourgroupleader.Value;

    if DataModule1.ZQryselltourgroupdriver.IsNull=false then
    edt_driver.Text := DataModule1.ZQryselltourgroupdriver.Value;

    if DataModule1.ZQryselltourgroupasal.IsNull=false then
    edt_asal.Text := DataModule1.ZQryselltourgroupasal.Value;

    if DataModule1.ZQryselltourgrouptujuan.IsNull=false then
    edt_tujuan.Text := DataModule1.ZQryselltourgrouptujuan.Value;

    if DataModule1.ZQryselltourgroupketerangan.IsNull=false then
    mem_keterangan.Text := DataModule1.ZQryselltourgroupketerangan.Value;

    if DataModule1.ZQryselltourgroupjenisbus.IsNull=false then
    cb_jenisbus.ItemIndex := DataModule1.ZQryselltourgroupjenisbus.Value - 1;

    if DataModule1.ZQryselltourgrouppresentfee.IsNull=false then
    edtnum_presentfee.value := DataModule1.ZQryselltourgrouppresentfee.Value;

    edt_nogroup.ReadOnly  := isdataexist('select IDselltourgroup from sellmaster where IDselltourgroup=' + DataModule1.ZQryselltourgroupIDselltourgroup.AsString);
    edt_namatour.ReadOnly := edt_nogroup.ReadOnly;
  end;
end;

procedure Tfrmselltourgroup.BtnAddClick(Sender: TObject);
var vnogrp : string;
begin
  if trim(dte_tgl.Text) = '' then
  begin
    ErrorDialog('Tanggal harus diisi!');
    dte_tgl.SetFocus;
    Exit;
  end;

  if trim(edt_nogroup.Text) = '' then
  begin
    ErrorDialog('No. Rombongan harus diisi!');
    edt_nogroup.SetFocus;
    Exit;
  end;

  if (isbusrental=false) then
  begin
  if (trim(cb_jenisbus.Text) = '')or(cb_jenisbus.ItemIndex=-1) then
  begin
    ErrorDialog('Jenis Bus harus diisi!');
    cb_jenisbus.SetFocus;
    Exit;
  end;
  end;

  if (LblCaption.Caption = 'Tambah Tour Group')and(isdataexist('select IDselltourgroup from selltourgroup where nogroup=' + Quotedstr(trim(edt_nogroup.Text)) + ' and norental='+ Quotedstr(lbl_norental.Caption) +' and tgl=' + Quotedstr(getmysqldatestr(dte_tgl.Date)) )) then
  begin
   errordialog('No.Rombongan sudah terdaftar!');
   exit;
  end;

  if (LblCaption.Caption = 'Edit Tour Group')and(isdataexist('select IDselltourgroup from selltourgroup where IDselltourgroup<>'+DataModule1.ZQryselltourgroupIDselltourgroup.AsString+' and nogroup=' + Quotedstr(trim(edt_nogroup.Text))  + ' and norental='+ Quotedstr(lbl_norental.Caption) + ' and tgl=' + Quotedstr(getmysqldatestr(dte_tgl.Date)) )) then
  begin
   errordialog('No.Rombongan sudah terdaftar!');
   exit;
  end;

  if LblCaption.Caption = 'Tambah Tour Group' then
  begin
    InsertData;
    if lbl_norental.Caption<>'' then vnogrp := lbl_norental.Caption + '/' + edt_nogroup.Text
    else vnogrp := edt_nogroup.Text;
    InfoDialog('Tambah Tour Group ' + vnogrp + ' berhasil');
    LogInfo(UserName,'Insert Tour Group No.Group: ' + vnogrp + ',nama Biro: ' + edt_namatour.Text);
  end
  else
  begin
    UpdateData;
    if lbl_norental.Caption<>'' then vnogrp := lbl_norental.Caption + '/' + edt_nogroup.Text
    else vnogrp := edt_nogroup.Text;
    InfoDialog('Edit Tour Group ' + vnogrp + ' berhasil');
    LogInfo(UserName,'Edit Tour Group No.Group: ' + vnogrp + ',nama Biro: ' + edt_namatour.Text);
  end;
  Close;
end;

procedure Tfrmselltourgroup.BtnDelClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmselltourgroup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 IF Frmselltourgroupmaster=nil then
 application.CreateForm(TFrmselltourgroupmaster,Frmselltourgroupmaster);
 Frmselltourgroupmaster.Align:=alclient;
 Frmselltourgroupmaster.Parent:=Self.Parent;
 Frmselltourgroupmaster.BorderStyle:=bsnone;
 Frmselltourgroupmaster.FormShowFirst;
 Frmselltourgroupmaster.Show;


end;

procedure Tfrmselltourgroup.cb_jenisbusChange(Sender: TObject);
begin
 if isbusrental then edtnum_presentfee.Value := getdatanum('presentfeebusrental','struk where isaktif=1')
 else
 begin
  case cb_jenisbus.ItemIndex of
   0 : edtnum_presentfee.Value := getdatanum('presentfeebusbesar','struk where isaktif=1');
   1 : edtnum_presentfee.Value := getdatanum('presentfeebuskecil','struk where isaktif=1');
  end;
 end;
end;

procedure Tfrmselltourgroup.FormShow(Sender: TObject);
begin
  Panelsales.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelsales.Color := $00808040;

end;

end.
