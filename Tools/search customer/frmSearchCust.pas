unit frmSearchCust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, RzEdit, Grids, DBGrids, RzDBGrid, StdCtrls,
  Mask, AdvSmoothButton, RzCmboBx, RzLabel, RzStatus, ExtCtrls, RzPanel, Db;

type
  TfrmSrcCust = class(TForm)
    PanelProd: TRzPanel;
    RzPanel2: TRzPanel;
    SellLblCaption: TRzLabel;
    SearchDBGrid: TRzDBGrid;
    RzGroupBox4: TRzGroupBox;
    RzLabel44: TRzLabel;
    RzLabel45: TRzLabel;
    RzLabel46: TRzLabel;
    RzLabel47: TRzLabel;
    SearchBtnSearch: TAdvSmoothButton;
    SearchTxtSearch: TRzEdit;
    SearchTxtSearchBy: TRzComboBox;
    SearchBtnClear: TAdvSmoothButton;
    RzPanel7: TRzPanel;
    SearchBtnAdd: TAdvSmoothButton;
    RzLabel12: TRzLabel;
    SearchBtnClose: TAdvSmoothButton;
    RzLabel14: TRzLabel;
    procedure SearchBtnSearchClick(Sender: TObject);
    procedure SearchBtnClearClick(Sender: TObject);
    procedure SearchBtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SearchDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchDBGridDblClick(Sender: TObject);
    procedure SearchTxtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchTxtSearchByChange(Sender: TObject);
    procedure SearchTxtSearchChange(Sender: TObject);
    procedure SearchBtnAddClick(Sender: TObject);
  private
    SearchCategories: string;
    { Private declarations }
  public
    formSender : TForm;
    { Public declarations }
  end;

var
  frmSrcCust: TfrmSrcCust;
  tampsearchtxt: string;

implementation

uses SparePartFunction, frmselling, Data;

{$R *.dfm}


procedure TfrmSrcCust.FormShow(Sender: TObject);
begin
  tampsearchtxt := '';
  SearchTxtSearch.SetFocus;

  SearchBtnClearClick(Self);
end;

procedure TfrmSrcCust.SearchBtnSearchClick(Sender: TObject);
begin
  if Trim(SearchTxtSearch.Text) = '' then Exit;
  SearchTxtSearchByChange(Self);
  with DataModule1.ZQrySearchCust do
  begin
    Close;
      SQL.Strings[0] := 'select kode,nama,alamat,kota,tgllahir,IDcustomer from customer where tglnoneffective is null and ' + SearchCategories + ' like ' + QuotedStr(SearchTxtSearch.Text + '%');
      SQL.Strings[1] := 'order by ' + SearchCategories;
    Open;
  end;
end;

procedure TfrmSrcCust.SearchBtnClearClick(Sender: TObject);
begin
  SearchTxtSearch.Text:='';
  SearchTxtSearchByChange(Self);
  with DataModule1.ZQrySearchCust do
  begin
    Close;
      SQL.Strings[0] := 'select kode,nama,alamat,kota,tgllahir,IDcustomer from customer where tglnoneffective is null ';
      SQL.Strings[1] := 'order by ' + SearchCategories;
    Open;
  end;
end;

procedure TfrmSrcCust.SearchBtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSrcCust.SearchDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    SearchBtnAddClick(Self);
  if (Key = VK_ESCAPE) then
    SearchBtnCloseClick(Self);
end;

procedure TfrmSrcCust.SearchDBGridDblClick(Sender: TObject);
begin
  SearchBtnAddClick(Self);
end;

procedure TfrmSrcCust.SearchTxtSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then SearchBtnAddClick(Self);
  if (Key = VK_ESCAPE) then SearchBtnCloseClick(Self);

  if (Key = VK_UP) and (DataModule1.ZQrySearchCust.Bof = False) then
    DataModule1.ZQrySearchCust.Prior
  else
  if (Key = VK_DOWN) and (DataModule1.ZQrySearchCust.Eof = False) then
    DataModule1.ZQrySearchCust.Next
  else
  if (Key = VK_PRIOR) and (DataModule1.ZQrySearchCust.Bof = False) then
    DataModule1.ZQrySearchCust.MoveBy(-12)
  else
  if (Key = VK_NEXT) and (DataModule1.ZQrySearchCust.Eof = False) then
    DataModule1.ZQrySearchCust.MoveBy(12)
  else
    Exit;
end;

procedure TfrmSrcCust.SearchTxtSearchByChange(Sender: TObject);
begin
  case SearchTxtSearchBy.ItemIndex of
  0 : SearchCategories := 'kode';
  1 : SearchCategories := 'nama';
  2 : SearchCategories := 'alamat';
  end;
end;

procedure TfrmSrcCust.SearchTxtSearchChange(Sender: TObject);
begin
  if (tampsearchtxt <> SearchTxtSearch.Text) then
  begin
    tampsearchtxt := SearchTxtSearch.Text;
    if Trim(SearchTxtSearch.Text) <> '' then
    begin
      SearchBtnSearchClick(Self);
    end
    else
    begin
      SearchBtnClearClick(Self);
    end;
  end;

end;

procedure TfrmSrcCust.SearchBtnAddClick(Sender: TObject);
begin
 frmsell.vkodecust := '';
 frmsell.SellTxtCustomer.Text := '';
 frmsell.sellTxtalamat.Clear;
 frmsell.vidcust := -1;

 if  Datamodule1.ZQrySearchCust.IsEmpty then exit;

 if formSender = frmSell then
 begin
  frmsell.vkodecust := Datamodule1.ZQrySearchCustkode.Value;
  frmsell.SellTxtCustomer.Text := Datamodule1.ZQrySearchCustnama.Value;

  frmsell.sellTxtalamat.Lines.Add(Datamodule1.ZQrySearchCustalamat.AsString);
  frmsell.sellTxtalamat.Lines.Add(Datamodule1.ZQrySearchCustkota.AsString);
  frmsell.vidcust := Datamodule1.ZQrySearchCustIDcustomer.Value;

//  if formatdatetime('ddmm',Tglskrg)=formatdatetime('ddmm',Datamodule1.ZQrySearchCustTgllahir.Value) then infodialog(Datamodule1.ZQrySearchCustnama.Value+' Hari ini Ulang Tahun!');

  SearchBtnCloseClick(Self);
 end;

end;

end.
