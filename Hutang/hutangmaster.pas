unit hutangmaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadGrp, RzEdit, StdCtrls, RzCmboBx, Mask, RzPanel,
  AdvSmoothButton, RzLabel, Grids, DBGrids, RzDBGrid, ExtCtrls, dateutils, frxclass;

type
  TFrmhutangmaster = class(TForm)
    PanelHutang: TRzPanel;
    HutangDBGrid: TRzDBGrid;
    RzPanel24: TRzPanel;
    RzLabel89: TRzLabel;
    RzPanel25: TRzPanel;
    RzLabel91: TRzLabel;
    RzLabel92: TRzLabel;
    RzLabel90: TRzLabel;
    HtgBtnPrint: TAdvSmoothButton;
    HtgBtnAdd: TAdvSmoothButton;
    HtgBtnDel: TAdvSmoothButton;
    RzGroupBox8: TRzGroupBox;
    RzLabel93: TRzLabel;
    RzLabel94: TRzLabel;
    RzLabel95: TRzLabel;
    RzLabel96: TRzLabel;
    RzLabel97: TRzLabel;
    RzLabel98: TRzLabel;
    HtgBtnSearch: TAdvSmoothButton;
    HtgTxtSearch: TRzEdit;
    HtgTxtSearchby: TRzComboBox;
    HtgBtnClear: TAdvSmoothButton;
    HtgTxtSearchFirst: TRzDateTimeEdit;
    HtgTxtSearchLast: TRzDateTimeEdit;
    RzPanel26: TRzPanel;
    RzLabel99: TRzLabel;
    HtgTxtTotal: TRzNumericEdit;
    HtgFilter: TRzRadioGroup;
    procedure HtgBtnAddClick(Sender: TObject);
    procedure HtgBtnDelClick(Sender: TObject);
    procedure HtgBtnPrintClick(Sender: TObject);
    procedure HtgBtnSearchClick(Sender: TObject);
    procedure HtgBtnClearClick(Sender: TObject);
    procedure HtgFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure PrintListHutang;
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmhutangmaster: TFrmhutangmaster;
  ShowDetail : boolean;

implementation

uses SparePartFunction, Data, frmHutang;

{$R *.dfm}

procedure TFrmhutangmaster.FormShowFirst;
begin
 ShowDetail := false;

 HtgBtnDel.Enabled := isdel;

 HtgTxtSearchFirst.Date := startofthemonth(TglSkrg);
 HtgTxtSearchLast.Date  := TglSkrg;

 HtgBtnClearClick(Self);

end;

procedure TFrmhutangmaster.HtgBtnAddClick(Sender: TObject);
begin
  if DataModule1.ZQryHutang.IsEmpty then Exit;
  if DataModule1.ZQryHutanglunas.Value = 1 then
  begin
    ErrorDialog('Faktur ' + DataModule1.ZQryHutangfaktur.Value + ' sudah lunas ');
    Exit;
  end;

  ShowDetail := true;
  TUTUPFORM(self.parent);
  IF frmHtg=nil then application.CreateForm(TfrmHtg,frmHtg);
  frmHtg.Align:=alclient;
  frmHtg.Parent:=self.parent;
  frmHtg.BorderStyle:=bsnone;

  with frmHtg do
  begin
    HtgTxtTgl.Date := TglSkrg;
    HtgTxtFaktur.Text := DataModule1.ZQryHutangfaktur.Value;
    HtgTxtNamaSupp.Text := DataModule1.ZQryHutangsupplier.Value;
    HtgTotal.Value := DataModule1.ZQryHutanggrandtotal.Value;
  end;

  frmHtg.Show;

//  RefreshTabel(DataModule1.ZQryHutang,'faktur',DataModule1.ZQryHutangfaktur.Value);

end;

procedure TFrmhutangmaster.HtgBtnDelClick(Sender: TObject);
begin
  if DataModule1.ZQryHutang.IsEmpty then Exit;
  if DataModule1.ZQryHutanglunas.Value = 0 then
  begin
    ErrorDialog('Faktur ' + DataModule1.ZQryHutangfaktur.Value + ' belum lunas');
    Exit;
  end;
  if QuestionDialog('Hapus Pelunasan ' + DataModule1.ZQryHutangfaktur.Value + ' ?') = True then
  begin
    frmHtg.DeleteData(DataModule1.ZQryHutangfaktur.Value);
  end;

end;

procedure TFrmhutangmaster.PrintListHutang;
var
  FrxMemo: TfrxMemoView;
  a: integer;
begin
  DataModule1.frxReport1.LoadFromFile(vpath+'Report\hutang.fr3');
{  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Judul'));
  FrxMemo.Memo.Text := HeaderTitleRep;  }
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));
  IF HtgFilter.ItemIndex=1 then
   FrxMemo.Memo.Text := 'DAFTAR HUTANG ('+HtgFilter.Items[HtgFilter.itemindex]+')'
  else FrxMemo.Memo.Text := 'DAFTAR HUTANG';

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglJual'));
  FrxMemo.Memo.Text := 'Tanggal ' + FormatDateTime('dd/MM/yyyy',HtgTxtSearchFirst.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',HtgTxtSearchLast.Date);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  DataModule1.frxReport1.ShowReport();
end;

procedure TFrmhutangmaster.HtgBtnPrintClick(Sender: TObject);
begin
  if DataModule1.ZQryHutang.IsEmpty then Exit;
  PrintListHutang;

end;

procedure TFrmhutangmaster.HtgBtnSearchClick(Sender: TObject);
var
  SearchCategories: string;
  Lunas: string;
begin
  if Trim(HtgTxtSearch.Text) = '' then Exit;
  case HtgTxtSearchby.ItemIndex of
  0 : SearchCategories := 'faktur';
  1 : SearchCategories := 'kategori';
  end;

  case HtgFilter.ItemIndex of
  0 : Lunas := 'and lunas = 0';
  1 : Lunas := 'and lunas = 1';
  end;

  with DataModule1.ZQryHutang do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select *,(grandtotal-totalpayment) hutang,concat("[",kodesupplier,"] ",supplier) kodenmsupp from buymaster');
    SQL.Add('where ' + SearchCategories + ' like ''' + HtgTxtSearch.Text + '%' + '''');
    SQL.Add('and tanggal >= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchFirst.Date) + '''');
    SQL.Add('and tanggal <= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchLast.Date) + '''');
    SQL.Add('and pembayaran <> ''' + 'CASH' + '''');
    SQL.Add(Lunas);
    Open;
  end;

  ///cari total nilai jual
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select sum(grandtotal) from buymaster');
    SQL.Add('where ' + SearchCategories + ' like ''' + HtgTxtSearch.Text + '%' + '''');
    SQL.Add('and tanggal >= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchFirst.Date) + '''');
    SQL.Add('and tanggal <= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchLast.Date) + '''');
    SQL.Add('and pembayaran <> ''' + 'CASH' + '''');
    SQL.Add(Lunas);
    Open;
    HtgTxtTotal.Value := Fields[0].AsFloat;
  end;
end;

procedure TFrmhutangmaster.HtgBtnClearClick(Sender: TObject);
var
  Lunas: string;
begin
  case HtgFilter.ItemIndex of
  0 : Lunas := 'and lunas = 0';
  1 : Lunas := 'and lunas = 1';
  end;
  with DataModule1.ZQryHutang do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select *,(grandtotal-totalpayment) hutang,concat("[",kodesupplier,"] ",supplier) kodenmsupp from buymaster');
    SQL.Add('where tanggal >= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchFirst.Date) + '''');
    SQL.Add('and tanggal <= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchLast.Date) + '''');
    SQL.Add('and pembayaran <> ''' + 'CASH' + '''');
    SQL.Add(Lunas);
    Open;
  end;
  HtgTxtSearch.Text := '';

  ///Cari Total Nilai Jual
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select sum(grandtotal) from buymaster');
    SQL.Add('where tanggal >= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchFirst.Date) + '''');
    SQL.Add('and tanggal <= ''' + FormatDateTime('yyyy-MM-dd',HtgTxtSearchLast.Date) + '''');
    SQL.Add('and pembayaran <> ''' + 'CASH' + '''');
    SQL.Add(Lunas);
    Open;
    HtgTxtTotal.Value := Fields[0].AsFloat;
  end;
end;

procedure TFrmhutangmaster.HtgFilterClick(Sender: TObject);
begin
  if HtgTxtSearch.Text = '' then
    HtgBtnClearClick(Self)
  else
    HtgBtnSearchClick(Self);

end;

procedure TFrmhutangmaster.FormShow(Sender: TObject);
begin
  Panelhutang.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelhutang.Color := $00808040;

end;

end.
