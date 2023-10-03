unit adjustlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, PDJDBGridex, RzEdit, StdCtrls, RzCmboBx, Mask,
  RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, frxClass;

type
  TFrmadjustlist = class(TForm)
    PanelPenjualan: TRzPanel;
    RzPanel11: TRzPanel;
    RzLabel39: TRzLabel;
    RzGroupBox4: TRzGroupBox;
    RzLabel44: TRzLabel;
    RzLabel45: TRzLabel;
    RzLabel46: TRzLabel;
    RzLabel47: TRzLabel;
    RzLabel60: TRzLabel;
    SellLblDateLast: TRzLabel;
    SellBtnSearch: TAdvSmoothButton;
    SellTxtSearch: TRzEdit;
    SellTxtSearchby: TRzComboBox;
    SellBtnClear: TAdvSmoothButton;
    SellTxtSearchFirst: TRzDateTimeEdit;
    SellTxtSearchLast: TRzDateTimeEdit;
    pnl_cetak_list: TRzPanel;
    RzLabel43: TRzLabel;
    SellBtnPrintList: TAdvSmoothButton;
    RzPanel1: TRzPanel;
    DBMaster: TPDJDBGridEx;
    DBGdet: TPDJDBGridEx;
    procedure SellBtnPrintListClick(Sender: TObject);
    procedure SellBtnSearchClick(Sender: TObject);
    procedure SellBtnClearClick(Sender: TObject);
    procedure DBMasterDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SellTxtSearchbyChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure PrintListadjust;
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmadjustlist: TFrmadjustlist;
  SearchCategories: string;

implementation

uses SparePartFunction, data, frmAdjust;

{$R *.dfm}

procedure TFrmadjustlist.FormShowFirst;
begin
 SellTxtSearchFirst.Date := TglSkrg;
 SellTxtSearchLast.Date  := TglSkrg;

 SellBtnClearClick(Self);
end;

procedure TFrmadjustlist.PrintListadjust;
var
  FrxMemo: TfrxMemoView;
begin
  Datamodule1.frxReport1.LoadFromFile(vpath+'Report\adjustlist.fr3');

  FrxMemo := TfrxMemoView(Datamodule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  FrxMemo := TfrxMemoView(Datamodule1.frxReport1.FindObject('docno'));
  FrxMemo.Memo.Text := Datamodule1.ZQryadjustlistfaktur.AsString;

  FrxMemo := TfrxMemoView(Datamodule1.frxReport1.FindObject('tanggal'));
  FrxMemo.Memo.Text := FormatDateTime('dd-MM-yyyy',Datamodule1.ZQryadjustlisttanggal.Asdatetime);

  FrxMemo := TfrxMemoView(Datamodule1.frxReport1.FindObject('operator'));
  FrxMemo.Memo.Text := Datamodule1.ZQryadjustlistoperator.AsString;

  Datamodule1.frxReport1.ShowReport();

end;

procedure TFrmadjustlist.SellBtnPrintListClick(Sender: TObject);
begin
  if Datamodule1.ZQryadjustlist.IsEmpty then Exit;
  PrintListadjust;

end;

procedure TFrmadjustlist.SellBtnSearchClick(Sender: TObject);
//var
//  SearchCategories: string;
begin
  if (Trim(SellTxtSearch.Text) = '')and(SellTxtSearchby.ItemIndex>=0) then Exit;
  case SellTxtSearchby.ItemIndex of
  0 : SearchCategories := 'faktur like ''' + SellTxtSearch.Text + '%' + ''' ';
  1 : SearchCategories := 'operator like ''' + SellTxtSearch.Text + '%' + ''' ';
  end;

  with Datamodule1.ZQryadjustlist do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select *,case when kodegudang="SL" then "GUDANG" when kodegudang="SLT" then "TOKO" when kodegudang="SLR" then "RUSAK" end nmgdg from adjustmaster ');
    SQL.Add('where ' + SearchCategories );
    SQL.Add('and isposted<>-1 ');
    SQL.Add('and tanggal between ' + Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date)) + ' ');
    SQL.Add('and ' + Quotedstr(getmysqldatestr(SellTxtSearchLast.Date)) );
    SQL.Add('order by tanggal,faktur ');
    Open;
    Last;
  end;

  Datamodule1.ZQryadjustlistdet.Close;
  Datamodule1.ZQryadjustlistdet.Open;

  SellBtnPrintList.Enabled := true;
end;

procedure TFrmadjustlist.SellBtnClearClick(Sender: TObject);
begin
  with Datamodule1.ZQryadjustlist do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select *,case when kodegudang="SL" then "GUDANG" when kodegudang="SLT" then "TOKO" when kodegudang="SLR" then "RUSAK" end nmgdg from adjustmaster ');
    SQL.Add('where isposted<>-1 ');
    SQL.Add('and tanggal between ' + Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date)) + ' ');
    SQL.Add('and ' + Quotedstr(getmysqldatestr(SellTxtSearchLast.Date)) );
    SQL.Add('order by tanggal,faktur ');
    Open;
    Last;
  end;

  Datamodule1.ZQryadjustlistdet.Close;
  Datamodule1.ZQryadjustlistdet.Open;

  SellTxtSearchBy.ItemIndex  :=  0;
//  SellTxtSearchBychange(sender);
  SellTxtSearch.Text := '';

  SellBtnPrintList.Enabled := true;

end;

procedure TFrmadjustlist.DBMasterDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if Datamodule1.ZQryadjustlistisposted.Value=1 then
    DBMaster.Canvas.Brush.Color := $00A8FFA8
  else
    DBMaster.Canvas.Brush.Color := clWindow;
  DBMaster.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFrmadjustlist.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Datamodule1.ZQryadjustlistdet.Close;
 Datamodule1.ZQryadjustlist.Close;

end;

procedure TFrmadjustlist.SellTxtSearchbyChange(Sender: TObject);
begin
  SellBtnPrintList.Enabled := false;

end;

procedure TFrmadjustlist.FormShow(Sender: TObject);
begin
  PanelPenjualan.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      PanelPenjualan.Color := $00808040;

// FormShowFirst;
end;

end.
