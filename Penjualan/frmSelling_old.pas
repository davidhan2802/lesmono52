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
    RzPanel2: TRzPanel;
    SellLblCaption: TRzLabel;
    RzStatusPane1: TRzStatusPane;
    RzLabel9: TRzLabel;
    SellLblGrandTotal: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel13: TRzLabel;
    SellTxtNo: TRzEdit;
    RzLabel15: TRzLabel;
    SellTxtTgl: TRzDateTimeEdit;
    PenjualanDBGrid: TRzDBGrid;
    RzPanel4: TRzPanel;
    RzLabel1: TRzLabel;
    SellTxtSubTotal: TRzNumericEdit;
    RzLabel3: TRzLabel;
    SellTxtGrandTotal: TRzNumericEdit;
    RzLabel4: TRzLabel;
    RzLabel6: TRzLabel;
    edt_kembali: TRzNumericEdit;
    SellTxtCetak: TRzCheckBox;
    SellPanelCredit: TRzPanel;
    RzPanel7: TRzPanel;
    SellBtnAdd: TAdvSmoothButton;
    RzLabel12: TRzLabel;
    SellBtnDel: TAdvSmoothButton;
    RzLabel14: TRzLabel;
    cb_cardbank: TRzComboBox;
    RzLabel11: TRzLabel;
    RzPanel1: TRzPanel;
    memketerangan: TRzMemo;
    lbl_mode: TRzLabel;
    edtnum_discbulat: TRzNumericEdit;
    RzLabel2: TRzLabel;
    edt_bayar: TRzNumericEdit;
    RzLabel5: TRzLabel;
    edt_bayartunai: TRzNumericEdit;
    RzLabel7: TRzLabel;
    edt_bayarcard: TRzNumericEdit;
    RzLabel10: TRzLabel;
    edt_cardno: TRzEdit;
    RzLabel8: TRzLabel;
    edt_cardname: TRzEdit;
    procedure FormActivate(Sender: TObject);
    procedure SellBtnAddClick(Sender: TObject);
    procedure SellBtnDelClick(Sender: TObject);
    procedure PenjualanDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SellTxtDiscChange(Sender: TObject);
    procedure SellTxtCustomerChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SellTxtCustomerKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_bayarcardChange(Sender: TObject);
  private
    oldTotal: Double;
    function getNoFakturJual : string;
    function CekMaxStock : boolean;
    procedure CalculateGridSell;
    procedure CalculateSell;
    procedure ClearForm;
    procedure InsertDataMaster;
    procedure UpdateData;
    { Private declarations }
  public
    SubTotal,vservicesaldo : Double;
    CetakFaktur: string;
    vidcust : integer;
    procedure PostingJual(Faktur: string);
    procedure PrintStruck(NoFaktur: string);
    procedure FormShowFirst;
    { Public declarations }
  end;

var
  frmSell: TfrmSell;
  barcodeinput : string;

implementation

uses SparePartFunction, frmSearchProduct, Data;

{$R *.dfm}

procedure TfrmSell.PrintStruck(NoFaktur: string);
var
  FrxMemo: TfrxMemoView;
begin
{  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select a.*,b.alamat,b.kota,dayofweek(a.Tanggal) hari from sparepart.sellmaster a left join sparepart.customer b');
    SQL.Add('on a.kodecustomer = b.kode');
    SQL.Add('where a.faktur = ' + QuotedStr(NoFaktur) );
    Open;
  end;      }
  DataModule1.frxReport1.LoadFromFile(vpath+'Report\fakturpenjualan.fr3');
{  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Judul'));
  FrxMemo.Memo.Text := HeaderTitleRep; }

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('NoNota'));
  FrxMemo.Memo.Text := SellTxtNo.Text;
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglNota'));
  FrxMemo.Memo.Text := 'Tanggal : '+SellTxtTgl.Text;

  ///Isi FormCustomer dengan DetailCustomer

{  with DataModule1.ZQrySearch do
  begin
    Close;
    SQL.Clear;
    SQL.Add('delete from sparepart.formsell where ipv=' + Quotedstr(ipcomp) + ' and faktur = "' + NoFaktur + '"');
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('insert into sparepart.formsell ');
    SQL.Add('(ipv,nama,quantity,satuan,harga,diskon,diskonrp,subtotal,merk,kategori,kode,nama_ms,nama_ex)');
    SQL.Add('select '+Quotedstr(ipcomp)+',nama,quantity,satuan,hargajual,diskon,diskonrp,((quantity * hargajual) - diskonrp) as subtotal,merk,kategori,kode,nama_ms,nama_ex from sparepart.selldetail');
    SQL.Add('where faktur = "' + NoFaktur + '" order by kode');
    ExecSQL;
  end;           }

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

  RefreshTabel(DataModule1.ZQryFormSell);

//  DataModule1.frxReport1.ShowReport();

  DataModule1.frxReport1.PrepareReport();
  DataModule1.frxReport1.PrintOptions.ShowDialog := False;
  DataModule1.frxReport1.Print;
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

      LogInfo(UserName,'Posting transaksi penjualan, no faktur : ' + FakturBaru + ', nilai transaksi:' + GrandTotal);
//      InfoDialog('Faktur ' + Faktur + ' berhasil diposting !');
    end;
end;

function TfrmSell.getNoFakturJual : string;
var Year,Month,Day: Word;
begin
    DataModule1.ZQrySearch.Close;
    DataModule1.ZQrySearch.SQL.Text := 'select faktur from sparepart.sellmaster where isposted=-1 and left(faktur,2)='+Quotedstr(standPos)+' order by idsell limit 1';
    DataModule1.ZQrySearch.Open;
    if (DataModule1.ZQrySearch.IsEmpty=false)and(DataModule1.ZQrySearch.Fields[0].IsNull=false) then
    begin
     result := DataModule1.ZQrySearch.Fields[0].AsString;
     exit;
    end;
    DataModule1.ZQrySearch.Close;

    DecodeDate(TglSkrg,Year,Month,Day);
    with DataModule1.ZQrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select max(right(faktur,4)) from sparepart.sellmaster');
//      SQL.Add('where faktur like "' + standPos + '-' + Copy(IntToStr(Year),3,2) + '%' + '"');
      SQL.Add('where faktur like "' + standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '%' + '"');
      Open;
      if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsString = '') then
        result := standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + '0001'
      else
        result := standPos + '-' + Copy(IntToStr(Year),3,2) + FormatCurr('00',Month) + FormatCurr('0000',Fields[0].AsInteger + 1);
      Close;
    end;
end;

procedure TfrmSell.CalculateGridSell;
var vhrgpromodiskon,vqty : double;
begin
  if (DataModule1.ZQryFormSell.State <> dsInsert) or (DataModule1.ZQryFormSell.State <> dsEdit) then
    DataModule1.ZQryFormSell.Edit;

  if (DataModule1.ZQryFormSell.IsEmpty=false)and(PenjualanDBGrid.Fields[10].IsNull=false) then
  begin
//    if PenjualanDBGrid.Fields[9].AsFloat <> 0 then
//      SubTotal := SubTotal - PenjualanDBGrid.Fields[9].AsFloat;

    vqty := PenjualanDBGrid.Fields[5].AsFloat;
    vhrgpromodiskon := getDataNum('t.diskonrp','sparepart.diskondet t left join sparepart.diskon d on t.IDdiskon=d.IDdiskon where d.isactive=1 and t.minqty<='+floattostr(vqty)+' and t.maxqty>='+floattostr(vqty)+' and t.kode='+Quotedstr(PenjualanDBGrid.Fields[0].AsString)+' and '+Quotedstr(getmysqldatestr(Tglskrg))+' between d.tglawal and d.tglakhir ');
    PenjualanDBGrid.Fields[4].AsFloat := PenjualanDBGrid.Fields[4].AsFloat-vhrgpromodiskon;

    PenjualanDBGrid.Fields[6].AsFloat := PenjualanDBGrid.Fields[4].AsFloat * PenjualanDBGrid.Fields[5].AsFloat;

    if (PenjualanDBGrid.Fields[7].AsFloat > 0)or(PenjualanDBGrid.Fields[8].AsFloat > 0) then
      PenjualanDBGrid.Fields[11].AsFloat := (PenjualanDBGrid.Fields[6].AsFloat * PenjualanDBGrid.Fields[7].AsFloat * 0.01) + PenjualanDBGrid.Fields[8].AsFloat
    else PenjualanDBGrid.Fields[11].AsFloat := 0;

    PenjualanDBGrid.Fields[9].AsFloat := PenjualanDBGrid.Fields[6].AsFloat - PenjualanDBGrid.Fields[11].AsFloat;

    Subtotal := getDatanum('sum(subtotal)','sparepart.formsell where ipv='+ Quotedstr(ipcomp) +' and nourut<>'+ PenjualanDBGrid.Fields[10].AsString );
    SubTotal := SubTotal + PenjualanDBGrid.Fields[9].AsFloat;
  end
  else SubTotal := 0;
  SellTxtSubTotal.Value := SubTotal;
  CalculateSell;
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
 SellTxtGrandTotal.Value  := SellTxtSubTotal.Value - edtnum_discbulat.Value;


 if SellTxtGrandTotal.Value<0 then SellTxtGrandTotal.Value:=0;
 SellLblGrandTotal.Caption := FormatCurr('Rp ###,##0',SellTxtGrandTotal.Value);

 edt_bayar.Value := edt_bayarcard.Value + edt_bayartunai.Value;

 edt_Kembali.Value := edt_bayar.Value - SellTxtGrandTotal.Value;

 if edt_Kembali.Value<0 then edt_Kembali.Value:=0;
end;

procedure TfrmSell.ClearForm;
begin                                                                                                            
  vIDcust := 1;

  SellTxtCetak.Checked := true;

  ClearTabel('formsell where ipv='+Quotedstr(ipcomp));

  RefreshTabel(DataModule1.ZQryFormSell);

  SellTxtNo.Text :=  getNoFakturJual;
  SellTxtTgl.Date := TglSkrg;

  edtnum_discbulat.Value := 0;

  SellLblGrandTotal.Caption := 'Rp 0';
  SellTxtSubTotal.Value := 0;
  SellTxtGrandTotal.Value := 0;
  memketerangan.Text := '';
  barcodeinput := '';

  edt_bayarcard.Value := 0;
  edt_bayartunai.Value := 0;

  cb_cardbank.ItemIndex := -1;

  edt_cardno.Text := '';
  edt_cardname.Text := '';

  PenjualanDBGrid.ReadOnly := false;
//  PenjualanDBGrid.Color := clwindow;
//  lbl_mode.Caption := 'BARCODE MODE';
   PenjualanDBGrid.Color := $00D6D6D6;
   lbl_mode.Caption := 'KEYBOARD MODE (F2)';

  PenjualanDBGrid.SetFocus;
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
    SQL.Add('(faktur,tanggal,waktu,kasir,IDcustomer,subtotal,discbulat,bayartunai,bayarcard,cardbank,cardno,cardname,kembali,');
    SQL.Add('grandtotal,keterangan,totalpayment,lunas) values ');
    SQL.Add('(' + QuotedStr(SellTxtNo.Text) + ',');
    SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',SellTxtTgl.Date)) + ',');
    vwkt := FormatDateTime('hh:nn:ss',Now);
    SQL.Add(QuotedStr(vwkt) + ',');
    SQL.Add(QuotedStr(UserName) + ',');
    SQL.Add(QuotedStr(inttostr(vidCust)) + ',');
    SQL.Add(QuotedStr(FloatToStr(SellTxtSubTotal.Value)) + ',');
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
    SQL.Add('quantity,hargabeli,satuan,subtotal,idsell)');
    SQL.Add('select faktur,kode,nama,kategori,merk,seri,harga,diskon,diskonrp,diskon_rp,');
    SQL.Add('quantity,hargabeli,satuan,subtotal,'+ Quotedstr(idTrans) +' from sparepart.formsell where ipv='+ Quotedstr(ipcomp) );
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
    SQL.Add('(faktur,kode,nama,kategori,merk,seri,hargajual,diskon,diskonrp,');
    SQL.Add('quantity,hargabeli,satuan,idsales_ms,kode_ms,nama_ms,idsales_ex,kode_ex,nama_ex,komisi_ms,komisi_ex)');
    SQL.Add('select faktur,kode,nama,kategori,merk,seri,harga,diskon,round(quantity*harga*diskon*0.01),');
    SQL.Add('quantity,hargabeli,satuan,idsales_ms,kode_ms,nama_ms,idsales_ex,kode_ex,nama_ex,komisi_ms,komisi_ex from sparepart.formsell where ipv='+ Quotedstr(ipcomp));
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
      SQL.Add('faktur,kategori,merk,seri)');
      SQL.Add('select '+Quotedstr(ipcomp)+',kode,nama,hargajual,hargabeli,quantity,quantity * hargajual,');
      SQL.Add('diskon,diskonrp,(quantity * hargajual) - diskonrp,');
      SQL.Add('faktur,kategori,merk,seri from sparepart.selldetail');
      SQL.Add('where faktur = ' + QuotedStr(DataModule1.ZQrySellMasterfaktur.Text) );
      ExecSQL;
    end;
    RefreshTabel(DataModule1.ZQryFormSell);
    SubTotal := DataModule1.ZQrySellMastersubtotal.Value;
  end;
end;

procedure TfrmSell.SellBtnAddClick(Sender: TObject);
var vhrgpromodiskon,vqty : double;
begin
 if DataModule1.ZQryFormSell.IsEmpty then
 begin
  errordialog('Transaksi tidak boleh kosong!');
  exit;
 end;

 if SellTxtGrandTotal.Value>edt_bayar.Value then
 begin
  errordialog('Pembayaran lebih kecil dari Total Tagihan!');
  exit;
 end;

  CetakFaktur := SellTxtNo.Text;
  DataModule1.ZQryFormSell.CommitUpdates;

  DataModule1.ZQryFormSell.First;
  while not DataModule1.ZQryFormSell.Eof do
  begin
//   if CekMaxStock=false then exit;

   if (DataModule1.ZQryFormSell.State <> dsInsert) or (DataModule1.ZQryFormSell.State <> dsEdit) then
    DataModule1.ZQryFormSell.Edit;

   if (DataModule1.ZQryFormSell.IsEmpty=false)and(PenjualanDBGrid.Fields[10].IsNull=false) then
   begin
    vqty := PenjualanDBGrid.Fields[5].AsFloat;
    vhrgpromodiskon := getDataNum('t.diskonrp','sparepart.diskondet t left join sparepart.diskon d on t.IDdiskon=d.IDdiskon where d.isactive=1 and t.minqty<='+floattostr(vqty)+' and t.maxqty>='+floattostr(vqty)+' and t.kode='+Quotedstr(PenjualanDBGrid.Fields[0].AsString)+' and '+Quotedstr(getmysqldatestr(Tglskrg))+' between d.tglawal and d.tglakhir ');
    PenjualanDBGrid.Fields[4].AsFloat := PenjualanDBGrid.Fields[4].AsFloat-vhrgpromodiskon;
   
    PenjualanDBGrid.Fields[6].AsFloat := PenjualanDBGrid.Fields[4].AsFloat * PenjualanDBGrid.Fields[5].AsFloat;

    if (PenjualanDBGrid.Fields[7].AsFloat > 0)or(PenjualanDBGrid.Fields[8].AsFloat > 0) then
      PenjualanDBGrid.Fields[11].AsFloat := (PenjualanDBGrid.Fields[6].AsFloat * PenjualanDBGrid.Fields[7].AsFloat * 0.01) + PenjualanDBGrid.Fields[8].AsFloat
    else PenjualanDBGrid.Fields[11].AsFloat := 0;

    PenjualanDBGrid.Fields[9].AsFloat := PenjualanDBGrid.Fields[6].AsFloat - PenjualanDBGrid.Fields[11].AsFloat;
   end;

   if (PenjualanDBGrid.Fields[7].AsFloat>100) then
   begin
    DataModule1.ZQryFormSell.Cancel;
    errordialog('Nilai Disc(%) tidak boleh lebih dari 100%!');
    exit;
   end;

   DataModule1.ZQryFormSell.CommitUpdates;

   DataModule1.ZQryFormSell.Next;
  end;
  Subtotal := getDatanum('sum(subtotal)','sparepart.formsell where ipv='+Quotedstr(ipcomp) );
  SellTxtSubTotal.Value := SubTotal;
  CalculateSell;

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
    SQL.Add('where ipv='+Quotedstr(ipcomp)+' and quantity <= 0 ');
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
    ClearForm;
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
    frmSrcProd.formSender := frmSell;
    frmSrcProd.ShowModal;

  end;

//  if Key = VK_F3 then
//  begin
//    frmSrcCust.formSender := frmSell;
//    frmSrcCust.ShowModal;
//  end;

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
end;

procedure TfrmSell.SellTxtDiscChange(Sender: TObject);
begin
  CalculateSell;
end;

procedure TfrmSell.SellTxtCustomerChange(Sender: TObject);
begin
{ sellTxtalamat.Clear;

 DataModule1.ZQryUtil.Close;
 DataModule1.ZQryUtil.SQL.Clear;
// DataModule1.ZQryUtil.SQL.Text:='select alamat,kota,if((day(tgllahir)=day(CURRENT_DATE))and(month(tgllahir)=month(CURRENT_DATE)),sparepart.getcustdiscbirthday(),0) discbirthday from sparepart.customer where kode="'+cbx_kodecust.Items[cbx_kodecust.ItemIndex]+'"';
 DataModule1.ZQryUtil.SQL.Text:='select alamat,kota from sparepart.customer where kode="'+cbx_kodecust.Items[cbx_kodecust.ItemIndex]+'"';
 DataModule1.ZQryUtil.Open;
 if DataModule1.ZQryUtil.Fields[0].IsNull=false then sellTxtalamat.Lines.Add(DataModule1.ZQryUtil.Fields[0].AsString);
 if DataModule1.ZQryUtil.Fields[1].IsNull=false then sellTxtalamat.Lines.Add(DataModule1.ZQryUtil.Fields[1].AsString);
// if DataModule1.ZQryUtil.Fields[2].IsNull=false then SellTxtDiscRp.Value := DataModule1.ZQryUtil.Fields[2].AsFloat;
 DataModule1.ZQryUtil.Close;
 }
end;

procedure TfrmSell.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DataModule1.ZQryFormSell.Close;

 { IF Frmsellmaster=nil then
 application.CreateForm(TFrmsellmaster,Frmsellmaster);
 Frmsellmaster.Align:=alclient;
 Frmsellmaster.Parent:=Self.Parent;
 Frmsellmaster.BorderStyle:=bsnone;
 Frmsellmaster.FormShowFirst;
 Frmsellmaster.Show; }

end;

procedure TfrmSell.FormShow(Sender: TObject);
begin
 FormShowFirst;
end;

procedure TfrmSell.SellTxtCustomerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    frmSrcProd.formSender := frmSell;
    frmSrcProd.ShowModal;
  end;

//  if Key = VK_F3 then
//  begin
//    frmSrcCust.formSender := frmSell;
//    frmSrcCust.ShowModal;
//  end;
end;

procedure TfrmSell.FormKeyPress(Sender: TObject; var Key: Char);
var bufstr : string;
    vhrgpromodiskon,vqty : double;
begin
 if PenjualanDBGrid.ReadOnly then
 begin
  bufstr := trim(barcodeinput);

  if (Key<>#13) then barcodeinput := trim(bufstr + Key)
  else
  begin
   barcodeinput := '';

   DataModule1.ZQrySearchProduct.Close;
   DataModule1.ZQrySearchProduct.SQL.Strings[0] := 'select p.*,cast("" as char(20)) faktur,p.'+kodegudang+' qty,p.'+kodegudang+'T qtytoko,p.'+kodegudang+'R qtybad,g.nama kategori from sparepart.product p left join sparepart.golongan g on p.IDgolongan=g.IDgolongan ';
   DataModule1.ZQrySearchProduct.SQL.Strings[1] := '';
   DataModule1.ZQrySearchProduct.SQL.Strings[2] := 'where p.'+kodegudang+'T > 0 and p.barcode='+Quotedstr(bufstr);
   DataModule1.ZQrySearchProduct.Open;

   if DataModule1.ZQrySearchProduct.IsEmpty then infodialog('Barang Kosong')
   else
   begin
    if DataModule1.ZQryFormSell.Locate('kode',DataModule1.ZQrySearchProductkode.Value,[]) then
    begin
     DataModule1.ZQryFormSell.Edit;
     vqty := DataModule1.ZQryFormSellquantity.Value + 1;
     DataModule1.ZQryFormSellquantity.Value := DataModule1.ZQryFormSellquantity.Value + 1;

     vhrgpromodiskon := getDataNum('t.diskonrp','sparepart.diskondet t left join sparepart.diskon d on t.IDdiskon=d.IDdiskon where d.isactive=1 and t.minqty<='+floattostr(vqty)+' and t.maxqty>='+floattostr(vqty)+' and t.IDproduct='+DataModule1.ZQrySearchProductIDproduct.AsString+' and '+Quotedstr(getmysqldatestr(Tglskrg))+' between d.tglawal and d.tglakhir ');
     DataModule1.ZQryFormSellharga.Value := DataModule1.ZQrySearchProducthargajual.Value-vhrgpromodiskon;
    end
    else
    begin
     if DataModule1.ZQryFormSell.State <> dsEdit then DataModule1.ZQryFormSell.Append
     else
     begin
      DataModule1.ZQryFormSell.CommitUpdates;
      CalculateGridSell;
      DataModule1.ZQryFormSell.CommitUpdates;
      DataModule1.ZQryFormSell.Append;
     end;
     DataModule1.ZQryFormSellfaktur.Value := frmSell.SellTxtNo.Text;
     DataModule1.ZQryFormSellkode.Value := DataModule1.ZQrySearchProductkode.Value;
     DataModule1.ZQryFormSellnama.Value := DataModule1.ZQrySearchProductnama.Value;

     vqty := 1;
     vhrgpromodiskon := getDataNum('t.diskonrp','sparepart.diskondet t left join sparepart.diskon d on t.IDdiskon=d.IDdiskon where d.isactive=1 and t.minqty<='+floattostr(vqty)+' and t.maxqty>='+floattostr(vqty)+' and t.IDproduct='+DataModule1.ZQrySearchProductIDproduct.AsString+' and '+Quotedstr(getmysqldatestr(Tglskrg))+' between d.tglawal and d.tglakhir ');
     DataModule1.ZQryFormSellharga.Value := DataModule1.ZQrySearchProducthargajual.Value-vhrgpromodiskon;

     DataModule1.ZQryFormSellhargabeli.Value := DataModule1.ZQrySearchProducthargabeli.Value;
     DataModule1.ZQryFormSellkategori.Value := DataModule1.ZQrySearchProductkategori.Value;
     DataModule1.ZQryFormSellmerk.Value := DataModule1.ZQrySearchProductmerk.Value;
     DataModule1.ZQryFormSellseri.Value := DataModule1.ZQrySearchProductseri.Value;
     DataModule1.ZQryFormSellsatuan.Value := DataModule1.ZQrySearchProductsatuan.Value;
     DataModule1.ZQryFormSellquantity.Value := 1;
     DataModule1.ZQryFormSelldiskon.Value := DataModule1.ZQrySearchProductdiskon.Value;
     DataModule1.ZQryFormSelldiskon_rp.Value := DataModule1.ZQrySearchProductdiskonrp.Value;
     DataModule1.ZQryFormSellipv.Value := ipcomp;
    end;

    DataModule1.ZQryFormSell.CommitUpdates;
    CalculateGridSell;
    DataModule1.ZQryFormSell.CommitUpdates;

    PenjualanDBGrid.SetFocus;
    PenjualanDBGrid.SelectedIndex := 5;
   end;

   DataModule1.ZQrySearchProduct.Close;
  end;
 end;
end;

procedure TfrmSell.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
 VK_F2 :
 begin
  PenjualanDBGrid.ReadOnly := not PenjualanDBGrid.ReadOnly;
  if PenjualanDBGrid.ReadOnly then
  begin
   PenjualanDBGrid.Color := clwindow;
   lbl_mode.Caption := 'BARCODE MODE (F2)';
  end
  else
  begin
   PenjualanDBGrid.Color := $00D6D6D6;
   lbl_mode.Caption := 'KEYBOARD MODE (F2)';
  end;
 end;

 VK_F4 : edt_bayartunai.SetFocus;
 end;
end;

procedure TfrmSell.edt_bayarcardChange(Sender: TObject);
begin
 CalculateSell;
end;

end.
