unit frmSelling;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, Grids, DBGrids, RzDBGrid, DateUtils, RzLabel, ExtDlgs, JPEG,
  RzStatus, RzButton, RzRadChk, frxClass, strutils, DB, RzDBCmbo, DBCtrls;

type
  TfrmSell = class(TForm)
    PanelSell: TRzPanel;
    PenjualanDBGrid: TRzDBGrid;
    SellTxtCetak: TRzCheckBox;
    RzPanel7: TRzPanel;
    SellBtnAdd: TAdvSmoothButton;
    RzLabel12: TRzLabel;
    SellBtnDel: TAdvSmoothButton;
    RzLabel14: TRzLabel;
    RzLabel16: TRzLabel;
    edt_kode: TRzEdit;
    RzPanel6: TRzPanel;
    RzLabel18: TRzLabel;
    sellTxtalamat: TRzMemo;
    SellTxtCustomer: TRzEdit;
    pnl_payment: TRzPanel;
    RzPanel4: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel2: TRzLabel;
    SellTxtSubTotal: TRzNumericEdit;
    SellTxtGrandTotal: TRzNumericEdit;
    edt_kembali: TRzNumericEdit;
    edtnum_discbulat: TRzNumericEdit;
    edt_bayar: TRzNumericEdit;
    SellPanelCredit: TRzPanel;
    RzLabel11: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel8: TRzLabel;
    cb_cardbank: TRzComboBox;
    edt_bayartunai: TRzNumericEdit;
    edt_bayarcard: TRzNumericEdit;
    edt_cardno: TRzEdit;
    edt_cardname: TRzEdit;
    memketerangan: TRzMemo;
    RzPanel9: TRzPanel;
    RzLabel22: TRzLabel;
    AdvSmoothButton2: TAdvSmoothButton;
    lbl_jumlbrg: TRzLabel;
    RzPanel2: TRzPanel;
    SellLblCaption: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel13: TRzLabel;
    RzLabel15: TRzLabel;
    SellTxtNo: TRzEdit;
    SellTxtTgl: TRzDateTimeEdit;
    RzStatusPane1: TRzStatusPane;
    RzLabel9: TRzLabel;
    SellLblGrandTotal: TRzLabel;
    RzPanel1: TRzPanel;
    RzLabel17: TRzLabel;
    RzLabel19: TRzLabel;
    cb_nogroup: TRzComboBox;
    edt_tour: TRzEdit;
    cb_sales: TRzComboBox;
    RzLabel20: TRzLabel;
    RzLabel21: TRzLabel;
    RzLabel23: TRzLabel;
    edtnum_discpct: TRzNumericEdit;
    RzLabel24: TRzLabel;
    edtnum_discrp: TRzNumericEdit;
    RzLabel25: TRzLabel;
    SellLblkembali: TRzLabel;
    RzLabel26: TRzLabel;
    procedure FormActivate(Sender: TObject);
    procedure SellBtnAddClick(Sender: TObject);
    procedure SellBtnDelClick(Sender: TObject);
    procedure PenjualanDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SellTxtDiscChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_bayarcardChange(Sender: TObject);
    procedure edt_kodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cb_nogroupChange(Sender: TObject);
    procedure AdvSmoothButton2Click(Sender: TObject);
    procedure edtnum_discpctChange(Sender: TObject);
    procedure edt_kodeKeyPress(Sender: TObject; var Key: Char);
  private
    oldTotal: Double;
    function getNoFakturJual : string;
    function CekMaxStock : boolean;
    procedure CalculateSell;
    procedure ClearForm;
    procedure InsertDataMaster;
    procedure UpdateData;
    procedure inputkodebarcode(nilai:string);
    procedure ReprintNota;
    { Private declarations }
  public
    SubTotal,vservicesaldo : Double;
    CetakFaktur,vkodecust: string;
    vidcust : integer;
    procedure PostingJual(Faktur: string);
    procedure PrintStruck(NoFaktur: string);
    procedure FormShowFirst;
    procedure CalculateGridSell;
    procedure refreshformsell;
    { Public declarations }
  end;

var
  frmSell: TfrmSell;

implementation

uses SparePartFunction, U_cetak, frmSearchProduct, frmSearchCust, Data;

{$R *.dfm}

procedure TfrmSell.PrintStruck(NoFaktur: string);
var
  FrxMemo: TfrxMemoView;
  F : TextFile;
  i : integer;
  nmfile : string;
  totqty : single;
begin
  DataModule1.ZQryFormSell.First;

  nmfile := vpath + 'struk.txt';
  if portstruk<>'USB' then
  begin
   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQrystruk.Open;

   AssignFile(F,nmfile);
   Rewrite(F);
   Writeln(F,'   '+Datamodule1.ZQrystrukcompany.value);
   Writeln(F,' '+Datamodule1.ZQrystrukalamat.value);
   Writeln(F,' '+Datamodule1.ZQrystrukphone.value);
   Writeln(F,' =================================== ');
   Writeln(F,' Nota No.'+SellTxtNo.Text);
   Writeln(F,' Tgl.'+FormatDatetime('dd/mm/yyyy',SellTxtTgl.Date));
   Writeln(F,' ----------------------------------- ');
   i:=1;
   totqty := 0;           
   while not DataModule1.ZQryFormSell.Eof do
   begin
    Writeln(F,' '+DataModule1.ZQryFormSellkode.Value+' '+leftstr(DataModule1.ZQryFormSellnama.Value,17));
    Writeln(F,'         '+DataModule1.ZQryFormSellquantity.DisplayText+' X @Rp.'+FormatFloat('###,##0',DataModule1.ZQryFormSellharga.Value)+' = Rp.'+FormatFloat('###,##0',DataModule1.ZQryFormSellquantity.Value*DataModule1.ZQryFormSellharga.Value));
    if DataModule1.ZQryFormSelldiskon_rp.Value<>0 then Writeln(F,'         Diskon Item  :(Rp.'+FormatFloat('###,##0', DataModule1.ZQryFormSelldiskon_rp.Value)+')');
    Writeln(F,'');

    totqty := totqty + DataModule1.ZQryFormSellquantity.Value;

    i := i + 1;
    DataModule1.ZQryFormSell.Next;
   end;

   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        Subtotal       : Rp.'+FormatFloat('###,##0', SellTxtSubTotal.value));
   Writeln(F,'        Disc '+FormatFloat('###,##0', edtnum_discpct.value)+'%        : Rp.'+FormatFloat('###,##0', edtnum_discrp.value));
   Writeln(F,'        Disc Pembulatan: Rp.'+FormatFloat('###,##0', edtnum_discbulat.value));
   Writeln(F,'        Total          : Rp.'+FormatFloat('###,##0', SellTxtGrandTotal.value));
   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        Cash           : Rp.'+FormatFloat('###,##0', edt_bayartunai.value));
   Writeln(F,'        Card           : Rp.'+FormatFloat('###,##0', edt_bayarcard.value));
   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        ' + inttostr(DataModule1.ZQryFormSell.RecordCount)+' Item Dibayar: Rp.'+FormatFloat('###,##0', edt_bayar.Value));
//   Writeln(F,' DISKON PEMBULATAN....Rp.'+FormatFloat('###,##0', edtnum_discbulat.Value));
   Writeln(F,'        ' + FormatFloat(',0.###;(,0.###);0',totqty)+' Pcs Kembali : Rp.'+FormatFloat('###,##0', edt_kembali.Value));
   Writeln(F,' ----------------------------------- ');
   Writeln(F,' Member : '+vkodecust);
   Writeln(F,'');
   if (trim(Datamodule1.ZQrystrukfooter1.Value)<>'')and(Datamodule1.ZQrystrukfooter1.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter1.Value);
   if (trim(Datamodule1.ZQrystrukfooter2.Value)<>'')and(Datamodule1.ZQrystrukfooter2.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter2.Value);
   if (trim(Datamodule1.ZQrystrukfooter3.Value)<>'')and(Datamodule1.ZQrystrukfooter3.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter3.Value);
   if (trim(Datamodule1.ZQrystrukfooter4.Value)<>'')and(Datamodule1.ZQrystrukfooter4.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter4.Value);
   if (trim(Datamodule1.ZQrystrukfooter5.Value)<>'')and(Datamodule1.ZQrystrukfooter5.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter5.Value);
   Writeln(F,' ----------------------------------- ');
   if (trim(Datamodule1.ZQrystrukendfooter1.Value)<>'')and(Datamodule1.ZQrystrukendfooter1.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukendfooter1.Value);
   if (trim(Datamodule1.ZQrystrukendfooter2.Value)<>'')and(Datamodule1.ZQrystrukendfooter2.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukendfooter2.Value);
   if (trim(Datamodule1.ZQrystrukendfooter3.Value)<>'')and(Datamodule1.ZQrystrukendfooter3.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukendfooter3.Value);
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
  end
  else
  begin
  DataModule1.frxReport1.LoadFromFile(vpath+'Report\fakturpenjualan.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('NoNota'));
  FrxMemo.Memo.Text := SellTxtNo.Text;
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglNota'));
  FrxMemo.Memo.Text := 'Tanggal : '+SellTxtTgl.Text;


  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('ItemSubTotal'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',SellTxtSubTotal.value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('diskonbulat'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',edtnum_discbulat.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('bayar'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',edt_bayar.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('diskonbulat2'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',edtnum_discbulat.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('kembali'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',edt_kembali.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Kasir'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',getnow);

  Datamodule1.ZQrystruk.Close;
  Datamodule1.ZQrystruk.Open;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('cabang'));
  FrxMemo.Memo.Text := Datamodule1.ZQrystrukcabang.Value;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('footer12'));
  FrxMemo.Memo.Clear;
  FrxMemo.Memo.Add(Datamodule1.ZQrystrukfooter1.Value);
  FrxMemo.Memo.Add(Datamodule1.ZQrystrukfooter2.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('footer345'));
  FrxMemo.Memo.Clear;
  FrxMemo.Memo.Add(Datamodule1.ZQrystrukfooter3.Value);
  FrxMemo.Memo.Add(Datamodule1.ZQrystrukfooter4.Value);
  FrxMemo.Memo.Add(Datamodule1.ZQrystrukfooter5.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('endfooter123'));
  FrxMemo.Memo.Clear;
  if SellTxtGrandTotal.Value>=Datamodule1.ZQrystrukmintrans.Value then
  begin
   FrxMemo.Memo.Add(Datamodule1.ZQrystrukendfooter1.Value);
   FrxMemo.Memo.Add(Datamodule1.ZQrystrukendfooter2.Value);
   FrxMemo.Memo.Add(Datamodule1.ZQrystrukendfooter3.Value);
  end;

  Datamodule1.ZQrystruk.Close;

  DataModule1.frxReport1.PrepareReport();
  DataModule1.frxReport1.PrintOptions.ShowDialog := False;
  DataModule1.frxReport1.Print;
  end;
end;

procedure TfrmSell.PostingJual(Faktur: string);
var
  FakturBaru,idTrans,GrandTotal,totpayment,vwktt: string;
  islunas: integer;
  vtotpayment: double;
begin
    ///Ganti No Faktur temp dengan yang asli...
    ///Format NO FAKTUR TEMP : MSyy/MM/dd-hhmmss
    ///Format NO FAKTUR ASLI : MSP/Tahun 2 digit/Bulan 2 Digit disambung kode urut (MSP/09/110001)
    FakturBaru := Faktur;
    CetakFaktur := FakturBaru;

{   Datamodule1.ZQryutil.Close;
   Datamodule1.ZQryutil.SQL.Clear;
   Datamodule1.ZQryutil.SQL.Text := 'select sum(round(feebiro*subtotal)),sum(round(feedrivertl*quantity)) from sparepart.selldetail '+
                                    'where faktur=' + Quotedstr(Faktur);

   Datamodule1.ZQryutil.Open;

   vfeebiro:= '0';
   vfeedriver:= '0';
   if Datamodule1.ZQryutil.Fields[0].IsNull=false then vfeebiro  := Datamodule1.ZQryutil.Fields[0].AsString;
   if Datamodule1.ZQryutil.Fields[1].IsNull=false then vfeedriver:= Datamodule1.ZQryutil.Fields[1].AsString;
   Datamodule1.ZQryutil.Close;   }


    with DataModule1.ZQryFunction do
    begin

      Close;
      SQL.Clear;
      SQL.Add('update sparepart.sellmaster set');
      SQL.Add('isposted = ''' + '1' + ''' ');
      SQL.Add('where faktur = ''' + Faktur + '''');
      ExecSQL;
     end;

    with DataModule1.ZQrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from sparepart.sellmaster');
      SQL.Add('where faktur = ''' + Faktur + '''');
      Open;

      idTrans := FieldByName('idSell').AsString;
      if idTrans = '' then idTrans := '0';
      islunas := FieldByName('lunas').AsInteger;
      totpayment := FieldByName('totalpayment').AsString;
      GrandTotal := FieldByName('grandtotal').AsString;
      vtotpayment := FieldByName('totalpayment').AsFloat;
      vwktt := FormatDateTime('hh:nn:ss',FieldByName('waktu').AsDateTime);
    end;

    with DataModule1.ZQryFunction do
    begin
      ///Input Operasional
      if (vtotpayment<>0) then
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into sparepart.operasional');
        SQL.Add('(idTrans,faktur,tanggal,waktu,kasir,kategori,keterangan,debet) values');
        SQL.Add('(''' + idTrans + ''',');
        SQL.Add('''' + FakturBaru + ''',');
        SQL.Add('''' + FormatDateTime('yyyy-MM-dd',TglSkrg) + ''',');
        SQL.Add('''' + vwktt + ''',');
        SQL.Add('''' + UserName + ''',');
        SQL.Add('''' + 'PENJUALAN' + ''',');
        if islunas=1 then SQL.Add('''' + 'LUNAS' + ''',')
        else SQL.Add('''' + 'DP' + ''',');
        SQL.Add('''' + totpayment + ''')');
        ExecSQL;
      end;

{      if (vfeebiro<>'0') then Datamodule1.ZConnection1.ExecuteDirect('insert into sparepart.operasional ' +
      '(idTrans,faktur,tanggal,waktu,kasir,kategori,keterangan,kredit) values ' +
      '(''' + idTrans + ''',' +
      '''' + FakturBaru + ''',' +
      '''' + FormatDateTime('yyyy-MM-dd',TglSkrg) + ''',' +
      '''' + vwktt + ''',' +
      '''' + UserName + ''',' +
      '''' + 'FEE BIRO' + ''',' +
      '''' + 'FEE BIRO' + ''',' +
      '''' + vfeebiro + ''')');

      if (vfeedriver<>'0') then Datamodule1.ZConnection1.ExecuteDirect('insert into sparepart.operasional ' +
      '(idTrans,faktur,tanggal,waktu,kasir,kategori,keterangan,kredit) values ' +
      '(''' + idTrans + ''',' +
      '''' + FakturBaru + ''',' +
      '''' + FormatDateTime('yyyy-MM-dd',TglSkrg) + ''',' +
      '''' + vwktt + ''',' +
      '''' + UserName + ''',' +
      '''' + 'FEE DRIVER' + ''',' +
      '''' + 'FEE DRIVER' + ''',' +
      '''' + vfeedriver + ''')'); }

      LogInfo(UserName,'Posting transaksi penjualan, no faktur : ' + FakturBaru + ', nilai transaksi:' + GrandTotal);
//      InfoDialog('Faktur ' + Faktur + ' berhasil diposting !');
    end;
end;

function TfrmSell.getNoFakturJual : string;
var Year,Month,Day: Word;
    vlengthfaktur: integer;
begin
    DataModule1.ZQrySearch.Close;

    DecodeDate(TglSkrg,Year,Month,Day);

    vlengthfaktur:=0;
    DataModule1.ZQrySearch.SQL.Text := 'select max(length(faktur)) from sparepart.sellmaster ' +
                                       'where faktur like "' + standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '%' + '" ';
    DataModule1.ZQrySearch.Open;
    if (DataModule1.ZQrySearch.IsEmpty=false)and(DataModule1.ZQrySearch.Fields[0].IsNull=false) then
     vlengthfaktur := DataModule1.ZQrySearch.Fields[0].AsInteger;
    DataModule1.ZQrySearch.Close;

    with DataModule1.ZQrySearch do
    begin
      Close;
      SQL.Clear;

      if (vlengthfaktur=11) then
       SQL.Add('select max(right(faktur,4)) from sparepart.sellmaster ')
      else SQL.Add('select max(right(faktur,6)) from sparepart.sellmaster ');

      if (vlengthfaktur>0) then
       SQL.Add('where length(faktur)='+inttostr(vlengthfaktur)+' and faktur like "' + standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '%' + '" ')
      else SQL.Add('where faktur like "' + standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '%' + '" ');

      Open;
      if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsString = '') then
        result := standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '000001'
      else
        result := standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + FormatCurr('000000',Fields[0].AsInteger + 1);
      Close;
    end;
end;

procedure TfrmSell.CalculateGridSell;
var vhrgpromodiskon : double;
begin
  if (DataModule1.ZQryFormSell.State <> dsInsert) or (DataModule1.ZQryFormSell.State <> dsEdit) then
    DataModule1.ZQryFormSell.Edit;

  if (DataModule1.ZQryFormSell.IsEmpty=false)and(PenjualanDBGrid.Fields[10].IsNull=false) then
  begin
//    if PenjualanDBGrid.Fields[9].AsFloat <> 0 then
//      SubTotal := SubTotal - PenjualanDBGrid.Fields[9].AsFloat;

    PenjualanDBGrid.Fields[6].AsFloat := round(PenjualanDBGrid.Fields[4].AsFloat * PenjualanDBGrid.Fields[5].AsFloat);

    PenjualanDBGrid.Fields[7].AsFloat := 0;

    if (PenjualanDBGrid.Fields[7].AsFloat > 0)or(PenjualanDBGrid.Fields[8].AsFloat > 0) then
      PenjualanDBGrid.Fields[11].AsFloat := round((PenjualanDBGrid.Fields[6].AsFloat * PenjualanDBGrid.Fields[7].AsFloat * 0.01) + (PenjualanDBGrid.Fields[8].AsFloat)) //* PenjualanDBGrid.Fields[5].AsFloat)
    else PenjualanDBGrid.Fields[11].AsFloat := 0;

    PenjualanDBGrid.Fields[9].AsFloat := round(PenjualanDBGrid.Fields[6].AsFloat - PenjualanDBGrid.Fields[11].AsFloat);
    if PenjualanDBGrid.Fields[9].AsFloat<0 then PenjualanDBGrid.Fields[9].AsFloat := 0;

    Subtotal := getDatanum('sum(subtotal)','sparepart.formsell where ipv='+ Quotedstr(ipcomp) +' and nourut<>'+ PenjualanDBGrid.Fields[10].AsString );
    SubTotal := SubTotal + PenjualanDBGrid.Fields[9].AsFloat;
  end
  else SubTotal := 0;
  SellTxtSubTotal.Value := SubTotal;
  CalculateSell;

  lbl_jumlbrg.Caption := 'Jumlah Barang : ' + Formatfloat(',0.###;(,0.###);0',getDatanum('sum(quantity)','sparepart.formsell where ipv='+ Quotedstr(ipcomp) ) ) + ' pcs';
end;

function TfrmSell.CekMaxStock : boolean;
begin
  result := false;

  if (DataModule1.ZQryFormSell.State <> dsInsert) or (DataModule1.ZQryFormSell.State <> dsEdit) then
    DataModule1.ZQryFormSell.Edit;
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
//    SQL.Add('select qty from sparepart.v_stock');
//    SQL.Add('where kodegudang = '+ QuotedStr(KodeGudang) +' and kodebrg = ' + QuotedStr(DataModule1.ZQryFormSellkode.Value));
    SQL.Add('select '+kodegudang+'T from sparepart.product');
    SQL.Add('where kode = ' + QuotedStr(DataModule1.ZQryFormSellkode.Value));
    Open;
    if PenjualanDBGrid.Fields[5].AsFloat > DataModule1.ZQryFunction.Fields[0].AsFloat then
    begin
      WarningDialog('Jumlah Stock Maksimum '+DataModule1.ZQryFormSellnama.Value+' adalah ' + Fields[0].AsString);
      PenjualanDBGrid.Fields[5].AsFloat := DataModule1.ZQryFunction.Fields[0].AsFloat;
    end
    else result := true;
  end;
end;

procedure TfrmSell.CalculateSell;
begin
 edtnum_discbulat.Value := 0;

 edtnum_discrp.Value := round(edtnum_discpct.Value * 0.01 * SellTxtSubTotal.Value);

 if (SellTxtSubTotal.Value-edtnum_discrp.Value)>=100 then edtnum_discbulat.Value := strtofloat(rightstr(floattostr(SellTxtSubTotal.value-edtnum_discrp.Value),2));

 SellTxtGrandTotal.Value  := SellTxtSubTotal.Value - edtnum_discrp.Value - edtnum_discbulat.Value;


 if SellTxtGrandTotal.Value<0 then SellTxtGrandTotal.Value:=0;
 SellLblGrandTotal.Caption := FormatCurr('Rp ###,##0',SellTxtGrandTotal.Value);

 edt_bayar.Value := edt_bayarcard.Value + edt_bayartunai.Value;

 edt_Kembali.Value := edt_bayar.Value - SellTxtGrandTotal.Value;

 if edt_Kembali.Value<0 then edt_Kembali.Value:=0;

 SellLblkembali.Caption := FormatCurr('Rp ###,##0',edt_Kembali.Value);
end;

procedure TfrmSell.ClearForm;
begin
  SellBtnAdd.Enabled:=true;

  vIDcust := 1;

  vkodecust := '000';
  SellTxtCustomer.Text:='UMUM';
  sellTxtalamat.Text :='';

  SellTxtCetak.Checked := true;

  ClearTabel('formsell where ipv='+Quotedstr(ipcomp));

  RefreshTabel(DataModule1.ZQryFormSell);

  SellTxtNo.Text :=  getNoFakturJual;
  SellTxtTgl.Date := TglSkrg;

  cb_nogroup.ItemIndex := -1;
  cb_nogroup.Text := '';
  edt_tour.Text := '';
  cb_sales.ItemIndex   := -1;
  cb_sales.Text := '';

  edtnum_discbulat.Value := 0;
  edtnum_discpct.Value := 0;
  edtnum_discrp.Value := 0;

  SellLblGrandTotal.Caption := 'Rp 0';
  SellTxtSubTotal.Value := 0;
  SellTxtGrandTotal.Value := 0;
  memketerangan.Text := '';

  edt_bayarcard.Value := 0;
  edt_bayartunai.Value := 0;

  cb_cardbank.ItemIndex := -1;

  edt_cardno.Text := '';
  edt_cardname.Text := '';

  edt_kode.Text := '';

  Fill_ComboBox_with_Data_n_ID(cb_nogroup,'select IDselltourgroup,nogroup from sparepart.selltourgroup where tgl=CURRENT_DATE order by nogroup','nogroup','IDselltourgroup');
  Fill_ComboBox_with_Data_n_ID(cb_sales,'select IDsales,nama from sparepart.sales order by nama','nama','IDsales');

  pnl_payment.Visible := false;

  cb_nogroup.SetFocus;

  SubTotal := 0;
end;

procedure TfrmSell.InsertDataMaster;
var idTrans,vwkt: string;
begin
  Subtotal := getDatanum('sum(subtotal)','sparepart.formsell where ipv='+ Quotedstr(ipcomp));
  SellTxtSubTotal.Value := SubTotal;
  CalculateSell;

  DataModule1.ZConnection1.ExecuteDirect('call sparepart.p_cancelfaktur('+ QuotedStr(SellTxtNo.Text) +')');

  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into sparepart.sellmaster ');
    SQL.Add('(faktur,tanggal,waktu,kasir,IDsales,IDselltourgroup,IDcustomer,subtotal,discpct,discrp,discbulat,bayartunai,bayarcard,cardbank,cardno,cardname,kembali,');
    SQL.Add('grandtotal,keterangan,totalpayment,lunas) values ');
    SQL.Add('(' + QuotedStr(SellTxtNo.Text) + ',');
    SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',SellTxtTgl.Date)) + ',');
    vwkt := FormatDateTime('hh:nn:ss',Now);
    SQL.Add(QuotedStr(vwkt) + ',');
    SQL.Add(QuotedStr(UserName) + ',');
    if cb_sales.ItemIndex>=0 then
    SQL.Add(QuotedStr(inttostr(longint(cb_sales.Items.Objects[cb_sales.ItemIndex]))) + ',')
    else
    SQL.Add('null,');

    if (cb_nogroup.ItemIndex=-1)or(trim(cb_nogroup.Text)='') then SQL.Add('null,')
    else SQL.Add(QuotedStr(inttostr(longint(cb_nogroup.Items.Objects[cb_nogroup.ItemIndex]))) + ',');
    SQL.Add(QuotedStr(inttostr(vidCust)) + ',');
    SQL.Add(QuotedStr(FloatToStr(SellTxtSubTotal.Value)) + ',');
    SQL.Add(QuotedStr(FloatToStr(edtnum_discpct.Value)) + ',');
    SQL.Add(QuotedStr(FloatToStr(edtnum_discrp.Value)) + ',');
    SQL.Add(QuotedStr(FloatToStr(edtnum_discbulat.Value)) + ',');
    SQL.Add(QuotedStr(FloatToStr(edt_bayartunai.Value)) + ',');
    SQL.Add(QuotedStr(FloatToStr(edt_bayarcard.Value)) + ',');
    SQL.Add(QuotedStr(trim(cb_cardbank.Text)) + ',');
    SQL.Add(QuotedStr(trim(edt_cardno.Text)) + ',');
    SQL.Add(QuotedStr(trim(edt_cardname.Text)) + ',');
    SQL.Add(QuotedStr(FloatToStr(edt_kembali.Value)) + ',');
    SQL.Add(QuotedStr(FloatToStr(SellTxtGrandTotal.Value)) + ',');
    SQL.Add(QuotedStr(Memketerangan.Text) + ',');
    SQL.Add(QuotedStr(FloatToStr(SellTxtGrandTotal.Value)) + ',');
    SQL.Add(QuotedStr('1') + ')');
    ExecSQL;

    DataModule1.ZConnection1.ExecuteDirect('update sparepart.formsell o, sparepart.product p set o.faktur='+Quotedstr(SellTxtNo.Text)+', o.satuan=p.satuan where (o.kode=p.kode) and (o.ipv='+Quotedstr(ipcomp)+') ');

    Close;
    SQL.Clear;
    SQL.Text := 'select idsell from sparepart.sellmaster where faktur='+ Quotedstr(SellTxtNo.Text) ;
    Open;
    idTrans := Fields[0].AsString;

    Close;
    SQL.Clear;
    SQL.Add('insert into sparepart.selldetail');
    SQL.Add('(faktur,kode,nama,kategori,merk,seri,hargajual,diskon,diskonrp,diskon_rp,');
    SQL.Add('quantity,hargabeli,satuan,subtotal,idsell,feebiro,feedrivertl,feerent)');
    SQL.Add('select faktur,kode,nama,kategori,merk,seri,harga,diskon,diskonrp,diskon_rp,');
    SQL.Add('quantity,hargabeli,satuan,subtotal,'+ Quotedstr(idTrans) +',feebiro,feedrivertl,feerent from sparepart.formsell where ipv='+ Quotedstr(ipcomp) );
    ExecSQL;

     ///Input Inventory
     Close;
     SQL.Clear;
     SQL.Add('insert into sparepart.inventory ');
     SQL.Add('(kodebrg,qty,satuan,hargabeli,hargajual,faktur,keterangan,typetrans,idTrans,username,tglTrans,waktu,kodeGudang) ');
     SQL.Add('select kode,(quantity * -1),satuan,hargabeli,harga,faktur,'+Quotedstr(memketerangan.Text)+',''penjualan'','''+idTrans+''',' + QuotedStr(UserName) + ',''' + FormatDateTime('yyyy-MM-dd',TglSkrg) + ''',''' + vwkt + ''',''' + KodeGudang + 'T'' from sparepart.formsell where ipv='+ Quotedstr(ipcomp) );
     ExecSQL;
  end;

end;

procedure TfrmSell.UpdateData;
var idTrans: string;
begin
  Subtotal := getDatanum('sum(subtotal)','sparepart.formsell where ipv='+ Quotedstr(ipcomp));
  SellTxtSubTotal.Value := SubTotal;
  CalculateSell;

  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update sparepart.sellmaster set');
    SQL.Add('tanggal = ''' + FormatDateTime('yyyy-MM-dd',SellTxtTgl.Date) + ''',');
    SQL.Add('waktu = ''' + FormatDateTime('hh:nn:ss',Now) + ''',');
    SQL.Add('kasir = ' + QuotedStr(UserName) + ',');
    SQL.Add('kodecustomer = ' + QuotedStr(inttostr(vidCust)) + ',');
    SQL.Add('subtotal = ''' + FloatToStr(SellTxtSubTotal.Value) + ''',');
    SQL.Add('grandtotal = ''' + FloatToStr(SellTxtGrandTotal.Value) + ''',');
    SQL.Add('where faktur = ''' + SellTxtNo.Text + '''');
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('delete from sparepart.selldetail');
    SQL.Add('where faktur = ''' + SellTxtNo.Text + '''');
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('insert into sparepart.selldetail');
    SQL.Add('(faktur,kode,nama,kategori,merk,seri,hargajual,diskon,diskon_rp,diskonrp,');
    SQL.Add('quantity,hargabeli,satuan,feebiro,feedrivertl,feerent) ');
    SQL.Add('select faktur,kode,nama,kategori,merk,seri,harga,diskon,diskon_rp,diskonrp,');
    SQL.Add('quantity,hargabeli,satuan,feebiro,feedrivertl,feerent from sparepart.formsell where ipv='+ Quotedstr(ipcomp));
    ExecSQL;

    DataModule1.ZConnection1.ExecuteDirect('update sparepart.selldetail o set o.satuan=(select satuan from sparepart.product where kode=o.kode) where (o.faktur="'+ SellTxtNo.Text +'") and ((o.satuan="") or (o.satuan is null))');

{        DataModule1.ZQryUtil.Close;
        DataModule1.ZQryUtil.SQL.Clear;
        DataModule1.ZQryUtil.SQL.Text:='select sum((quantity*hargajual)-diskonrp) from sparepart.selldetail where faktur="'+SellTxtNo.Text+'"';
        DataModule1.ZQryUtil.Open;
        DataModule1.ZConnection1.ExecuteDirect('update sparepart.sellmaster set subtotal="'+DataModule1.ZQryUtil.Fields[0].AsString+'",total="'+FloattoStr(DataModule1.ZQryUtil.Fields[0].AsFloat+SellTxtPPN.Value)+'",grandtotal="'+FloattoStr(DataModule1.ZQryUtil.Fields[0].AsFloat+SellTxtPPN.Value-SellTxtDiscRp.Value)+'" where faktur="'+SellTxtNo.Text+'"');
        DataModule1.ZQryUtil.Close;  }

    DataModule1.ZConnection1.ExecuteDirect('delete from sparepart.inventory where faktur=' + Quotedstr(SellTxtNo.Text) + ' and typetrans=' + Quotedstr('penjualan') );

    Close;
    SQL.Clear;
    SQL.Text := 'select idsell from sparepart.sellmaster where faktur='''+ SellTxtNo.Text +'''';
    Open;
    idTrans := Fields[0].AsString;
    ///Input Inventory
    Close;
    SQL.Clear;
    SQL.Add('insert into sparepart.inventory ');
    SQL.Add('(kodebrg,qty,satuan,hargabeli,hargajual,faktur,typetrans,idTrans,tglTrans,kodeGudang) ');
    SQL.Add('select kode,(quantity * -1),satuan,hargabeli,harga,faktur,''penjualan'','''+idTrans+''',''' + FormatDateTime('yyyy-MM-dd',TglSkrg) + ''',''' + KodeGudang + 'T'' from sparepart.formsell where ipv='+ Quotedstr(ipcomp));
    ExecSQL;
  end;
end;

procedure TfrmSell.FormActivate(Sender: TObject);
begin
{  frmSell.Top := frmSellMaster.PanelPenjualan.Top - 65;
  frmSell.Height := frmSellMaster.PanelPenjualan.Height + 95;
  frmSell.Width := frmSellMaster.PanelPenjualan.Width;
  if frmSell.Width > 800 then
  begin
    frmSell.Left := 1;
    PenjualanDBGrid.Columns.Items[1].Width := 350;
//    PenjualanDBGrid.Columns.Items[7].Width := 200;
  end
  else
  begin
    frmSell.Left := 2;
    PenjualanDBGrid.Columns.Items[1].Width := 150;
//    PenjualanDBGrid.Columns.Items[7].Width := 84;
  end;      }
end;

procedure TfrmSell.FormShowFirst;
begin
  ipcomp := getComputerIP;

  DataModule1.ZQryFormSell.Close;
  DataModule1.ZQryFormSell.SQL.Text := 'select * from sparepart.formsell where ipv='+ Quotedstr(ipcomp) + ' order by kode ';

  SellLblCaption.Caption := 'Input Penjualan';

  if SellLblCaption.Caption = 'Input Penjualan' then
  begin
    ClearForm;
  end
  else
  begin
    SellTxtCetak.Checked := true;

    SellTxtNo.Text := DataModule1.ZQrySellMasterfaktur.Value;
    SellTxtTgl.Date := DataModule1.ZQrySellMastertanggal.Value;

    SellLblGrandTotal.Caption := FormatCurr('Rp ###,##0',DataModule1.ZQrySellMastergrandtotal.Value);
    SellTxtSubTotal.Value := DataModule1.ZQrySellMastersubtotal.Value;
    SellTxtGrandTotal.Value := DataModule1.ZQrySellMastergrandtotal.Value;

    oldTotal := DataModule1.ZQrySellMastergrandtotal.Value;

    ClearTabel('formsell where ipv='+ Quotedstr(ipcomp));
    with DataModule1.ZQryFunction do
    begin
      Close;
      SQL.Clear;
      SQL.Add('insert into sparepart.formsell ');
      SQL.Add('(ipv,kode,nama,harga,hargabeli,quantity,totalharga,diskon,diskonrp,subtotal,');
      SQL.Add('faktur,kategori,merk,seri,feebiro,feedrivertl,feerent)');
      SQL.Add('select '+Quotedstr(ipcomp)+',kode,nama,hargajual,hargabeli,quantity,quantity * hargajual,');
      SQL.Add('diskon,diskonrp,(quantity * hargajual) - diskonrp,');
      SQL.Add('faktur,kategori,merk,seri,feebiro,feedrivertl,feerent from sparepart.selldetail');
      SQL.Add('where faktur = ' + QuotedStr(DataModule1.ZQrySellMasterfaktur.Text) );
      ExecSQL;
    end;
    RefreshTabel(DataModule1.ZQryFormSell);
    SubTotal := DataModule1.ZQrySellMastersubtotal.Value;
  end;
end;

procedure TfrmSell.refreshformsell;
begin
  DataModule1.ZQryFormSell.CommitUpdates;

  DataModule1.ZConnection1.ExecuteDirect('update sparepart.formsell set totalharga=round(quantity*harga),diskonrp=round((round(quantity*harga)*diskon*0.01)+diskon_rp)'+',subtotal=round(round(quantity*harga)-round((round(quantity*harga)*diskon*0.01)+diskon_rp)) where ipv='+Quotedstr(ipcomp));

  DataModule1.ZQryFormSell.Refresh;
end;

procedure TfrmSell.SellBtnAddClick(Sender: TObject);
var vnogrp : string;
begin
 if (SellBtnAdd.Enabled=false) then exit;

 refreshformsell;

 if DataModule1.ZQryFormSell.IsEmpty then
 begin
  errordialog('Transaksi tidak boleh kosong!');
  exit;
 end;

 vnogrp := trim(cb_nogroup.Text);
 cb_nogroup.ItemIndex := cb_nogroup.Items.IndexOf(vnogrp);

 if (cb_nogroup.ItemIndex<=-1) then
 begin
  Fill_ComboBox_with_Data_n_ID(cb_nogroup,'select IDselltourgroup,nogroup from sparepart.selltourgroup where tgl=CURRENT_DATE order by nogroup','nogroup','IDselltourgroup');
  cb_nogroup.ItemIndex := cb_nogroup.Items.IndexOf(vnogrp);
 end;

 if (cb_nogroup.ItemIndex<=-1)or(trim(cb_nogroup.Text)='') then
 begin
  errordialog('No.Rombongan harus diisi!');
  exit;
 end;

 cb_sales.ItemIndex := cb_sales.Items.IndexOf(trim(cb_sales.Text));
{ if (cb_sales.ItemIndex<=-1)or(trim(cb_sales.Text)='') then
 begin
  errordialog('Sales harus diisi!');
  exit;
 end;   }

  CetakFaktur := SellTxtNo.Text;

//   if CekMaxStock=false then exit;

  Subtotal := getDatanum('sum(subtotal)','sparepart.formsell where ipv='+Quotedstr(ipcomp) );
  SellTxtSubTotal.Value := SubTotal;
  CalculateSell;

  if SellTxtGrandTotal.Value>edt_bayar.Value then
  begin
   errordialog('Pembayaran lebih kecil dari Total Tagihan!');
   exit;
  end;

  if SellTxtSubTotal.Value<0 then
  begin
    ErrorDialog('Sub Total Faktur tidak boleh minus!');
    Exit;
  end;

  with DataModule1.ZQrySearch do
  begin
    ///Check apakah ada yang belum diinput
    Close;
    SQL.Clear;
    SQL.Add('select faktur from sparepart.formsell ');
    SQL.Add('where (ipv='+Quotedstr(ipcomp)+') and ((quantity <= 0)or(subtotal <= 0)) ');
    Open;
    if not IsEmpty then
    begin
      ErrorDialog('Nilai tidak boleh kosong!');
      Exit;
    end;
  end;

  DataModule1.ZConnection1.StartTransaction;
  try
    InsertDataMaster;
    PostingJual(CetakFaktur);
    LogInfo(UserName,'Insert Penjualan Faktur No: ' + SellTxtNo.Text + ',Total: ' + FloatToStr(SellTxtGrandTotal.Value));

    DataModule1.ZConnection1.Commit;

    PrintStruck(CetakFaktur);

    SellBtnAdd.Enabled:=false;

  //  ClearForm;
  except
    DataModule1.ZConnection1.Rollback;
    DataModule1.ZConnection1.ExecuteDirect('call sparepart.p_cancelfaktur('+QuotedStr(CetakFaktur)+')');
    ErrorDialog('Gagal Posting, coba ulangi Buat Faktur lagi!');
    ClearForm;
  end;

{  else
  begin
    UpdateData;
    if SellTxtCetak.Checked = True then
    begin
      PostingJual(CetakFaktur);
      PrintStruck(CetakFaktur);
    end;
    InfoDialog('Edit Penjualan Faktur No. ' + SellTxtNo.Text + ' berhasil');
    LogInfo(UserName,'Edit Penjualan Faktur No. ' + SellTxtNo.Text + ', Old Total: ' + FloatToStr(OldTotal) + ' New Total: ' + FloatToStr(SellTxtGrandTotal.Value));
    Close;
  end; }
//  RefreshTabel(DataModule1.ZQrySellMaster);
end;

procedure TfrmSell.SellBtnDelClick(Sender: TObject);
begin
 ClearForm;
end;

procedure TfrmSell.PenjualanDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    DataModule1.ZQryFormSell.CommitUpdates;
    CalculateGridSell;
    DataModule1.ZQryFormSell.Append;

    frmSrcProd.formSender := frmSell;
    frmSrcProd.ShowModal;
    PenjualanDBGrid.SetFocus;
    PenjualanDBGrid.SelectedIndex := 5;
  end;

  if Key = VK_F3 then
  begin
    frmSrcCust.formSender := frmSell;
    frmSrcCust.ShowModal;
  end;

  if (Key in [VK_RETURN, VK_RIGHT, VK_UP, VK_DOWN, VK_TAB]) then
  begin
      DataModule1.ZQryFormSell.CommitUpdates;
//      if PenjualanDBGrid.SelectedIndex in [4,5] then CekMaxStock;
      CalculateGridSell;
    if PenjualanDBGrid.SelectedIndex in [4,5] then
    begin
{      DataModule1.ZQryFormSell.CommitUpdates;
      CekMaxStock;
      CalculateGridSell;   }
      PenjualanDBGrid.SelectedIndex := 7;
    end
    else if PenjualanDBGrid.SelectedIndex in [7,8] then
    begin
{      DataModule1.ZQryFormSell.CommitUpdates;
      CalculateGridSell;   }

      DataModule1.ZQryFormSell.Append;
      PenjualanDBGrid.SelectedIndex := 5;
    end;
  end;

  if (Key in [VK_DELETE]) then
  begin
    SubTotal := SubTotal - DataModule1.ZQryFormSellsubtotal.Value;
    DataModule1.ZQryFormSell.Delete;
    CalculateGridSell;
  end;

  if (Key=VK_F5) then SellBtnAddClick(sender);
  if (Key=VK_F9) then SellBtnDelClick(sender);

  if (Key=VK_F4) then
             begin
              pnl_payment.Visible := true;
              edt_bayartunai.SetFocus;
             end;

 if (Key=VK_F10) then
             begin
              pnl_payment.Visible := false;
              PenjualanDBGrid.SetFocus;
             end;

 if (Key=VK_F8) then ReprintNota;
end;

procedure TfrmSell.SellTxtDiscChange(Sender: TObject);
begin
  CalculateSell;
end;

procedure TfrmSell.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DataModule1.ZQryFormSell.Close;

end;

procedure TfrmSell.edt_bayarcardChange(Sender: TObject);
begin
 CalculateSell;
end;

procedure TfrmSell.inputkodebarcode(nilai:string);
var bufstr : string;
    vhrgpromodiskon,vqty : double;
begin
  bufstr := trim(nilai);

  if bufstr='' then exit;

   DataModule1.ZQrySearchProduct.Close;
   DataModule1.ZQrySearchProduct.SQL.Strings[0] := 'select p.*,cast("" as char(20)) faktur,p.'+kodegudang+' qty,p.'+kodegudang+'T qtytoko,p.'+kodegudang+'R qtybad,null kategori from sparepart.product p ';
   DataModule1.ZQrySearchProduct.SQL.Strings[1] := '';
   DataModule1.ZQrySearchProduct.SQL.Strings[2] := 'where (p.kode='+Quotedstr(bufstr)+')or(p.barcode='+Quotedstr(bufstr)+') ';
   DataModule1.ZQrySearchProduct.Open;

   if DataModule1.ZQrySearchProduct.IsEmpty then infodialog('Barang Kosong')
   else
   begin
    if DataModule1.ZQryFormSell.Locate('kode',DataModule1.ZQrySearchProductkode.Value,[]) then
    begin
     DataModule1.ZQryFormSell.Edit;
     vqty := DataModule1.ZQryFormSellquantity.Value + 1;
     DataModule1.ZQryFormSellquantity.Value := DataModule1.ZQryFormSellquantity.Value + 1;

     DataModule1.ZQryFormSelldiskon.Value := 0;
     DataModule1.ZQryFormSelldiskon_rp.Value := DataModule1.ZQryFormSellquantity.Value * getDataNum('t.diskonrp','sparepart.diskondet t left join sparepart.diskon d on t.IDdiskon=d.IDdiskon where d.isactive=1 and t.minqty<='+ Number2MySQL(vqty)+' and t.maxqty>='+Number2MySQL(vqty)+' and t.IDproduct='+DataModule1.ZQrySearchProductIDproduct.AsString+' and '+Quotedstr(getmysqldatestr(Tglskrg))+' between d.tglawal and d.tglakhir ');
     DataModule1.ZQryFormSelldiskonrp.Value := DataModule1.ZQryFormSelldiskon_rp.Value;
     DataModule1.ZQryFormSellharga.Value := DataModule1.ZQrySearchProducthargajual.Value;
    end
    else
    begin
      DataModule1.ZQryFormSell.CommitUpdates;
      CalculateGridSell;
      DataModule1.ZQryFormSell.CommitUpdates;
      DataModule1.ZQryFormSell.Append;

     DataModule1.ZQryFormSellfaktur.Value := frmSell.SellTxtNo.Text;
     DataModule1.ZQryFormSellkode.Value := DataModule1.ZQrySearchProductkode.Value;
     DataModule1.ZQryFormSellnama.Value := DataModule1.ZQrySearchProductnama.Value;

     DataModule1.ZQryFormSelldiskon.Value := 0;
     vqty := 1;
     DataModule1.ZQryFormSelldiskon_rp.Value := DataModule1.ZQryFormSellquantity.Value * getDataNum('t.diskonrp','sparepart.diskondet t left join sparepart.diskon d on t.IDdiskon=d.IDdiskon where d.isactive=1 and t.minqty<='+Number2MySQL(vqty)+' and t.maxqty>='+Number2MySQL(vqty)+' and t.IDproduct='+DataModule1.ZQrySearchProductIDproduct.AsString+' and '+Quotedstr(getmysqldatestr(Tglskrg))+' between d.tglawal and d.tglakhir ');
     DataModule1.ZQryFormSellquantity.Value := 1;
     DataModule1.ZQryFormSelldiskonrp.Value := DataModule1.ZQryFormSelldiskon_rp.Value;
     DataModule1.ZQryFormSellharga.Value := DataModule1.ZQrySearchProducthargajual.Value;

     DataModule1.ZQryFormSellhargabeli.Value := DataModule1.ZQrySearchProducthargabeli.Value;
     DataModule1.ZQryFormSellkategori.Value := DataModule1.ZQrySearchProductkategori.Value;
     DataModule1.ZQryFormSellmerk.Value := DataModule1.ZQrySearchProductmerk.Value;
     DataModule1.ZQryFormSellseri.Value := DataModule1.ZQrySearchProductseri.Value;
     DataModule1.ZQryFormSellsatuan.Value := DataModule1.ZQrySearchProductsatuan.Value;
     DataModule1.ZQryFormSellipv.Value := ipcomp;
     DataModule1.ZQryFormSellfeebiro.Value := DataModule1.ZQrySearchProductfeebiro.Value;
     DataModule1.ZQryFormSellfeedrivertl.Value := DataModule1.ZQrySearchProductfeedrivertl.Value;
     DataModule1.ZQryFormSellfeerent.Value := DataModule1.ZQrySearchProductfeerent.Value;
    end;

    DataModule1.ZQryFormSell.CommitUpdates;
    CalculateGridSell;
    DataModule1.ZQryFormSell.CommitUpdates;

    PenjualanDBGrid.SetFocus;
    PenjualanDBGrid.SelectedIndex := 5;
   end;

   DataModule1.ZQrySearchProduct.Close;
end;

procedure TfrmSell.edt_kodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
 VK_RETURN : begin
              if PanelSell.Visible=false then
              begin
               cb_nogroup.ItemIndex := cb_nogroup.Items.IndexOf(trim(cb_nogroup.Text));
               if (cb_nogroup.ItemIndex<=-1)or(trim(cb_nogroup.Text)='') then
               begin
                errordialog('Isi No.Rombongan dulu dengan benar!');
                cb_nogroup.SetFocus;
                exit;
               end;
               PanelSell.Visible:=true;
              end;


              inputkodebarcode(edt_kode.Text);
              edt_kode.Text:='';
              edt_kode.SetFocus;
             end;


 VK_F1 :     begin
              frmSrcProd.formSender := frmSell;
              frmSrcProd.ShowModal;
              PenjualanDBGrid.SetFocus;
              PenjualanDBGrid.SelectedIndex := 5;
             end;

 VK_F3 :     begin
              frmSrcCust.formSender := frmSell;
              frmSrcCust.ShowModal;
             end;

 VK_ESCAPE : begin
              pnl_payment.Visible := false;
              PenjualanDBGrid.SetFocus;
             end;
 VK_F6 : begin
              pnl_payment.Visible := true;
              if (edt_bayartunai.Value=0)and(edt_bayarcard.Value=0) then edt_bayarcard.Value :=  SellTxtGrandTotal.Value;
              edt_bayarcard.SetFocus;
         end;
 VK_F8 : ReprintNota;
 VK_F5 : SellBtnAddClick(sender);
 VK_F9 : SellBtnDelClick(sender);
 end;
end;

procedure TfrmSell.ReprintNota;
var F : TextFile;
    i : integer;
    nmfile : string;
    totqty : single;
begin
  with DataModule1.ZQrySellMaster do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select s.*,l.nama nmsales,c.nama nmcust,g.nogroup,sum(d.quantity*d.hargabeli) modal from sparepart.sellmaster s ');
    SQL.Add('left join sparepart.selldetail d on s.faktur=d.faktur ');
    SQL.Add('left join sparepart.sales l on s.idsales=l.idsales ');
    SQL.Add('left join sparepart.customer c on s.IDcustomer=c.IDcustomer ');
    SQL.Add('left join sparepart.selltourgroup g on s.IDselltourgroup=g.IDselltourgroup ');
    SQL.Add('where s.idsell='+ getdata('max(idsell)','sparepart.sellmaster where left(faktur,2)='+Quotedstr(standPos)+' and isposted<>-1') );
    Open;
  end;

  ClearTabel('formsell2 where ipv='+ Quotedstr(ipcomp) );

  DataModule1.ZConnection1.ExecuteDirect('insert into sparepart.formsell2 '+
    ' (ipv,faktur,kode,nama,kategori,merk,seri,harga,diskon,diskonrp,diskon_rp,quantity,hargabeli,satuan,subtotal)' +
    ' select '+Quotedstr(ipcomp)+',faktur,kode,nama,kategori,merk,seri,hargajual,diskon,diskonrp,diskon_rp,quantity,hargabeli,satuan,subtotal from sparepart.selldetail' +
    ' where faktur = "' + DataModule1.ZQrySellMasterfaktur.Value + '" order by kode');

  DataModule1.ZQryformsell2.Close;
  DataModule1.ZQryformsell2.SQL.Text := 'select * from sparepart.formsell2 where ipv='+Quotedstr(ipcomp)+' order by kode ';
  RefreshTabel(DataModule1.ZQryformsell2);

  nmfile := vpath + 'struk.txt';

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQrystruk.Open;

   AssignFile(F,nmfile);
   Rewrite(F);
   Writeln(F,'   '+Datamodule1.ZQrystrukcompany.value);
   Writeln(F,' '+Datamodule1.ZQrystrukalamat.value);
   Writeln(F,' '+Datamodule1.ZQrystrukphone.value);
   Writeln(F,' =================================== ');
   Writeln(F,' Nota No.'+DataModule1.ZQrySellMasterfaktur.Value);
   Writeln(F,' Tgl.'+FormatDatetime('dd/mm/yyyy',DataModule1.ZQrySellMastertanggal.Value));
   Writeln(F,' ----------------------------------- ');

   i:=1;
   totqty := 0;
   while not DataModule1.ZQryformsell2.Eof do
   begin
    Writeln(F,' '+DataModule1.ZQryformsell2kode.Value+' '+leftstr(DataModule1.ZQryformsell2nama.Value,17));
    Writeln(F,'         '+DataModule1.ZQryformsell2quantity.DisplayText+' X @Rp.'+FormatFloat('###,##0',DataModule1.ZQryformsell2harga.Value)+' = Rp.'+FormatFloat('###,##0',DataModule1.ZQryformsell2quantity.Value*DataModule1.ZQryformsell2harga.Value));
    if DataModule1.ZQryFormSell2diskon_rp.Value<>0 then Writeln(F,'         Diskon Item  :(Rp.'+FormatFloat('###,##0', DataModule1.ZQryFormSell2diskon_rp.Value)+')');
    Writeln(F,'');

    totqty := totqty + DataModule1.ZQryformsell2quantity.Value;

    i := i + 1;
    DataModule1.ZQryformsell2.Next;
   end;

   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        Subtotal       : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterSubTotal.value));
   Writeln(F,'        Disc '+FormatFloat('###,##0', DataModule1.ZQrySellMasterdiscpct.value)+'%        : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterdiscrp.value));
   Writeln(F,'        Disc Pembulatan: Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterdiscbulat.value));
   Writeln(F,'        Total          : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterGrandTotal.value));
   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        Cash           : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterbayartunai.value));
   Writeln(F,'        Card           : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterbayarcard.value));
   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        ' + inttostr(DataModule1.ZQryformsell2.RecordCount)+' Item Dibayar: Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterbayartunai.Value + DataModule1.ZQrySellMasterbayarcard.Value));
//   Writeln(F,' DISKON PEMBULATAN....Rp.'+FormatFloat('###,##0', edtnum_discbulat.Value));
   Writeln(F,'        ' + FormatFloat(',0.###;(,0.###);0',totqty)+' Pcs Kembali : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterkembali.Value));
   Writeln(F,' ----------------------------------- ');
   Writeln(F,' Member : '+getdata('kode','sparepart.customer where idcustomer='+DataModule1.ZQrySellMasteridcustomer.AsString));
   Writeln(F,'');
   if (trim(Datamodule1.ZQrystrukfooter1.Value)<>'')and(Datamodule1.ZQrystrukfooter1.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter1.Value);
   if (trim(Datamodule1.ZQrystrukfooter2.Value)<>'')and(Datamodule1.ZQrystrukfooter2.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter2.Value);
   if (trim(Datamodule1.ZQrystrukfooter3.Value)<>'')and(Datamodule1.ZQrystrukfooter3.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter3.Value);
   if (trim(Datamodule1.ZQrystrukfooter4.Value)<>'')and(Datamodule1.ZQrystrukfooter4.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter4.Value);
   if (trim(Datamodule1.ZQrystrukfooter5.Value)<>'')and(Datamodule1.ZQrystrukfooter5.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukfooter5.Value);
   Writeln(F,' ----------------------------------- ');
   if (trim(Datamodule1.ZQrystrukendfooter1.Value)<>'')and(Datamodule1.ZQrystrukendfooter1.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukendfooter1.Value);
   if (trim(Datamodule1.ZQrystrukendfooter2.Value)<>'')and(Datamodule1.ZQrystrukendfooter2.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukendfooter2.Value);
   if (trim(Datamodule1.ZQrystrukendfooter3.Value)<>'')and(Datamodule1.ZQrystrukendfooter3.IsNull=false) then Writeln(F,' '+Datamodule1.ZQrystrukendfooter3.Value);
   Writeln(F,'');
   Writeln(F,'RePrinted By ' + DataModule1.ZQrySellMasterkasir.value + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',getnow));
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,chr(27)+chr(105));
   Writeln(F,chr(27)+chr(112)+chr(0)+chr(50)+chr(250));

   CloseFile(F);

   Datamodule1.ZQrystruk.Close;

   Datamodule1.ZQryformsell2.Close;
   DataModule1.ZQrySellMaster.Close;

   cetakFile(nmfile);

end;

procedure TfrmSell.cb_nogroupChange(Sender: TObject);
begin
 if (cb_nogroup.ItemIndex=-1)or(trim(cb_nogroup.Text)='') then
 begin
  edt_tour.Text := '';
  exit;
 end;

 edt_tour.Text := getData('namatour','sparepart.selltourgroup where tgl=CURRENT_DATE ');
end;

procedure TfrmSell.AdvSmoothButton2Click(Sender: TObject);
begin
              pnl_payment.Visible := false;
              PenjualanDBGrid.SetFocus;

end;

procedure TfrmSell.edtnum_discpctChange(Sender: TObject);
begin
 CalculateSell;
end;

procedure TfrmSell.edt_kodeKeyPress(Sender: TObject; var Key: Char);
begin
 case Key of
 '+' :  begin
         if (edt_bayartunai.Value=0)and(edt_bayarcard.Value=0) then edt_bayartunai.Value :=  SellTxtGrandTotal.Value;
         pnl_payment.Visible := true;

         Key :=#0;
         edt_bayartunai.SetFocus;
        end;

 #13 : begin
        if SellBtnAdd.Enabled=false then
        begin
         Key :=#0;
         SellBtnDelClick(Sender);
        end;
       end;
 end;

end;

end.
