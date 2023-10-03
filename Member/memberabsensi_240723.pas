unit memberabsensi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, Grids, DBGrids, RzDBGrid, RzLabel, ExtDlgs,
  RzButton, RzLstBox, frxclass, CheckLst, strutils;

type
  Tfrmmemberabsensi = class(TForm)
    Panelsales: TRzPanel;
    RzPanel2: TRzPanel;
    LblCaption: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel12: TRzLabel;
    RzLabel14: TRzLabel;
    CustBtnAdd: TAdvSmoothButton;
    SellBtnDel: TAdvSmoothButton;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    btn_refresh: TButton;
    clb_nogroup: TCheckListBox;
    RzPanel4: TRzPanel;
    RzLabel16: TRzLabel;
    edt_cardno: TRzEdit;
    RzLabel2: TRzLabel;
    edt_nama: TRzEdit;
    RzLabel3: TRzLabel;
    edt_namatour: TRzEdit;
    RzLabel5: TRzLabel;
    edt_ktpno: TRzEdit;
    RzLabel6: TRzLabel;
    edt_hpno: TRzEdit;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    edt_golongan: TRzEdit;
    edt_tglreg: TRzEdit;
    procedure edt_cardnoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SellBtnDelClick(Sender: TObject);
    procedure clb_nogroupClick(Sender: TObject);
    procedure clb_nogroupKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clb_nogroupKeyPress(Sender: TObject; var Key: Char);
    procedure clb_nogroupKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CustBtnAddClick(Sender: TObject);
    procedure btn_refreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure inputcardno(nilai:string);
    procedure resetinfomember(withcardno: boolean = true);
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  frmmemberabsensi: Tfrmmemberabsensi;

implementation

uses SparePartFunction, Data;

{$R *.dfm}

procedure Tfrmmemberabsensi.resetinfomember(withcardno: boolean = true);
begin
 if withcardno then edt_cardno.Text := '';
 edt_nama.text := '';
 edt_namatour.text := '';
 edt_ktpno.text := '';
 edt_hpno.text := '';
 edt_golongan.text := '';
 edt_tglreg.Text := '';

 edt_cardno.SetFocus;
 edt_cardno.SelectAll;
end;

procedure Tfrmmemberabsensi.FormShowFirst;
begin
 ipcomp := getComputerIP;

 lblCaption.Caption := 'Absensi Member '+formatdatetime('dd mmmm yyyy',tglskrg);

 resetinfomember(true);

 clb_nogroup.Clear;

  Panelsales.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelsales.Color := $00808040;

  btn_refreshClick(btn_refresh);
end;

procedure Tfrmmemberabsensi.inputcardno(nilai:string);
var bufstr,vidmember : string;
    i : integer;
begin
 bufstr := trim(nilai);

 resetinfomember(false);

 if bufstr='' then
 begin
  ErrorDialog('Isi data No. Card Member dahulu ....');
  exit;
 end;

 vidmember := getdata('id','member where cardno='+Quotedstr(bufstr));
 if vidmember='' then
 begin
  ErrorDialog('No. Card '+bufstr+' belum terdaftar ....');
  edt_cardno.Text := '';
  exit;
 end;

 if isdataexist('select IDselltourgroup from memberabsensi where idmember=' + vidmember + ' and date(tgl)=CURRENT_DATE') then
 begin
  ErrorDialog('Maaf Member No.Card '+bufstr+' sudah Absen untuk hari ini ....');
  edt_cardno.Text := '';
  exit;
 end;

 Datamodule1.ZQryUtil.Close;
 Datamodule1.ZQryUtil.SQL.Text := 'select nama,ktpno,hpno,namatour,golongan,tglreg from member where id='+ vidmember;
 Datamodule1.ZQryUtil.Open;
 if Datamodule1.ZQryUtil.Fields[0].IsNull=false then edt_nama.Text := Datamodule1.ZQryUtil.Fields[0].AsString;
 if Datamodule1.ZQryUtil.Fields[1].IsNull=false then edt_ktpno.Text := Datamodule1.ZQryUtil.Fields[1].AsString;
 if Datamodule1.ZQryUtil.Fields[2].IsNull=false then edt_hpno.Text := Datamodule1.ZQryUtil.Fields[2].AsString;
 if Datamodule1.ZQryUtil.Fields[3].IsNull=false then edt_namatour.Text := Datamodule1.ZQryUtil.Fields[3].AsString;
 if Datamodule1.ZQryUtil.Fields[4].IsNull=false then edt_golongan.Text := Datamodule1.ZQryUtil.Fields[4].AsString;
 if Datamodule1.ZQryUtil.Fields[5].IsNull=false then edt_tglreg.Text := Formatdatetime('dd/mm/yyyy',Datamodule1.ZQryUtil.Fields[5].Asdatetime);
 Datamodule1.ZQryUtil.Close;

{ if (clb_nogroup.Items.Count>0) then
 begin
  for i:= 0 to clb_nogroup.items.count-1 do clb_nogroup.Checked[i]:=false;
  if Datamodule1.ZQryUtil.Active then Datamodule1.ZQryUtil.Close;
  Datamodule1.ZQryUtil.SQL.Clear;
  Datamodule1.ZQryUtil.SQL.Add('select a.IDselltourgroup from memberabsensi a left join member m on a.idmember=m.id ');
  Datamodule1.ZQryUtil.SQL.Add('where date(a.tgl)=CURRENT_DATE and m.cardno='+ bufstr);
  Datamodule1.ZQryUtil.Open;
  while not Datamodule1.ZQryUtil.Eof do
  begin
   clb_nogroup.Checked[clb_nogroup.Items.IndexOfObject(TObject(Datamodule1.ZQryUtil.Fields[0].AsInteger))]:=True;
   Datamodule1.ZQryUtil.Next;
  end;
  Datamodule1.ZQryUtil.Close;
 end;   }
end;

procedure Tfrmmemberabsensi.edt_cardnoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key=VK_RETURN then
 begin
  inputcardno(edt_cardno.Text);
 end;
end;

procedure Tfrmmemberabsensi.SellBtnDelClick(Sender: TObject);
begin
  FormShowfirst;
end;

procedure Tfrmmemberabsensi.clb_nogroupClick(Sender: TObject);
begin
 edt_cardno.SetFocus;
 edt_cardno.SelectAll;
end;

procedure Tfrmmemberabsensi.clb_nogroupKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 clb_nogroupClick(Sender);
end;

procedure Tfrmmemberabsensi.clb_nogroupKeyPress(Sender: TObject;
  var Key: Char);
begin
 clb_nogroupClick(Sender);
end;

procedure Tfrmmemberabsensi.clb_nogroupKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 clb_nogroupClick(Sender);
end;

procedure Tfrmmemberabsensi.CustBtnAddClick(Sender: TObject);
var S,vidmember : string;
    SelectedMenu : boolean;
    clbcount : integer;
begin
 SelectedMenu:=False;
 for clbcount:= 0 to clb_nogroup.Items.Count-1 do
  if clb_nogroup.Checked[clbcount] then
  begin
   SelectedMenu:=True;
   break;
  end;
 if not SelectedMenu then
 begin
  ErrorDialog('Pilih data No. Rombongan dahulu ....');
  edt_cardno.SetFocus;
  edt_cardno.SelectAll;
  exit;
 end;

 if trim(edt_cardno.Text)='' then
 begin
  ErrorDialog('Isi data No. Card Member dahulu ....');
  resetinfomember(true);
  exit;
 end;

 vidmember := getdata('id','member where cardno='+Quotedstr(trim(edt_cardno.Text)));
 if vidmember='' then
 begin
  ErrorDialog('No. Card ini belum terdaftar ....');
  resetinfomember(true);
  exit;
 end;

 if isdataexist('select IDselltourgroup from memberabsensi where idmember=' + vidmember + ' and date(tgl)=CURRENT_DATE') then
 begin
  ErrorDialog('Maaf Member No.Card ini sudah Absen untuk hari ini ....');
  resetinfomember(true);
  exit;
 end;

// Datamodule1.ZConnection1.ExecuteDirect('delete from memberabsensi where date(tgl)=CURRENT_DATE and idmember=' + vidmember);

 S := 'insert into memberabsensi (tgl,idmember,IDselltourgroup,IDuser) values (';
 for clbcount:= 0 to clb_nogroup.Items.Count-1 do
  if clb_nogroup.Checked[clbcount] then
  begin
   if rightstr(S,1)=')' then S := S + ',(';
   S := S + 'now(),'+ vidmember + ',' + inttostr(longint(clb_nogroup.Items.Objects[clbcount])) + ',' + inttostr(IDuserlogin) + ')';
  end;

 S := S + ';';
 if Datamodule1.ZConnection1.ExecuteDirect(S) then
 begin
  LogInfo(UserName,'Input Absensi Member No. Card '+edt_cardno.Text);
  InfoDialog('Berhasil Input Absensi Member No. Card '+edt_cardno.Text+' !');
 end
 else
 begin
  errorDialog('Gagal Input Absensi Member No. Card '+edt_cardno.Text+' !');
 end;

 FormShowfirst;
end;

procedure Tfrmmemberabsensi.btn_refreshClick(Sender: TObject);
begin
 clb_nogroup.Clear;

 DataModule1.ZQrySearch.Close;
 DataModule1.ZQrySearch.SQL.text := 'select nogroup, namatour, IDselltourgroup from selltourgroup where date(tgl)=CURRENT_DATE order by nogroup';
 DataModule1.ZQrySearch.Open;

 if DataModule1.ZQrySearch.IsEmpty then infodialog('No. Rombongan Kosong')
 else
 begin
  while not DataModule1.ZQrySearch.Eof do
  begin
   clb_nogroup.Items.AddObject(DataModule1.ZQrySearch.Fields[0].AsString+'   '+DataModule1.ZQrySearch.Fields[1].AsString,TObject(DataModule1.ZQrySearch.Fields[2].AsInteger));
   DataModule1.ZQrySearch.Next;
  end;
 end;

 DataModule1.ZQrySearch.Close;

 edt_cardno.SetFocus;
 edt_cardno.SelectAll;
end;

procedure Tfrmmemberabsensi.FormShow(Sender: TObject);
begin
 FormShowFirst;
end;

end.
