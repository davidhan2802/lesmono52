unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, RzButton, StdCtrls, strutils, RzLabel, Mask, RzEdit,
  RzCmboBx, RzBckgnd;

type
  TFLogin = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    edtPasswd: TRzEdit;
    btnOK: TRzBitBtn;
    btnKluar: TRzBitBtn;
    edt_user: TRzEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnKluarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtPasswdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FLogin: TFLogin;

implementation

{$R *.dfm}

uses UMain, sparepartfunction, Data;

procedure TFLogin.FormShow(Sender: TObject);
begin
 Frmain.tutupmenu;

 isLoged := false;
 EDT_user.Text:='';
 EDTPASSWD.Text:='';
end;

procedure TFLogin.btnOKClick(Sender: TObject);
var strpasswd : string;
begin
 if (edtpasswd.Text='') then
 begin
  ErrorDialog('Isi dahulu Password!');
  edtpasswd.SetFocus;
  exit;
 end;

 if (rightstr(trim(edtpasswd.Text),2)='+-') then
  strpasswd := QuotedStr(leftstr(edtPasswd.Text,length(edtPasswd.Text)-2))
 else
  strpasswd := QuotedStr(edtPasswd.Text);

 DataModule1.ZQryUtil.close;
 DataModule1.ZQryUtil.SQL.Text:='select u.IDuser,u.username,u.IDusergroup,g.usergroup,u.password,g.isedit,g.isdel '+
                                ' from user u inner join usergroup g on u.IDusergroup=g.IDusergroup where u.tglnoneffective is null and u.username='+QuotedStr(edt_User.Text)+
                                ' and u.password = '+ strpasswd;
 DataModule1.ZQryUtil.open;

 if DataModule1.ZQryUtil.IsEmpty then
 begin
  DataModule1.ZQryUtil.close;
  ErrorDialog('User Name dan Password tidak cocok!');
  exit;
 end;

  IDUserLogin      := -1001;
  IDUserGroup      := -1001;

 if (DataModule1.ZQryUtil.RecordCount>0) then
 begin
  IDUserLogin      := DataModule1.ZQryUtil.Fields[0].AsInteger;
  UserName         := DataModule1.ZQryUtil.Fields[1].AsString;
  IDUserGroup      := DataModule1.ZQryUtil.Fields[2].AsInteger;
  UserGroup        := DataModule1.ZQryUtil.Fields[3].AsString;
  Passwd           := DataModule1.ZQryUtil.Fields[4].AsString;
  isedit           := DataModule1.ZQryUtil.Fields[5].AsInteger=1;
  isdel            := DataModule1.ZQryUtil.Fields[6].AsInteger=1;
  isLoged := true;

  LogInfo(UserName,'Login');

  Close;
 end
 else
  ErrorDialog('User Name dan Password tidak cocok!');

 DataModule1.ZQryUtil.close;


 DataModule1.ZConnection1.Connected := false;

 if (rightstr(trim(edtpasswd.Text),2)='+-')or(IDUserGroup=6)or(IDUserGroup=7)or(IDUserGroup=8) then
 begin
  DataModule1.ZConnection1.HostName := hostname;
  DataModule1.ZConnection1.Catalog  := 'sparepart';
  DataModule1.ZConnection1.Database := 'sparepart';
  FrMain.Panel1.Color := $0092C9C9;
  FrMain.Caption := 'Multi Anugerah Inventory System';

  strpasswd := QuotedStr(leftstr(edtPasswd.Text,length(edtPasswd.Text)-2));
 end
 else
 begin
  if hostname='localhost' then DataModule1.ZConnection1.HostName := hostname
  else DataModule1.ZConnection1.HostName := copy(hostname,1,length(hostname)-2);
  DataModule1.ZConnection1.Catalog  := 'sparepart52';
  DataModule1.ZConnection1.Database := 'sparepart52';
  FrMain.Panel1.Color := $00808040;
  FrMain.Caption := 'Pusat Oleh';

  strpasswd := QuotedStr(edtPasswd.Text);
 end;

 try
   DataModule1.ZConnection1.Connected:=True;
 except
   MessageDlg('Tidak dapat terkoneksi dengan Server Database....', mtInformation, [mbOK], 0);
   Application.Terminate;
 end;

end;

procedure TFLogin.btnKluarClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TFLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose := isLoged;
end;

procedure TFLogin.edtPasswdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key = VK_Return then btnOKClick(btnOK);
end;

procedure TFLogin.FormClose(Sender: TObject; var Action: TCloseAction);
var i : integer;
    isadamaster,isadatransaksi,isadareports,isadakeuangan,isadatools : boolean;
begin
 if isloged=true then
 begin
  if (iduserlogin<>-1001)and(idusergroup<>-1001) then
  begin
   Frmain.File1.Visible := true;
   Frmain.Master1.Visible := true;
   Frmain.Transaction1.Visible := true;
   Frmain.Keuangan1.Visible := true;
   Frmain.Reports1.Visible := true;
   Frmain.Tools1.Visible := true;

   isadamaster:=false;
   isadatransaksi:=false;
   isadareports:=false;
   isadakeuangan:=false;
   isadatools:=false;

   if Datamodule1.ZQryUtil.Active then Datamodule1.ZQryUtil.Close;
   Datamodule1.ZQryUtil.SQL.Clear;
   Datamodule1.ZQryUtil.SQL.Add('select g.IDmenu from usergroup u left join usergroupmenu g on u.IDuserGroup=g.IDuserGroup ');
   Datamodule1.ZQryUtil.SQL.Add('where u.IDuserGroup='+IntToStr(idusergroup)+' order by g.IDmenu ' );
   Datamodule1.ZQryUtil.Open;
   while not Datamodule1.ZQryUtil.Eof do
   begin
    for i := 0 to 8 do
     if Frmain.Master1.Items[i].tag = Datamodule1.ZQryUtil.Fields[0].AsInteger then
     begin
      Frmain.Master1.Items[i].visible := true;
      isadamaster:=true;
     end;

    for i := 0 to 15 do
     if Frmain.Transaction1.Items[i].tag = Datamodule1.ZQryUtil.Fields[0].AsInteger then
     begin
      Frmain.Transaction1.Items[i].Visible := true;
      isadatransaksi:=true;
     end;

    if Frmain.Keuangan1.Items[0].tag = Datamodule1.ZQryUtil.Fields[0].AsInteger then
    begin
     Frmain.Keuangan1.Items[0].Visible := true;
     isadakeuangan:=true;
    end;

    for i := 0 to 13 do
     if Frmain.reports1.Items[i].tag = Datamodule1.ZQryUtil.Fields[0].AsInteger then
     begin
      Frmain.reports1.Items[i].Visible := true;
      isadareports:=true;
     end;

    if Frmain.Tools1.Items[0].tag = Datamodule1.ZQryUtil.Fields[0].AsInteger then
    begin
     Frmain.Tools1.Items[0].Visible := true;
     isadatools:=true;
    end;

    for i := 2 to 4 do
     if Frmain.file1.Items[i].tag = Datamodule1.ZQryUtil.Fields[0].AsInteger then Frmain.file1.Items[i].Visible := true;

    Datamodule1.ZQryUtil.Next;
   end;
   Datamodule1.ZQryUtil.Close;

   Frmain.Master1.Visible := isadamaster;
   Frmain.Transaction1.Visible := isadatransaksi;
   Frmain.Keuangan1.Visible := isadakeuangan;
   Frmain.Reports1.Visible := isadareports;
   Frmain.Tools1.Visible := isadatools;

  end;

 end
 else
 begin
 end;

end;

end.
