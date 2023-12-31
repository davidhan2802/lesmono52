unit suppliermaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadGrp, Grids, DBGrids, PDJDBGridex, StdCtrls, RzCmboBx, Mask,
  RzEdit, RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, frxClass, jpeg,
  frxpngimage;

type
  TFrmsuppliermaster = class(TForm)
    PanelCustomer: TRzPanel;
    RzPanel9: TRzPanel;
    RzLabel21: TRzLabel;
    RzPanel10: TRzPanel;
    RzLabel31: TRzLabel;
    RzLabel32: TRzLabel;
    RzLabel33: TRzLabel;
    CustBtnAdd: TAdvSmoothButton;
    CustBtnEdit: TAdvSmoothButton;
    CustBtnDel: TAdvSmoothButton;
    RzGroupBox3: TRzGroupBox;
    RzLabel35: TRzLabel;
    RzLabel36: TRzLabel;
    RzLabel37: TRzLabel;
    RzLabel38: TRzLabel;
    CustBtnSearch: TAdvSmoothButton;
    CustTxtSearch: TRzEdit;
    CustTxtSearchby: TRzComboBox;
    CustBtnClear: TAdvSmoothButton;
    CustDBGrid: TPDJDBGridEx;
    CustFilter: TRzRadioGroup;
    pnl_cetak: TRzPanel;
    CustBtnPrint: TAdvSmoothButton;
    RzLabel34: TRzLabel;
    procedure CustBtnSearchClick(Sender: TObject);
    procedure CustBtnClearClick(Sender: TObject);
    procedure CustBtnPrintClick(Sender: TObject);
    procedure CustDBGridTitleClick(Column: TColumn);
    procedure CustBtnAddClick(Sender: TObject);
    procedure CustBtnEditClick(Sender: TObject);
    procedure CustBtnDelClick(Sender: TObject);
    procedure CustFilterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure PrintListSupplier;
    procedure DeleteData(Data: string);
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmsuppliermaster: TFrmsuppliermaster;
  ShowDetail : boolean;

implementation

uses SparePartFunction, Data, frmSupplier;

{$R *.dfm}

procedure TFrmsuppliermaster.FormShowFirst;
begin
  ShowDetail := false;

 CustBtnEdit.Enabled := isedit;
 CustBtnDel.Enabled  := isdel;

  CustBtnClearClick(Self);
end;

procedure TFrmsuppliermaster.CustBtnSearchClick(Sender: TObject);
var
  SearchCategories: string;
begin
  if Trim(CustTxtSearch.Text) = '' then Exit;

  case CustTxtSearchby.ItemIndex of
  0 : SearchCategories := 'kode';
  1 : SearchCategories := 'nama';
  2 : SearchCategories := 'Alamat';
  3 : SearchCategories := 'Kota';
  end;

  with DataModule1.ZQrySupplier do
  begin
    Close;
    SQL.Strings[1] := 'where ' + SearchCategories + ' like ' + QuotedStr(CustTxtSearch.Text + '%') ;
  end;
  CustFilterClick(Self);
end;

procedure TFrmsuppliermaster.CustBtnClearClick(Sender: TObject);
begin

  with DataModule1.ZQrySupplier do
  begin
    Close;
    SQL.Strings[1] := '';
//    Open;
  end;
  CustFilterClick(Self);
  CustTxtSearch.Text := '';

end;

procedure TFrmsuppliermaster.PrintListSupplier;
var
  FrxMemo: TfrxMemoView;
begin
  DataModule1.frxReport1.LoadFromFile(vpath+'Report\supplier.fr3');
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Dicetak ' + FormatDateTime('dd-mm-yyyy hh:nn:ss',Now) + ' oleh ' + UserName;
  DataModule1.frxReport1.ShowReport();
end;

procedure TFrmsuppliermaster.CustBtnPrintClick(Sender: TObject);
begin
  if DataModule1.ZQrySupplier.IsEmpty then Exit;
  PrintListSupplier;

end;

procedure TFrmsuppliermaster.CustDBGridTitleClick(Column: TColumn);
var
  i: integer;
  s: string;
  sorted: string;
begin
  for i := 1 to CustDBGrid.Columns.Count - 1 do
  begin
    if (CustDBGrid.PDJDBGridExColumn[i].FieldName = Column.FieldName) then
    begin
      if CustDBGrid.PDJDBGridExColumn[i].SortArrow = saDown then
      begin
        CustDBGrid.PDJDBGridExColumn[i].SortArrow := saUp;
        s := 'order by ' + CustDBGrid.PDJDBGridExColumn[i].FieldName;
        sorted := '';
      end
      else
      begin
        CustDBGrid.PDJDBGridExColumn[i].SortArrow := saDown;
        s := 'order by ' + CustDBGrid.PDJDBGridExColumn[i].FieldName + ' desc';
        sorted := 'desc';
      end;
      with DataModule1.ZQrySupplier do
      begin
        Close;
        SQL.Strings[3] := s;
        Open;
      end;
      ConfigINI.Strings[17] := 'sort-by=' + CustDBGrid.PDJDBGridExColumn[i].FieldName;
      ConfigINI.Strings[18] := 'sort=' + sorted;
      ConfigINI.SaveToFile(ExtractFilePath(Application.ExeName) + 'config.ini');
    end
    else
      CustDBGrid.PDJDBGridExColumn[i].SortArrow := saNone;
  end;
end;

procedure TFrmsuppliermaster.CustBtnAddClick(Sender: TObject);
begin
 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF frmSupp=nil then
 application.CreateForm(TfrmSupp,frmSupp);
 frmSupp.Align:=alclient;
 frmSupp.Parent:=self.parent;
 frmSupp.BorderStyle:=bsnone;
 frmSupp.CustLblCaption.Caption := 'Tambah Supplier';
 frmSupp.FormShowFirst;
 frmSupp.Show;

end;

procedure TFrmsuppliermaster.CustBtnEditClick(Sender: TObject);
begin
 if DataModule1.ZQrySupplier.IsEmpty then Exit;

 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF frmSupp=nil then
 application.CreateForm(TfrmSupp,frmSupp);
 frmSupp.Align:=alclient;
 frmSupp.Parent:=self.parent;
 frmSupp.BorderStyle:=bsnone;
 frmSupp.CustLblCaption.Caption := 'Edit Supplier';
 frmSupp.FormShowFirst;
 frmSupp.Show;

end;

procedure TFrmsuppliermaster.DeleteData(Data: String);
var
  Nama: string;
  PosRecord: integer;
begin
  Nama := Data;
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Delete from supplier');
    SQL.Add('where kode = ' + QuotedStr(Nama));
    ExecSQL;
  end;

 // if (DataModule1.ZConnection1.Catalog='sparepart') then
 //     DataModule1.ZConn2.ExecuteDirect(DataModule1.ZQryFunction.SQL.Text);

  PosRecord := DataModule1.ZQrySupplier.RecNo;
  DataModule1.ZQrySupplier.Close;
  DataModule1.ZQrySupplier.Open;
  DataModule1.ZQrySupplier.RecNo := PosRecord;

  LogInfo(UserName,'Menghapus Supplier ' + Nama);

  InfoDialog('Supplier ' + Nama + ' berhasil dihapus !');
end;

procedure TFrmsuppliermaster.CustBtnDelClick(Sender: TObject);
begin
  if DataModule1.ZQrySupplier.IsEmpty then Exit;
  ///Cek Tabel Pembelian
  with DataModule1.ZQrySearch do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select kodesupplier from buymaster');
    SQL.Add('where kodesupplier = ' + QuotedStr(DataModule1.ZQrySupplierkode.Value) + ' ');
    SQL.Add('or supplier = ' + QuotedStr(DataModule1.ZQrySuppliernama.Value) );
    Open;
    if not IsEmpty then
    begin
      ErrorDialog('Data Supplier tidak bisa dihapus ' + #13+#10 + 'karena masih ada transaksi pembelian');
      Exit;
    end;
  end;
  if QuestionDialog('Hapus Supplier ' + DataModule1.ZQrySuppliernama.Value + ' ?') = True then
  begin
    DeleteData(DataModule1.ZQrySupplierkode.Value);
  end;

end;

procedure TFrmsuppliermaster.CustFilterClick(Sender: TObject);
var
  s, con: string;
begin
  case CustFilter.ItemIndex of
  0 : s := 'tglnoneffective is null';
  1 : s := 'tglnoneffective is not null';
  end;
  with DataModule1.ZQrySupplier do
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

procedure TFrmsuppliermaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if ShowDetail=false then DataModule1.ZQrySupplier.Close;

end;

procedure TFrmsuppliermaster.FormShow(Sender: TObject);
begin
  Panelcustomer.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelcustomer.Color := $00808040;

end;

end.
