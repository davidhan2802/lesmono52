unit salesmaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadGrp, Grids, DBGrids, PDJDBGridex, StdCtrls, RzCmboBx, Mask,
  RzEdit, RzPanel, AdvSmoothButton, RzLabel, ExtCtrls;

type
  TFrmsalesmaster = class(TForm)
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
    salesFilter: TRzRadioGroup;
    procedure salesDBGridTitleClick(Column: TColumn);
    procedure salesFilterClick(Sender: TObject);
    procedure SalesBtnAddClick(Sender: TObject);
    procedure SalesBtnEditClick(Sender: TObject);
    procedure SalesBtnDelClick(Sender: TObject);
    procedure SalesBtnSearchClick(Sender: TObject);
    procedure SalesBtnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure DeleteData(Data: string);
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmsalesmaster: TFrmsalesmaster;
  ShowDetail : boolean;

implementation

uses frmSalesPerson, SparePartFunction, Data;

{$R *.dfm}

procedure TFrmsalesmaster.FormShowFirst;
begin
 ShowDetail := false;

 SalesBtnEdit.Enabled := isedit;
 SalesBtnDel.Enabled  := isdel;

 SalesBtnClearClick(Self);
end;

procedure TFrmsalesmaster.salesDBGridTitleClick(Column: TColumn);
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
      with DataModule1.ZQrySales do
      begin
        Close;
        SQL.Strings[3] := s;
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

procedure TFrmsalesmaster.salesFilterClick(Sender: TObject);
var
  s, con: string;
begin
  case SalesFilter.ItemIndex of
{  0 : s := '(tglnoneffective is null) or (tglnoneffective > ''' + FormatDateTime('yyyy-MM-dd',Now) + ''')';
  1 : s := 'tglnoneffective <= ''' + FormatDateTime('yyyy-MM-dd',Now) + ''''; }
   0 : s := 'tglnoneffective is null';
   1 : s := 'tglnoneffective is not null';
  end;
  with DataModule1.ZQrySales do
  begin
    Close;
    if SQL.Strings[1] = '' then
      con := 'where '
    else
      con := 'and ';
    SQL.Strings[2] := con + s;
    Open;
  end;

end;

procedure TFrmsalesmaster.SalesBtnAddClick(Sender: TObject);
begin
 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF Frmsales=nil then
 application.CreateForm(TFrmsales,Frmsales);
 Frmsales.Align:=alclient;
 Frmsales.Parent:=self.parent;
 Frmsales.BorderStyle:=bsnone;
 frmsales.LblCaption.Caption := 'Tambah Sales';
 Frmsales.FormShowFirst;
 Frmsales.Show;

end;

procedure TFrmsalesmaster.SalesBtnEditClick(Sender: TObject);
begin
  if DataModule1.ZQrySales.IsEmpty then Exit;

 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF Frmsales=nil then
 application.CreateForm(TFrmsales,Frmsales);
 Frmsales.Align:=alclient;
 Frmsales.Parent:=self.parent;
 Frmsales.BorderStyle:=bsnone;
 frmsales.LblCaption.Caption := 'Edit Sales';
 Frmsales.FormShowFirst;
 Frmsales.Show;

end;

procedure TFrmsalesmaster.DeleteData(Data: string);
var
  Nama: string;
  PosRecord: integer;
begin
  Nama := Data;
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Delete from Sales');
    SQL.Add('where kode = ' + QuotedStr(Nama) );
    ExecSQL;
  end;

//  if (DataModule1.ZConnection1.Catalog='sparepart') then
//      DataModule1.ZConn2.ExecuteDirect(DataModule1.ZQryFunction.SQL.Text);

  PosRecord := DataModule1.ZQrySales.RecNo;
  DataModule1.ZQrySales.Close;
  DataModule1.ZQrySales.Open;
  DataModule1.ZQrySales.RecNo := PosRecord;
  LogInfo(UserName,'Menghapus Sales ' + Nama);
  InfoDialog('Sales ' + Nama + ' berhasil dihapus !');
end;

procedure TFrmsalesmaster.SalesBtnDelClick(Sender: TObject);
begin
  if DataModule1.ZQrySales.IsEmpty then Exit;

  if QuestionDialog('Hapus Sales ' + DataModule1.ZQrySalesnama.Value + ' ?') = True then
  begin
    DeleteData(DataModule1.ZQrySaleskode.Text);
  end;

end;

procedure TFrmsalesmaster.SalesBtnSearchClick(Sender: TObject);
var
  SearchCategories: string;
begin
  if Trim(SalesTxtSearch.Text) = '' then Exit;
  case SalesTxtSearchby.ItemIndex of
  0 : SearchCategories := 'kode';
  1 : SearchCategories := 'nama';
  end;

  with DataModule1.ZQrySales do
  begin
    Close;
    SQL.Strings[1] :=  'where ' + SearchCategories + ' like ''' + '%' + SalesTxtSearch.Text + '%' + '''';
  end;
  SalesFilterClick(Self);

end;

procedure TFrmsalesmaster.SalesBtnClearClick(Sender: TObject);
begin
  with DataModule1.ZQrySales do
  begin
    Close;
    SQL.Strings[1] := '';
  end;
  SalesFilterClick(Self);
  SalesTxtSearch.Text := '';

end;

procedure TFrmsalesmaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if ShowDetail=false then DataModule1.ZQrySales.Close;

end;

procedure TFrmsalesmaster.FormShow(Sender: TObject);
begin
  Panelsales.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelsales.Color := $00808040;

end;

end.
