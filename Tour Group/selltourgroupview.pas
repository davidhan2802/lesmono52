unit selltourgroupview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadGrp, Grids, DBGrids, PDJDBGridex, StdCtrls, RzCmboBx, Mask,
  RzEdit, RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, strutils, frxclass, db,
  RzButton, RzRadChk;

type
  TFrmselltourgroupview = class(TForm)
    PanelSales: TRzPanel;
    RzPanel58: TRzPanel;
    RzLabel243: TRzLabel;
    RzGroupBox18: TRzGroupBox;
    RzLabel251: TRzLabel;
    RzLabel252: TRzLabel;
    SalesBtnSearch: TAdvSmoothButton;
    SalesTxtSearch: TRzEdit;
    SalesTxtSearchby: TRzComboBox;
    SalesBtnClear: TAdvSmoothButton;
    salesDBGrid: TPDJDBGridEx;
    RzLabel60: TRzLabel;
    SellTxtSearchFirst: TRzDateTimeEdit;
    Timer1: TTimer;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    salesDBGrid2: TPDJDBGridEx;
    RzGroupBox1: TRzGroupBox;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    SalesBtnSearch2: TAdvSmoothButton;
    SalesTxtSearch2: TRzEdit;
    SalesTxtSearchby2: TRzComboBox;
    SalesBtnClear2: TAdvSmoothButton;
    SellTxtSearchFirst2: TRzDateTimeEdit;
    procedure salesDBGridTitleClick(Column: TColumn);
    procedure SalesBtnSearchClick(Sender: TObject);
    procedure SalesBtnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure salesDBGridDblClick(Sender: TObject);
    procedure salesDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure salesDBGrid2DblClick(Sender: TObject);
    procedure salesDBGrid2DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure salesDBGrid2TitleClick(Column: TColumn);
    procedure SalesBtnSearch2Click(Sender: TObject);
    procedure SalesBtnClear2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isbusrental : boolean;
    procedure FormShowFirst;
  end;

var
  Frmselltourgroupview: TFrmselltourgroupview;
  ShowDetail : boolean;

implementation

uses selltourgroup, U_cetak, SparePartFunction, Data;

{$R *.dfm}

procedure TFrmselltourgroupview.FormShowFirst;
begin
 salesdbgrid.Columns[7].Visible := false;
 SellTxtSearchFirst.Date := tglskrg;
 SalesBtnClearClick(Self);

 salesdbgrid2.Columns[7].Visible := false;
 SellTxtSearchFirst2.Date := tglskrg;
 SalesBtnClear2Click(Self);

 Timer1.Enabled := true;
end;

procedure TFrmselltourgroupview.salesDBGridTitleClick(Column: TColumn);
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
      with DataModule1.ZQryselltourgroup do
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

procedure TFrmselltourgroupview.SalesBtnSearchClick(Sender: TObject);
var
  SearchCategories,vjnsbus: string;
begin
  if Trim(SalesTxtSearch.Text) = '' then Exit;
  case SalesTxtSearchby.ItemIndex of
  0 : SearchCategories := 'nogroup';
  1 : SearchCategories := 'namatour';
  end;

  vjnsbus:='g.jenisbus>0';

  with DataModule1.ZQryselltourgroup do
  begin
    Close;
    SQL.Strings[3] :=  'where '+ vjnsbus +' and g.tgl=' + Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date)) + ' and g.' + SearchCategories + ' like ''' + '%' + SalesTxtSearch.Text + '%' + '''';
    SQL.Strings[5] :=  'order by g.' + SearchCategories;
    open;
  end;


end;

procedure TFrmselltourgroupview.SalesBtnClearClick(Sender: TObject);
var vjnsbus: string;
begin
  vjnsbus:='g.jenisbus>0';
  with DataModule1.ZQryselltourgroup do
  begin
    Close;
    SQL.Strings[3] := 'where '+ vjnsbus +' and g.tgl=' + Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date)) + ' ';
    SQL.Strings[5] := 'order by g.nogroup';
    open;
  end;

  SalesTxtSearch.Text := '';

end;

procedure TFrmselltourgroupview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 DataModule1.ZQryselltourgroup.Close;
 DataModule1.ZQryselltourgroup2.Close;

 Timer1.Enabled := false;
end;

procedure TFrmselltourgroupview.salesDBGridDblClick(Sender: TObject);
var totrpshow : boolean;
begin
 totrpshow := salesdbgrid.Columns[7].Visible;
 salesdbgrid.Columns[7].Visible := not totrpshow;
end;

procedure TFrmselltourgroupview.salesDBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 if DataModule1.ZQryselltourgrouptotrp.value>0 then
    salesDBGrid.Canvas.Brush.Color:= $00D9D9FF
 else salesDBGrid.Canvas.Brush.Color:= clwindow;

 salesDBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFrmselltourgroupview.Timer1Timer(Sender: TObject);
var PosRecord : integer;
begin
 PosRecord := DataModule1.ZQryselltourgroup.RecNo;
 DataModule1.ZQryselltourgroup.Refresh;
 DataModule1.ZQryselltourgroup.RecNo := PosRecord;

 PosRecord := DataModule1.ZQryselltourgroup2.RecNo;
 DataModule1.ZQryselltourgroup2.Refresh;
 DataModule1.ZQryselltourgroup2.RecNo := PosRecord;

end;

procedure TFrmselltourgroupview.salesDBGrid2DblClick(Sender: TObject);
var totrpshow : boolean;
begin
 totrpshow := salesdbgrid2.Columns[7].Visible;
 salesdbgrid2.Columns[7].Visible := not totrpshow;
end;

procedure TFrmselltourgroupview.salesDBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 if DataModule1.ZQryselltourgroup2totrp.value>0 then
    salesDBGrid2.Canvas.Brush.Color:= $00D9D9FF
 else salesDBGrid2.Canvas.Brush.Color:= clwindow;

 salesDBGrid2.DefaultDrawColumnCell(Rect, DataCol, Column, State);


end;

procedure TFrmselltourgroupview.salesDBGrid2TitleClick(Column: TColumn);
var
  i: integer;
  s: string;
  sorted: string;
begin
  for i := 0 to SalesDBGrid2.Columns.Count - 1 do
  begin
    if (SalesDBGrid2.PDJDBGridExColumn[i].FieldName = Column.FieldName) then
    begin
      if SalesDBGrid2.PDJDBGridExColumn[i].SortArrow = saDown then
      begin
        SalesDBGrid2.PDJDBGridExColumn[i].SortArrow := saUp;
        s := 'order by ' + SalesDBGrid2.PDJDBGridExColumn[i].FieldName;
        sorted := '';
      end
      else
      begin
        SalesDBGrid2.PDJDBGridExColumn[i].SortArrow := saDown;
        s := 'order by ' + SalesDBGrid2.PDJDBGridExColumn[i].FieldName + ' desc';
        sorted := 'desc';
      end;
      with DataModule1.ZQryselltourgroup2 do
      begin
        Close;
        SQL.Strings[5] := s;
        Open;
      end;
      ConfigINI.Strings[33] := 'sort-by=' + SalesDBGrid2.PDJDBGridExColumn[i].FieldName;
      ConfigINI.Strings[34] := 'sort=' + sorted;
      ConfigINI.SaveToFile(ExtractFilePath(Application.ExeName) + 'config.ini');
    end
    else
      SalesDBGrid2.PDJDBGridExColumn[i].SortArrow := saNone;
  end;

end;

procedure TFrmselltourgroupview.SalesBtnSearch2Click(Sender: TObject);
var
  SearchCategories,vjnsbus: string;
begin
  if Trim(SalesTxtSearch2.Text) = '' then Exit;
  case SalesTxtSearchby2.ItemIndex of
  0 : SearchCategories := 'nogroup';
  1 : SearchCategories := 'namatour';
  end;

  vjnsbus:='g.jenisbus=0';

  with DataModule1.ZQryselltourgroup2 do
  begin
    Close;
    SQL.Strings[3] :=  'where '+ vjnsbus +' and g.tgl=' + Quotedstr(getmysqldatestr(SellTxtSearchFirst2.Date)) + ' and g.' + SearchCategories + ' like ''' + '%' + SalesTxtSearch2.Text + '%' + '''';
    SQL.Strings[5] :=  'order by g.' + SearchCategories;
    open;
  end;
end;

procedure TFrmselltourgroupview.SalesBtnClear2Click(Sender: TObject);
var vjnsbus: string;
begin
  vjnsbus:='g.jenisbus=0';
  with DataModule1.ZQryselltourgroup2 do
  begin
    Close;
    SQL.Strings[3] := 'where '+ vjnsbus +' and g.tgl=' + Quotedstr(getmysqldatestr(SellTxtSearchFirst2.Date)) + ' ';
    SQL.Strings[5] := 'order by g.nogroup';
    open;
  end;

  SalesTxtSearch2.Text := '';

end;

procedure TFrmselltourgroupview.FormShow(Sender: TObject);
begin
  Panelsales.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelsales.Color := $00808040;

end;

end.
