unit membermaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadGrp, Grids, DBGrids, PDJDBGridex, StdCtrls, RzCmboBx, Mask,
  RzEdit, RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, strutils, frxclass, db,
  RzButton, RzRadChk;

type
  TFrmmembermaster = class(TForm)
    PanelSales: TRzPanel;
    RzPanel58: TRzPanel;
    RzLabel243: TRzLabel;
    RzPanel60: TRzPanel;
    RzLabel246: TRzLabel;
    RzLabel247: TRzLabel;
    RzLabel248: TRzLabel;
    SalesBtnAdd: TAdvSmoothButton;
    SalesBtnEdit: TAdvSmoothButton;
    SalesBtnDel: TAdvSmoothButton;
    RzGroupBox18: TRzGroupBox;
    RzLabel250: TRzLabel;
    RzLabel251: TRzLabel;
    RzLabel252: TRzLabel;
    RzLabel253: TRzLabel;
    SalesBtnSearch: TAdvSmoothButton;
    SalesTxtSearch: TRzEdit;
    SalesTxtSearchby: TRzComboBox;
    SalesBtnClear: TAdvSmoothButton;
    salesDBGrid: TPDJDBGridEx;
    btnprint: TAdvSmoothButton;
    lblbiro: TRzLabel;
    procedure salesDBGridTitleClick(Column: TColumn);
    procedure SalesBtnAddClick(Sender: TObject);
    procedure SalesBtnEditClick(Sender: TObject);
    procedure SalesBtnDelClick(Sender: TObject);
    procedure SalesBtnSearchClick(Sender: TObject);
    procedure SalesBtnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnprintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmmembermaster: TFrmmembermaster;
  ShowDetail : boolean;

implementation

uses SparePartFunction, Data, member;

{$R *.dfm}

procedure TFrmmembermaster.FormShowFirst;
begin
 readandexecutesql_from_remotemysql;
 
 ShowDetail := false;

 SalesBtnEdit.Enabled := isedit;
 SalesBtnDel.Enabled  := isdel;

 SalesBtnClearClick(Self);
end;

procedure TFrmmembermaster.salesDBGridTitleClick(Column: TColumn);
var
  i: integer;
  s: string;
  sorted: string;
begin
  for i := 0 to SalesDBGrid.Columns.Count - 1 do
  begin
    if (SalesDBGrid.PDJDBGridExColumn[i].FieldName = Column.FieldName) then
    begin
      if SalesDBGrid.PDJDBGridExColumn[i].SortArrow = saDown then
      begin
        SalesDBGrid.PDJDBGridExColumn[i].SortArrow := saUp;
        s := 'order by ' + SalesDBGrid.PDJDBGridExColumn[i].FieldName;
        sorted := '';
      end
      else
      begin
        SalesDBGrid.PDJDBGridExColumn[i].SortArrow := saDown;
        s := 'order by ' + SalesDBGrid.PDJDBGridExColumn[i].FieldName + ' desc';
        sorted := 'desc';
      end;
      with DataModule1.ZQrymember do
      begin
        Close;
        SQL.Strings[5] := s;
        Open;
      end;
      ConfigINI.Strings[33] := 'sort-by=' + SalesDBGrid.PDJDBGridExColumn[i].FieldName;
      ConfigINI.Strings[34] := 'sort=' + sorted;
      ConfigINI.SaveToFile(ExtractFilePath(Application.ExeName) + 'config.ini');
    end
    else
      SalesDBGrid.PDJDBGridExColumn[i].SortArrow := saNone;
  end;
end;

procedure TFrmmembermaster.SalesBtnAddClick(Sender: TObject);
begin
 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF Frmmember=nil then
 application.CreateForm(TFrmmember,Frmmember);
 Frmmember.Align:=alclient;
 Frmmember.Parent:=self.parent;
 Frmmember.BorderStyle:=bsnone;
 frmmember.LblCaption.Caption := 'Tambah Member';
 Frmmember.FormShowFirst;
 Frmmember.Show;

end;

procedure TFrmmembermaster.SalesBtnEditClick(Sender: TObject);
begin
  if (DataModule1.ZQrymember.IsEmpty) then Exit;

  if (lokasigudang<>DataModule1.ZQrymemberlokasi.Value) then
  begin
   errordialog('Maaf, hanya ' + DataModule1.ZQrymemberlokasi.Value + ' yang boleh edit ini!');
  end;

 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF Frmmember=nil then
 application.CreateForm(TFrmmember,Frmmember);
 Frmmember.Align:=alclient;
 Frmmember.Parent:=self.parent;
 Frmmember.BorderStyle:=bsnone;
 frmmember.LblCaption.Caption := 'Edit Member';
 Frmmember.FormShowFirst;
 Frmmember.Show;

end;

procedure TFrmmembermaster.SalesBtnDelClick(Sender: TObject);
var Posrecord : integer;
    vsqlfromme : string;
begin
  if DataModule1.ZQrymember.IsEmpty then Exit;

  if (lokasigudang<>DataModule1.ZQrymemberlokasi.Value) then
  begin
   errordialog('Maaf, hanya ' + DataModule1.ZQrymemberlokasi.Value + ' yang boleh hapus ini!');
  end;

  if QuestionDialog('Hapus Member ' + DataModule1.ZQrymembernama.Value + ' ?') = True then
  begin
   readandexecutesql_from_remotemysql;
   vsqlfromme := 'delete from member where cardno='+ Quotedstr(DataModule1.ZQrymembercardno.AsString) + ';';
   if DataModule1.ZConnection1.ExecuteDirect(vsqlfromme) then
   begin
    write_and_sendsql_to_remotemysql('('+Quotedstr(vsqlfromme)+');');
    LogInfo(UserName,'Menghapus Member ' + DataModule1.ZQrymembernama.Value);
    InfoDialog('Member ' + DataModule1.ZQrymembernama.Value + ' berhasil dihapus !');
   end;

   PosRecord := DataModule1.ZQrymember.RecNo;
   DataModule1.ZQrymember.Close;
   DataModule1.ZQrymember.Open;
   DataModule1.ZQrymember.RecNo := PosRecord;
  end;

end;

procedure TFrmmembermaster.SalesBtnSearchClick(Sender: TObject);
var
  SearchCategories: string;
begin
  if Trim(SalesTxtSearch.Text) = '' then Exit;
  case SalesTxtSearchby.ItemIndex of
  0 : SearchCategories := 'cardno';
  1 : SearchCategories := 'nama';
  2 : SearchCategories := 'ktpno';
  3 : SearchCategories := 'hpno';
  4 : SearchCategories := 'golongan';
  end;

  with DataModule1.ZQrymember do
  begin
    Close;
    SQL.Strings[3] :=  'where tglnoneffective is null and ' + SearchCategories + ' like ''' + '%' + SalesTxtSearch.Text + '%' + '''';
    SQL.Strings[5] :=  'order by ' + SearchCategories;
    open;
  end;


end;

procedure TFrmmembermaster.SalesBtnClearClick(Sender: TObject);
begin
  with DataModule1.ZQrymember do
  begin
    Close;
    SQL.Strings[3] := 'where tglnoneffective is null ';
    SQL.Strings[5] := 'order by cardno';
    open;
  end;

  SalesTxtSearch.Text := '';

end;

procedure TFrmmembermaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if ShowDetail=false then DataModule1.ZQrymember.Close;

end;

procedure TFrmmembermaster.FormShow(Sender: TObject);
begin
  Panelsales.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelsales.Color := $00808040;

end;

procedure TFrmmembermaster.btnprintClick(Sender: TObject);
var FrxMemo: TfrxMemoView;
begin
 readandexecutesql_from_remotemysql;
 DataModule1.ZQrymember.Refresh;

 if DataModule1.ZQrymember.IsEmpty then Exit;

 Datamodule1.frxReport1.LoadFromFile(vpath+'Report\memberlist.fr3');

 FrxMemo := TfrxMemoView(Datamodule1.frxReport1.FindObject('titlejual'));
 FrxMemo.Memo.Text := 'LIST MEMBER';

 FrxMemo := TfrxMemoView(Datamodule1.frxReport1.FindObject('FooterCaption'));
 FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

 Datamodule1.frxReport1.ShowReport();

end;

end.
