unit memberreward;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, Grids, DBGrids, RzDBGrid, RzLabel, ExtDlgs, JPEG,
  RzStatus, RzButton, RzRadChk, frxClass, VolDBGrid, db;

type
  TFrmmemberreward = class(TForm)
    Panel: TRzPanel;
    RzPanel2: TRzPanel;
    LblCaption: TRzLabel;
    RtrJualTxtCetak: TRzCheckBox;
    RzPanel7: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    SellBtnAdd: TAdvSmoothButton;
    SellBtnDel: TAdvSmoothButton;
    SellPanelCredit: TRzPanel;
    RzPanel4: TRzPanel;
    RzLabel16: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel11: TRzLabel;
    edt_nama: TRzEdit;
    edt_ktpno: TRzEdit;
    edt_hpno: TRzEdit;
    edt_golongan: TRzEdit;
    edt_tglreg: TRzEdit;
    edt_cardno2: TRzEdit;
    DBG_rwd: TVolgaDBGrid;
    RzLabel1: TRzLabel;
    edt_faktur: TRzEdit;
    RzLabel129: TRzLabel;
    dte_tgl: TRzDateTimeEdit;
    RzLabel7: TRzLabel;
    edtnum_totalreward: TRzNumericEdit;
    edt_cardno: TRzEdit;
    procedure FormShow(Sender: TObject);
    procedure AdjustBtnAddClick(Sender: TObject);
    procedure SellBtnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBG_rwdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBG_rwdCellClick(Sender: TObject; Column: TVolgaColumn);
    procedure edt_cardnoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBG_rwdKeyPress(Sender: TObject; var Key: Char);
  private
    procedure ClearForm;
    procedure InsertDataMaster;
    procedure refreshDBgrid(cardno : string);
    function getNoRWD : string;
    procedure resetinfomember;
    procedure inputcardno(nilai:string);
    { Private declarations }
  public
    procedure PrintStruck(NoFaktur: string);
    { Public declarations }
  end;

var
  Frmmemberreward: TFrmmemberreward;

implementation

uses SparePartFunction, U_cetak, Data;

{$R *.dfm}

function TFrmmemberreward.getNoRWD : string;
var Year,Month,Day: Word;
    vlok : string;
begin
    DecodeDate(TglSkrg,Year,Month,Day);

    if lokasigudang='MADUKORO' then vlok := 'MD'
    else if lokasigudang='SILIWANGI' then vlok := 'SL'
    else vlok := standPos;

    with DataModule1.ZQrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select max(right(faktur,5)) from memberreward ');
      SQL.Add('where faktur like "RWD' + vlok + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '%' + '"');
      Open;
      if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsString = '') then
        result := 'RWD' + vlok + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '00001'
      else
        result := 'RWD' + vlok + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + FormatCurr('00000',Fields[0].AsInteger + 1);
      Close;
    end;
end;

procedure TFrmmemberreward.refreshDBgrid(cardno : string);
begin
  edtnum_totalreward.Value := 0;

  DataModule1.ZQryselltourgroup.Close;
  DataModule1.ZQryselltourgroup.Open;

  DBG_rwd.Columns[0].ReadOnly := false;

  if (cardno='') then
  begin
   DataModule1.ZQrymemberabsensireward.Close;
   exit;
  end;

  DataModule1.ZConnection1.ExecuteDirect('update memberabsensi set isprint=0 where faktur is null and isprint=1');

  DataModule1.ZQrymemberabsensireward.Close;
  DataModule1.ZQrymemberabsensireward.SQL.Text := 'select * from memberabsensi where cardno='+Quotedstr(cardno)+' and faktur is null order by nogroup';
  DataModule1.ZQrymemberabsensireward.Open;

  if DataModule1.ZQrymemberabsensireward.IsEmpty then DBG_rwd.Columns[0].ReadOnly := true;
end;

procedure TFrmmemberreward.ClearForm;
begin
  edt_Faktur.Text := getNoRWD;
  dte_tgl.Date := TglSkrg;

  resetinfomember;

end;

procedure TFrmmemberreward.InsertDataMaster;
var S,P,vsqlfromme : string;
begin
  edtnum_totalreward.Value := getdatanum('sum(rewardmember)','memberabsensi where isprint=1 and cardno='+Quotedstr(trim(edt_cardno2.Text))+ ' and faktur is null');
  tglskrg := getnow;
  S:= 'insert into memberreward ' +
      '(faktur,tgl,cardno,totalreward,IDuser,username,lokasi) values ' +
      '(' + Quotedstr(edt_Faktur.Text) + ',' +
      Quotedstr(formatdatetime('yyyy-mm-dd hh:nn:ss',tglskrg))+ ',' +
      Quotedstr(trim(edt_cardno2.Text)) + ',' +
      Quotedstr(Floattostr(edtnum_totalreward.Value)) + ',' +
      inttostr(IDuserlogin) + ',' +
      Quotedstr(username) + ',' +
      Quotedstr(lokasigudang) + ');';

  P := '(';
  Datamodule1.ZQrymemberabsensireward.First;
  while not Datamodule1.ZQrymemberabsensireward.Eof do
  begin
   if Datamodule1.ZQrymemberabsensirewardisprint.Value=1 then
      P:=P+Quotedstr(formatdatetime('yyyy-mm-dd hh:nn:ss',Datamodule1.ZQrymemberabsensirewardtgl.AsDateTime));

   Datamodule1.ZQrymemberabsensireward.Next;
   if (Datamodule1.ZQrymemberabsensireward.Eof) then P:=P+')' else P:=P+',';
  end;

  if Datamodule1.ZConnection1.ExecuteDirect(S) then
  begin
   vsqlfromme := '('+Quotedstr(S)+'),';
   S:= 'update memberabsensi set faktur='+Quotedstr(edt_Faktur.Text)+',rewardmember='+Quotedstr(Floattostr(rewardmember))+' where isprint=1 and faktur is null and cardno='+Quotedstr(trim(edt_cardno2.Text))+';';
   P:= 'update memberabsensi set faktur='+Quotedstr(edt_Faktur.Text)+',rewardmember='+Quotedstr(Floattostr(rewardmember))+',isprint=1 where tgl in '+P+' and faktur is null and cardno='+Quotedstr(trim(edt_cardno2.Text))+';';
   if Datamodule1.ZConnection1.ExecuteDirect(S) then write_and_sendsql_to_remotemysql(vsqlfromme+'('+Quotedstr(P)+');');
  end;
end;


procedure TFrmmemberreward.PrintStruck(NoFaktur: string);
var
  F : TextFile;
  i,totrp : integer;
  nmfile,vnumstr : string;
begin
  nmfile := vpath + 'rewardstruk.txt';

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQrystruk.Open;

   AssignFile(F,nmfile);
   Rewrite(F);
   Writeln(F,'   '+Datamodule1.ZQrystrukcompany.value);
   Writeln(F,' '+Datamodule1.ZQrystrukalamat.value);
   Writeln(F,' '+Datamodule1.ZQrystrukphone.value);
   Writeln(F,' =================================== ');
   Writeln(F,' REWARD MEMBER');
   Writeln(F,' No.Bukti: ' + edt_faktur.text);
   Writeln(F,' Tanggal : ' + FormatDatetime('dd-mm-yyyy',tglskrg));
   Writeln(F,' Lokasi  : '  + lokasigudang);
   Writeln(F,' Member  : '  + edt_cardno2.text + ' ' + edt_nama.text);
   Writeln(F,' ----------------------------------- ');
   i:=1;

   DataModule1.ZQrymemberabsensireward.First;
   while not DataModule1.ZQrymemberabsensireward.Eof do
   begin
    if i<10 then vnumstr := inttostr(i)+'  ' else vnumstr := inttostr(i)+' ';

    Writeln(F,' '+vnumstr + FormatDatetime('dd-mm-yyyy',DataModule1.ZQrymemberabsensirewardtgl.Value) + ' [' + DataModule1.ZQrymemberabsensirewardnogroup.value + '] ' + DataModule1.ZQrymemberabsensirewardlokasi.value );
    Writeln(F,'');

    i := i + 1;
    DataModule1.ZQrymemberabsensireward.Next;
   end;

   Writeln(F,' ----------------------------------- ');
   Writeln(F,'                Total : Rp.' + FormatFloat('###,##0',edtnum_totalreward.Value));
   Writeln(F,'');
   Writeln(F,' Dibuat Oleh,       Mengetahui,');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,' (            )    (            )');
   Writeln(F,'');
   Writeln(F,'Printed By ' + UserName + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',getnow));
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,chr(27)+chr(105));
   Writeln(F,chr(27)+chr(112)+chr(0)+chr(50)+chr(250));

   CloseFile(F);

   Datamodule1.ZQrystruk.Close;

   cetakFile(nmfile);

end;

procedure TFrmmemberreward.FormShow(Sender: TObject);
begin
  readandexecutesql_from_remotemysql;

  ipcomp := getComputerIP;

  Panel.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panel.Color := $00808040;

  LblCaption.Caption := 'Input Print Reward Member';

  if LblCaption.Caption = 'Input Print Reward Member' then
  begin
    ClearForm;
  end
  else
  begin
  end;
end;

procedure TFrmmemberreward.AdjustBtnAddClick(Sender: TObject);
begin
  DataModule1.ZQrymemberabsensireward.CommitUpdates;

  if trim(edt_cardno2.Text)='' then
  begin
   ErrorDialog('Input data No. Card Member dahulu ....');
   resetinfomember;
   exit;
  end;

  if DataModule1.ZQrymemberabsensireward.IsEmpty then
  begin
   errordialog('Tidak ada kedatangan member dan rombongannya di tampilan data!');
   exit;
  end;

  readandexecutesql_from_remotemysql;

  if isdataexist('select tgl from memberabsensi where cardno='+Quotedstr(trim(edt_cardno2.Text))+' and faktur is null and isprint=1 ')=false then
  begin
   errordialog('Pilih/Check dulu kedatangan member di tampilan data!');
   exit;
  end;

  DataModule1.ZConnection1.StartTransaction;
  try
    InsertDataMaster;
    LogInfo(UserName,'Insert Print Reward Member Faktur No: ' + edt_Faktur.Text + ',Total: ' + FloatToStr(edtnum_totalreward.Value));

    DataModule1.ZConnection1.Commit;

    PrintStruck(edt_Faktur.Text);
    PrintStruck(edt_Faktur.Text);

    InfoDialog('Berhasil Input Print Reward Member No.Bukti: ' + edt_Faktur.Text + ',Total: ' + FloatToStr(edtnum_totalreward.Value));
    ClearForm;
  except
    DataModule1.ZConnection1.Rollback;
    ErrorDialog('Gagal Input, coba ulangi lagi!');
    ClearForm;
  end;

end;

procedure TFrmmemberreward.SellBtnDelClick(Sender: TObject);
begin
 ClearForm;
end;

procedure TFrmmemberreward.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 DataModule1.ZQrymemberabsensireward.Close;
 DataModule1.ZQryselltourgroup.Close;
end;

procedure TFrmmemberreward.DBG_rwdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then
  begin
    Key := 0;
  end;

  edt_cardno.Text := '';
  edt_cardno.SetFocus;

end;

procedure TFrmmemberreward.DBG_rwdCellClick(Sender: TObject;
  Column: TVolgaColumn);
begin
 if (column.Index=0)and((Sender as TVolgaDBGrid).DataSource.DataSet.State=dsEdit)and(trim(edt_cardno2.Text)<>'') then
 begin
  if Datamodule1.ZQrymemberabsensirewardisprint.Value=1 then Datamodule1.ZQrymemberabsensirewardrewardmember.Value := rewardmember
  else Datamodule1.ZQrymemberabsensirewardrewardmember.Value := 0;
  Datamodule1.ZQrymemberabsensireward.CommitUpdates;

  edtnum_totalreward.Value := getdatanum('sum(rewardmember)','memberabsensi where isprint=1 and cardno='+Quotedstr(trim(edt_cardno2.Text))+ ' and faktur is null');
 end;

 edt_cardno.Text := '';
 edt_cardno.SetFocus;
end;

procedure TFrmmemberreward.resetinfomember;
begin
 refreshDBgrid('');

 edt_cardno2.Text := '';
 edt_nama.text := '';
 edt_ktpno.text := '';
 edt_hpno.text := '';
 edt_golongan.text := '';
 edt_tglreg.Text := '';

 edt_cardno.Text := '';
 edt_cardno.SetFocus;
end;

procedure TFrmmemberreward.inputcardno(nilai:string);
var bufstr : string;
    i : integer;
begin
 bufstr := trim(nilai);

 resetinfomember;

 if bufstr='' then
 begin
  ErrorDialog('Isi data No. Card Member dahulu ....');
  exit;
 end;

 if isdataexist('select nama from member where cardno='+Quotedstr(bufstr))=false then
 begin
  ErrorDialog('No. Card '+bufstr+' belum terdaftar ....');
  exit;
 end;

 Datamodule1.ZQryUtil.Close;
 Datamodule1.ZQryUtil.SQL.Text := 'select nama,ktpno,hpno,golongan,tglreg from member where cardno='+Quotedstr(bufstr);
 Datamodule1.ZQryUtil.Open;
 edt_cardno2.Text := bufstr;
 if Datamodule1.ZQryUtil.Fields[0].IsNull=false then edt_nama.Text := Datamodule1.ZQryUtil.Fields[0].AsString;
 if Datamodule1.ZQryUtil.Fields[1].IsNull=false then edt_ktpno.Text := Datamodule1.ZQryUtil.Fields[1].AsString;
 if Datamodule1.ZQryUtil.Fields[2].IsNull=false then edt_hpno.Text := Datamodule1.ZQryUtil.Fields[2].AsString;
 if Datamodule1.ZQryUtil.Fields[3].IsNull=false then edt_golongan.Text := Datamodule1.ZQryUtil.Fields[3].AsString;
 if Datamodule1.ZQryUtil.Fields[4].IsNull=false then edt_tglreg.Text := Formatdatetime('dd/mm/yyyy',Datamodule1.ZQryUtil.Fields[4].Asdatetime);
 Datamodule1.ZQryUtil.Close;

 refreshDBgrid(bufstr);
end;

procedure TFrmmemberreward.edt_cardnoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (Key=VK_RETURN)and(trim(edt_cardno.Text)<>'') then
 begin
  inputcardno(edt_cardno.Text);
 end;
end;

procedure TFrmmemberreward.DBG_rwdKeyPress(Sender: TObject; var Key: Char);
begin
 edt_cardno.Text := '';
 edt_cardno.SetFocus;
end;

end.
