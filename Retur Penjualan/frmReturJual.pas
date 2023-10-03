unit frmReturJual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, Grids, DBGrids, RzDBGrid, RzLabel, ExtDlgs, JPEG,
  RzStatus, RzButton, RzRadChk, frxClass, Db;

type
  TfrmRtrJual = class(TForm)
    Panel: TRzPanel;
    RzStatusPane1: TRzStatusPane;
    RzLabel9: TRzLabel;
    RtrJualLblGrandTotal: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel15: TRzLabel;
    RtrJualTxtTglRetur: TRzDateTimeEdit;
    ReturJualDBGrid: TRzDBGrid;
    RzPanel2: TRzPanel;
    LblCaption: TRzLabel;
    RzLabel1: TRzLabel;
    RtrJualTxtFaktur: TRzEdit;
    RtrJualTxtCetak: TRzCheckBox;
    RzPanel7: TRzPanel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RtrJualBtnAdd: TAdvSmoothButton;
    RtrJualDel: TAdvSmoothButton;
    RzPanel1: TRzPanel;
    RzLabel4: TRzLabel;
    RtrJualTxtFakturJual: TRzComboBox;
    sellTxtalamat: TRzMemo;
    RzPanel4: TRzPanel;
    RzLabel6: TRzLabel;
    RtrTxtGrandTotal: TRzNumericEdit;
    RtrPanelCredit: TRzPanel;
    RzLabel11: TRzLabel;
    RtrTxtpembayaran: TRzComboBox;
    RzLabel5: TRzLabel;
    RtrTxtSubTotal: TRzNumericEdit;
    RtrTxtPPN: TRzNumericEdit;
    RzLabel8: TRzLabel;
    RtrTxtGudang: TRzComboBox;
    ccx_isppn: TRzCheckBox;
    procedure RtrJualBtnAddClick(Sender: TObject);
    procedure RtrJualDelClick(Sender: TObject);
    procedure ReturJualDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RtrJualTxtFakturJualChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure RtrJualTxtFakturJualKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ccx_isppnClick(Sender: TObject);
  private
    oldTotal: Double;
    procedure FillCombo;
    procedure ClearForm;
    procedure InsertDataMaster;
    procedure UpdateData;
    procedure CalculateGridRetur;
    procedure CalculateRetur;
    function getNoRetur : string;
    function lastfakturjual : string;
    { Private declarations }
  public
    SubTotal,TotalTrans : Double;
    CetakFaktur: string;
    vkodecust : string;
    procedure PostingReturJual(Faktur: string);
    procedure PrintStruck(NoFaktur: string);
    procedure FormShowFirst;
    { Public declarations }
  end;

var
  frmRtrJual: TfrmRtrJual;

implementation

uses SparePartFunction, frmSearchProduct, Data;

{$R *.dfm}

procedure TfrmRtrJual.FillCombo;
begin
  FillComboBox('faktur','sellmaster where tanggal>DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY) and isposted=1 ' ,RtrJualTxtFakturJual,false,'faktur');

end;

procedure TfrmRtrJual.ClearForm;
begin
  ClearTabel('formretur where ipv='+ quotedstr(ipcomp));
  RefreshTabel(DataModule1.ZQryFormRetur);
  FillCombo;
  RtrJualTxtFaktur.Text := '';
  RtrJualTxtTglRetur.Date := TglSkrg;

  RtrTxtGudang.ItemIndex := 1;
  RtrTxtSubTotal.Value := 0;
  ccx_isppn.Checked := false;
  RtrTxtPPN.Value := 0;
  RtrTxtGrandTotal.Value := 0;
  RtrJualLblGrandTotal.Caption := 'Rp 0';
  ReturJualDBGrid.SetFocus;
  SubTotal   := 0;
  TotalTrans := 0;

  RtrJualTxtFakturJual.ItemIndex:=-1;
  RtrJualTxtFakturJual.Text := '';
  RtrJualTxtFakturJualchange(self);

  vkodecust := '';
  sellTxtalamat.clear;

  RtrJualTxtFakturJual.SetFocus;
end;

procedure TfrmRtrJual.CalculateRetur;
begin
    if ccx_isppn.Checked then RtrTxtPPN.Value := round(RtrTxtSubTotal.Value*0.1) else RtrTxtPPN.Value := 0;

    RtrTxtGrandTotal.Value := RtrTxtSubTotal.Value + RtrTxtPPN.Value;
    if RtrTxtGrandTotal.Value<0 then RtrTxtGrandTotal.Value:=0;
    RtrJualLblGrandTotal.Caption := FormatCurr('Rp ###,##0',RtrTxtGrandTotal.Value);
end;

procedure TfrmRtrJual.InsertDataMaster;
var vkodegdg, idTrans : string;
begin
  SubTotal := getDatanum('sum(subtotal)','formretur where ipv='+ Quotedstr(ipcomp) );
  RtrTxtSubTotal.Value := SubTotal;
  CalculateRetur;

  if RtrTxtGudang.ItemIndex=0 then vkodegdg:=kodegudang
  else if RtrTxtGudang.ItemIndex=1 then vkodegdg:=kodegudang+'T'
  else vkodegdg:=kodegudang+'R';

  DataModule1.ZConnection1.ExecuteDirect('call p_cancelretur('+ QuotedStr(RtrJualTxtFaktur.Text) +')');

  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into returjualmaster');
    SQL.Add('(faktur,tanggal,waktu,operator,kodecustomer,customer,alamat,kota,');
    SQL.Add('totalretur,TotalTrans,subtotal,ppn,fakturjual,pembayaran,kodegudang,isposted) values');
    SQL.Add('("' + RtrJualTxtFaktur.Text + '",');
    SQL.Add('"' + FormatDateTime('yyyy-MM-dd',RtrJualTxtTglRetur.Date) + '",');
    SQL.Add('"' + FormatDateTime('hh:nn:ss',Now) + '",');
    SQL.Add(QuotedStr(UserName) + ',');
    SQL.Add(QuotedStr(vKodeCust) + ',');
    SQL.Add(QuotedStr(sellTxtalamat.Lines.Strings[0]) + ',');
    SQL.Add(QuotedStr(sellTxtalamat.Lines.Strings[1]) + ',');
    SQL.Add(QuotedStr(sellTxtalamat.Lines.Strings[2]) + ',');
    SQL.Add('"' + FloatToStr(RtrTxtGrandTotal.Value) + '",');
    SQL.Add('"' + FloatToStr(TotalTrans) + '",');
    SQL.Add('"' + FloatToStr(RtrTxtSubTotal.Value) + '",');
    SQL.Add('"' + FloatToStr(RtrTxtPPN.Value) + '",');
    SQL.Add(QuotedStr(RtrJualTxtFakturJual.Text) + ',');
    SQL.Add(QuotedStr(RtrTxtpembayaran.Text) + ',');
    SQL.Add(QuotedStr(vkodegdg) + ',');
    SQL.Add('"' + '0' + '")');
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('select idReturJual from returjualmaster');
    SQL.Add('where faktur = ' + QuotedStr(RtrJualTxtFaktur.Text) );
    Open;

    idTrans := Fields[0].AsString;

    Close;
    SQL.Clear;
    SQL.Add('insert into returjualdetail');
    SQL.Add('(idReturJual,faktur,kode,nama,kategori,merk,seri,keterangan,qtyjual,qtyretur,hargabeli,hargajual,diskon,diskon_rp,diskonrp,satuan,fakturjual,kodegudang,subtotal)');
    SQL.Add('select '+Quotedstr(idTrans)+',faktur,kode,nama,kategori,merk,seri,keterangan,quantity,quantityretur,hargabeli,harga,diskon,diskon_rp,diskonrp,satuan,fakturjual,'+QuotedStr(vkodegdg)+',subtotal ');
    SQL.Add('from formretur where ipv='+ Quotedstr(ipcomp) + ' and quantityretur>0 ');
    ExecSQL;
  end;
end;

procedure TfrmRtrJual.UpdateData;
var vkodegdg : string;
begin
  RtrTxtGrandTotal.Value := SubTotal;
  RtrJualLblGrandTotal.Caption := FormatCurr('Rp ###,##0',SubTotal);

  if RtrTxtGudang.ItemIndex=0 then vkodegdg:=kodegudang
  else if RtrTxtGudang.ItemIndex=1 then vkodegdg:=kodegudang+'T'
  else vkodegdg:=kodegudang+'R';

  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update returjualmaster set');
    SQL.Add('tanggal = "' + FormatDateTime('yyyy-MM-dd',RtrJualTxtTglRetur.Date) + '",');
    SQL.Add('waktu = "' + FormatDateTime('hh:nn:ss',Now) + '",');
    SQL.Add('operator = "' + UserName + '",');
//    SQL.Add('pembayaran = "' + RtrTxtPembayaran.Text + '",');
    SQL.Add('totaltrans = "' + FloatToStr(totaltrans) + '",');
    SQL.Add('totalretur = "' + FloatToStr(SubTotal) + '"');
    SQL.Add('where faktur = "' + RtrJualTxtFaktur.Text + '"');
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('delete from returjualdetail');
    SQL.Add('where faktur = "' + RtrJualTxtFaktur.Text + '"');
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('insert into returjualdetail');
    SQL.Add('(faktur,kode,nama,kategori,merk,seri,keterangan,qtyjual,qtyretur,hargajual,diskon,diskonrp,satuan,fakturjual,kodegudang,hargabeli)');
    SQL.Add('select faktur,kode,nama,kategori,merk,seri,keterangan,quantity,quantityretur,harga,diskon,diskonrp,satuan,fakturjual,kodegudang,hargabeli ');
    SQL.Add('from formretur where ipv='+ Quotedstr(ipcomp) );
    ExecSQL;
  end;
end;

function TfrmRtrJual.getNoRetur : string;
//var Year,Month,Day: Word;
begin
    DataModule1.ZQrySearch.Close;
    DataModule1.ZQrySearch.SQL.Text := 'select faktur from returjualmaster where (isposted=-1) and (faktur like "R' + RtrJualTxtFakturJual.Text + '%") order by idreturjual limit 1';
    DataModule1.ZQrySearch.Open;
    if (DataModule1.ZQrySearch.IsEmpty=false)and(DataModule1.ZQrySearch.Fields[0].IsNull=false) then
    begin
     result := DataModule1.ZQrySearch.Fields[0].AsString;
     exit;
    end;
    DataModule1.ZQrySearch.Close;

//    DecodeDate(TglSkrg,Year,Month,Day);
    with DataModule1.ZQrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select count(faktur) from returjualmaster');
      SQL.Add('where faktur like "R' + RtrJualTxtFakturJual.Text + '%"');
      Open;
      if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsInteger = 0) then
        result := 'R' + RtrJualTxtFakturJual.Text + '-1'
      else
        result := 'R' + RtrJualTxtFakturJual.Text + '-' + inttostr(Fields[0].AsInteger+1);
      Close;
    end;
end;

procedure TfrmRtrJual.CalculateGridRetur;
begin
  if (DataModule1.ZQryFormRetur.State <> dsInsert) or (DataModule1.ZQryFormRetur.State <> dsEdit) then
    DataModule1.ZQryFormRetur.Edit;

  if ReturJualDBGrid.Fields[6].AsFloat > ReturJualDBGrid.Fields[5].AsFloat then
  begin
    ErrorDialog('Retur Quantity Maksimal adalah ' + ReturJualDBGrid.Fields[5].AsString);
    ReturJualDBGrid.Fields[6].AsFloat := ReturJualDBGrid.Fields[5].AsFloat;
  end;

  if (DataModule1.ZQryFormRetur.IsEmpty=false)and(ReturJualDBGrid.Fields[12].IsNull=false) then
  begin
//  if ReturJualDBGrid.Fields[11].AsFloat <> 0 then
//    SubTotal := SubTotal - ReturJualDBGrid.Fields[11].AsFloat;
    if (ReturJualDBGrid.Fields[9].AsFloat > 0)or(ReturJualDBGrid.Fields[10].AsFloat > 0) then
        ReturJualDBGrid.Fields[13].AsFloat := Round(ReturJualDBGrid.Fields[6].AsFloat * ReturJualDBGrid.Fields[8].AsFloat * ReturJualDBGrid.Fields[9].AsFloat * 0.01)+ReturJualDBGrid.Fields[10].AsFloat
    else ReturJualDBGrid.Fields[13].AsFloat := 0;

   ReturJualDBGrid.Fields[11].AsFloat := (ReturJualDBGrid.Fields[6].AsFloat * ReturJualDBGrid.Fields[8].AsFloat) - ReturJualDBGrid.Fields[13].AsFloat;

   Subtotal := getDatanum('sum(subtotal)','formretur where ipv='+Quotedstr(ipcomp)+' and nourut<>'+ ReturJualDBGrid.Fields[12].AsString );
   SubTotal := SubTotal + ReturJualDBGrid.Fields[11].AsFloat;
  end
  else SubTotal := 0;

  RtrTxtSubTotal.Value := SubTotal;
  CalculateRetur;
end;

procedure TfrmRtrJual.PostingReturJual(Faktur: string);
var
  Year,Month,Day: Word;
  //FakturBaru,
  idTrans,Total,JenisBayar,vwkt,vkodegdg: string;
begin
    ///Ganti No Faktur temp dengan yang asli...
    ///Format NO FAKTUR TEMP : MSyy/MM/dd-hhmmss
    ///Format NO FAKTUR ASLI : BRJ/Tahun 2 digit/Bulan 2 Digit disambung kode urut (MSP/09/110001)
    DecodeDate(TglSkrg,Year,Month,Day);
    with DataModule1.ZQrySearch do
    begin
  {    Close;
      SQL.Clear;
      SQL.Add('select max(right(faktur,6)) from returjualmaster');
      SQL.Add('where faktur like ''' + 'BRJ/' + Copy(IntToStr(Year),3,2) + '/' + FormatCurr('00',Month) + '%' + '''');
      Open;
      if Fields[0].AsString = '' then
        FakturBaru := 'BRJ/' + Copy(IntToStr(Year),3,2) + '/' + FormatCurr('00',Month) + '0001'
      else
        FakturBaru := 'BRJ/' + Copy(IntToStr(Year),3,2) + '/' + FormatCurr('000000',Fields[0].AsInteger + 1);

      CetakFaktur := FakturBaru;
  }
      CetakFaktur := Faktur;

      Close;
      SQL.Clear;
      SQL.Add('select * from returjualmaster');
      SQL.Add('where faktur = ' + QuotedStr(Faktur) );
      Open;

      idTrans := FieldByName('idReturJual').AsString;
      if idTrans = '' then idTrans := '0';
      Total := FieldByName('totalretur').AsString;
      JenisBayar := FieldByName('pembayaran').AsString;
      vwkt := FormatDateTime('hh:nn:ss',FieldByName('waktu').AsDateTime);

    end;

    with DataModule1.ZQryFunction do
    begin
{      Close;
      SQL.Clear;
      SQL.Add('update returjualdetail set');
      SQL.Add('faktur = "' + FakturBaru + '"');
      SQL.Add('where faktur = "' + Faktur + '"');
      ExecSQL;
                    }
      Close;
      SQL.Clear;
      SQL.Add('update returjualmaster set ');
      SQL.Add('lunas = if((pembayaran="CASH"),1,0),');
      SQL.Add('isposted = "' + '1' + '" ');
      SQL.Add('where faktur = "' + Faktur + '"');
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('update sellmaster set ');
      SQL.Add('totalretur = totalretur+'+ Quotedstr(floattostr(RtrTxtGrandTotal.Value)) +' ');
      SQL.Add('where faktur = ' + Quotedstr(trim(RtrJualTxtFakturJual.Text)) );
      ExecSQL;

      if RtrTxtGudang.ItemIndex=0 then vkodegdg:=kodegudang
      else if RtrTxtGudang.ItemIndex=1 then vkodegdg:=kodegudang+'T'
      else vkodegdg:=kodegudang+'R';


      ///Input Inventory
      Close;
      SQL.Clear;
      SQL.Add('insert into inventory');
      SQL.Add('(kodebrg,qty,satuan,hargabeli,hargajual,faktur,kodegudang,keterangan,typetrans,idTrans,username,waktu,tglTrans)');
      SQL.Add('select kode,quantityretur,satuan,hargabeli,harga,faktur,'+QuotedStr(vkodegdg)+','+Quotedstr(sellTxtalamat.Lines.Strings[0])+',"retur penjualan","'+idTrans+'",' + QuotedStr(UserName) +',"'+ vwkt+'","'+FormatDateTime('yyyy-MM-dd',TglSkrg)+'" from formretur where ipv='+Quotedstr(ipcomp)+' and quantityretur>0');
      ExecSQL;

      ///Input Operasional
      if JenisBayar = 'CASH' then
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into operasional');
        SQL.Add('(idTrans,faktur,tanggal,waktu,kasir,kategori,keterangan,kredit) values');
        SQL.Add('(''' + idTrans + ''',');
        SQL.Add('''' + Faktur + ''',');
        SQL.Add('''' + FormatDateTime('yyyy-MM-dd',TglSkrg) + ''',');
        SQL.Add('''' + vwkt + ''',');
        SQL.Add('''' + UserName + ''',');
        SQL.Add('''' + 'RETUR PENJUALAN TUNAI' + ''',');
        SQL.Add('''' + 'LUNAS' + ''',');
        SQL.Add('''' + Total + ''')');
        ExecSQL;
      end;

      LogInfo(UserName,'Posting transaksi retur penjualan, No. Faktur Retur : ' + Faktur + ', nilai transaksi:' + Total);
      InfoDialog('Faktur Retur Jual ' + Faktur + ' berhasil diposting !');
    end;
end;

procedure TfrmRtrJual.PrintStruck(NoFaktur: string);
var
  FrxMemo: TfrxMemoView;
begin
  DataModule1.ZConnection1.ExecuteDirect('delete from formretur where ipv='+Quotedstr(ipcomp)+' and quantityretur<=0 ');


  DataModule1.frxReport1.LoadFromFile(vpath+'Report\FakturReturJual.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('NoNota'));
  FrxMemo.Memo.Text := RtrJualTxtFaktur.Text;
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglNota'));
  FrxMemo.Memo.Text := RtrJualTxtTglRetur.Text;
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('NmCustomer'));
  FrxMemo.Memo.Text := sellTxtalamat.Lines.Strings[0];
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('AlmCustomer'));
  FrxMemo.Memo.Text := sellTxtalamat.Lines.Strings[1] + ' ' + sellTxtalamat.Lines.Strings[2];

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('ItemGrandTotal'));
  FrxMemo.Memo.Text := FormatCurr('Rp ###,##0',RtrTxtGrandTotal.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Kasir'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName  + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',now);

  RefreshTabel(DataModule1.ZQryFormRetur);

  DataModule1.frxReport1.ShowReport();
end;

procedure TfrmRtrJual.FormShowFirst;
begin
  ipcomp := getComputerIP;

  DataModule1.ZQryFormRetur.Close;
  DataModule1.ZQryFormRetur.SQL.Text := 'select * from formretur where ipv='+Quotedstr(ipcomp)+' order by kode,nourut ';

  LblCaption.Caption := 'Input Retur';

  if LblCaption.Caption = 'Input Retur' then
  begin
    ClearForm;
  end
  else
  begin
    FillCombo;
    RtrJualTxtFaktur.Text := DataModule1.ZQryReturJualfaktur.Value;
    RtrJualTxtTglRetur.Date := DataModule1.ZQryReturJualtanggal.Value;
    RtrTxtGrandTotal.Value := DataModule1.ZQryReturJualtotalretur.AsFloat;
    RtrJualLblGrandTotal.Caption := FormatCurr('Rp ###,##0',DataModule1.ZQryReturJualtotalretur.Value);

    oldTotal := DataModule1.ZQryReturJualtotalretur.Value;

    ClearTabel('formretur where ipv='+ Quotedstr(ipcomp) );
    with DataModule1.ZQryFunction do
    begin
      Close;
      SQL.Clear;
      SQL.Add('insert into formretur ');
      SQL.Add('(ipv,kode,nama,quantity,quantityretur,keterangan,harga,subtotal,');
      SQL.Add('kategori,merk,seri,faktur,diskon,diskonrp,fakturjual,kodegudang,hargabeli)');
      SQL.Add('select '+Quotedstr(ipcomp)+',kode,nama,qtyjual,qtyretur,keterangan,hargajual,(qtyretur * hargajual)-diskonrp,');
      SQL.Add('kategori,merk,seri,faktur,diskon,diskonrp,fakturjual,kodegudang,hargabeli from returjualdetail');
      SQL.Add('where faktur = ''' + DataModule1.ZQryReturJualfaktur.Text + '''');
      ExecSQL;
    end;
    RefreshTabel(DataModule1.ZQryFormRetur);
    SubTotal := DataModule1.ZQryReturJualtotalretur.Value;
  end;
end;

procedure TfrmRtrJual.RtrJualBtnAddClick(Sender: TObject);
begin
 if DataModule1.ZQryFormRetur.IsEmpty then
 begin
  errordialog('Transaksi tidak boleh kosong!');
  exit;
 end;

  DataModule1.ZQryFormRetur.CommitUpdates;
  DataModule1.ZQryFormRetur.First;
  while not DataModule1.ZQryFormRetur.Eof do
  begin
   if (DataModule1.ZQryFormRetur.State <> dsInsert) or (DataModule1.ZQryFormRetur.State <> dsEdit) then
       DataModule1.ZQryFormRetur.Edit;

   if ReturJualDBGrid.Fields[6].AsFloat > ReturJualDBGrid.Fields[5].AsFloat then
   begin
    ErrorDialog('Retur Quantity Maksimal adalah ' + ReturJualDBGrid.Fields[5].AsString);
    ReturJualDBGrid.Fields[6].AsFloat := ReturJualDBGrid.Fields[5].AsFloat;
   end;

   if (DataModule1.ZQryFormRetur.IsEmpty=false)and(ReturJualDBGrid.Fields[12].IsNull=false) then
   begin
    if (ReturJualDBGrid.Fields[9].AsFloat > 0)or(ReturJualDBGrid.Fields[10].AsFloat > 0) then
        ReturJualDBGrid.Fields[13].AsFloat := Round(ReturJualDBGrid.Fields[6].AsFloat * ReturJualDBGrid.Fields[8].AsFloat * ReturJualDBGrid.Fields[9].AsFloat * 0.01)+ReturJualDBGrid.Fields[10].AsFloat
    else ReturJualDBGrid.Fields[13].AsFloat := 0;

    ReturJualDBGrid.Fields[11].AsFloat := (ReturJualDBGrid.Fields[6].AsFloat * ReturJualDBGrid.Fields[8].AsFloat) - ReturJualDBGrid.Fields[13].AsFloat;
   end;

   DataModule1.ZQryFormRetur.CommitUpdates;
   DataModule1.ZQryFormRetur.Next;
  end;

  if (RtrTxtGudang.Text='')or(RtrTxtGudang.ItemIndex=-1) then
  begin
    ErrorDialog('Isi dahulu Retur Ke!');
    Exit;
  end;

  if (RtrJualTxtFaktur.Text='')or(RtrJualTxtFakturJual.ItemIndex=-1) then
  begin
    ErrorDialog('Isi dahulu No. Retur dan Invoice yang akan di-Retur!');
    Exit;
  end;

  with DataModule1.ZQrySearch do
  begin
    ///Check apakah ada yang belum diinput
    Close;
    SQL.Clear;
    SQL.Add('select sum(quantityretur) from formretur where ipv='+ Quotedstr(ipcomp));
//    SQL.Add('where quantityretur <= 0 ');
    Open;
    if IsEmpty or(Fields[0].AsFloat<=0) then
    begin
      ErrorDialog('Tidak ada Retur!');
      Exit;
    end;
    Close;
  end;

  DataModule1.ZConnection1.StartTransaction;
  try
    InsertDataMaster;
    PostingReturJual(RtrJualTxtFaktur.Text);
    LogInfo(UserName,'Insert Retur Penjualan Faktur No: ' + RtrJualTxtFaktur.Text + ',Total: ' + FloatToStr(SubTotal));

    DataModule1.ZConnection1.Commit;

//    PrintStruck(RtrJualTxtFaktur.Text);
    ClearForm;
  except
    DataModule1.ZConnection1.Rollback;
    DataModule1.ZConnection1.ExecuteDirect('call p_cancelretur('+QuotedStr(RtrJualTxtFaktur.Text)+')');
    ErrorDialog('Gagal Posting, coba ulangi buat Retur Penjualan lagi!');
    ClearForm;
  end;
{  end
  else
  begin
    UpdateData;
    InfoDialog('Edit Retur Penjualan Faktur No. ' + RtrJualTxtFaktur.Text + ' berhasil');
    LogInfo(UserName,'Edit Retur Penjualan Faktur No. ' + RtrJualTxtFaktur.Text + ', Old Total: ' + FloatToStr(OldTotal) + ' New Total: ' + FloatToStr(SubTotal));
  end; }
//  RefreshTabel(DataModule1.ZQryReturJual);
end;

procedure TfrmRtrJual.RtrJualDelClick(Sender: TObject);
begin
 ClearForm;
end;

procedure TfrmRtrJual.ReturJualDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  if Key = VK_F1 then
  begin
    if (RtrJualTxtFaktur.Text='')or(SellTxtCustomer.ItemIndex=-1) then
    begin
     ErrorDialog('Isi dahulu No. Retur dan Customer !');
     exit;
    end;
    frmSrcProd.formSender := frmRtrJual;
    frmSrcProd.ShowModal;
  end;
 }

{  if (Key in [VK_TAB]) and (DataModule1.ZQryFormRetur.RecordCount = DataModule1.ZQryFormRetur.RecNo) and (ReturJualDBGrid.SelectedIndex = 7) then
    Key := VK_RETURN;
}

  if (Key in [VK_RETURN, VK_RIGHT, VK_UP, VK_DOWN, VK_TAB]) then
  begin
      DataModule1.ZQryFormRetur.CommitUpdates;
      CalculateGridRetur;

    if ReturJualDBGrid.SelectedIndex in [6,7] then
    begin
//      DataModule1.ZQryFormRetur.CommitUpdates;
//      CalculateGridRetur;
      ReturJualDBGrid.SelectedIndex := 0;
    end;
//    else if ReturJualDBGrid.SelectedIndex in [9,10] then
//    begin
//      DataModule1.ZQryFormRetur.CommitUpdates;
//      CalculateGridRetur;

//      DataModule1.ZQryFormRetur.Append;
//      ReturJualDBGrid.SelectedIndex := 0;
//    end;

  end;

  if (Key in [VK_RETURN]) then
    Key := VK_DOWN;

  if (Key in [VK_DELETE]) then
  begin
    SubTotal := SubTotal - DataModule1.ZQryFormRetursubtotal.Value;
    DataModule1.ZQryFormRetur.Delete;
    CalculateGridRetur;
  end;
end;

function TfrmRtrJual.lastfakturjual : string;
begin
 Datamodule1.ZQryUtil.Close;
 Datamodule1.ZQryUtil.SQL.Clear;
 Datamodule1.ZQryUtil.SQL.Text := 'select faktur from sellmaster where isposted=1 and kodecustomer=' + QuotedStr(vkodecust) + ' order by idsell desc limit 1';
 Datamodule1.ZQryUtil.Open;
 if (Datamodule1.ZQryUtil.IsEmpty) or (Datamodule1.ZQryUtil.Fields[0].IsNull) then result:=''
 else result := Datamodule1.ZQryUtil.Fields[0].AsString;
 Datamodule1.ZQryUtil.Close;
end;

procedure TfrmRtrJual.RtrJualTxtFakturJualChange(Sender: TObject);
var vkodegdg : string;
begin
  if (RtrJualTxtFakturJual.Text='')or(RtrJualTxtFakturJual.ItemIndex=-1) then
  begin
   RtrJualTxtFaktur.Text := '';
   ClearTabel('formretur where ipv='+ Quotedstr(ipcomp));

   vkodecust := '';
   sellTxtalamat.clear;

   TotalTrans := 0;
   SubTotal   := 0;
   RtrTxtSubTotal.Value := SubTotal;
   ccx_isppn.Checked := false;
   RtrTxtPPN.Value := 0;
   CalculateRetur;

   RefreshTabel(DataModule1.ZQryFormRetur);

   exit;
  end;

  RtrJualTxtFaktur.Text := getNoRetur;

  ClearTabel('formretur where ipv='+ Quotedstr(ipcomp));
  with DataModule1.ZQrySearch do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select s.*,c.kode kodecustomer,c.nama customer,c.alamat,c.kota from sellmaster s left join customer c on s.IDcustomer=c.IDcustomer ');
    SQL.Add('where s.faktur = "' + RtrJualTxtFakturJual.Text + '"');
    Open;
    vKodeCust := FieldByName('kodecustomer').AsString;

    sellTxtalamat.Clear;
    sellTxtalamat.Lines.Add(FieldByName('customer').AsString);
    sellTxtalamat.Lines.Add(FieldByName('alamat').AsString);
    sellTxtalamat.Lines.Add(FieldByName('kota').AsString);
    TotalTrans := FieldByName('GrandTotal').AsCurrency;

    SubTotal := 0;
    RtrTxtSubTotal.Value := SubTotal;
    ccx_isppn.Checked := FieldByName('ppn').AsFloat<>0;
    RtrTxtPPN.Value := 0;
    CalculateRetur;

 //   RtrTxtpembayaran.ItemIndex := RtrTxtpembayaran.Items.IndexOf(FieldByName('pembayaran').AsString);

    if RtrTxtGudang.ItemIndex=0 then vkodegdg:=kodegudang
    else if RtrTxtGudang.ItemIndex=1 then vkodegdg:=kodegudang+'T'
    else vkodegdg:=kodegudang+'R';

    Close;
    SQL.Clear;
    SQL.Add('insert into formretur ');
    SQL.Add('(ipv,kode,nama,quantity,satuan,harga,kodegudang,kategori,merk,seri,faktur,fakturjual,diskon,diskon_rp,hargabeli)');
    SQL.Add('select '+Quotedstr(ipcomp)+',kode,nama,getQtysisaReturJual(faktur,kode),satuan,hargajual,'+Quotedstr(vkodegdg)+',kategori,merk,seri,"'+RtrJualTxtFaktur.Text+'","' + RtrJualTxtFakturJual.Text + '",diskon,diskon_rp,hargabeli from selldetail');
    SQL.Add('where faktur = "' + RtrJualTxtFakturJual.Value + '"');
    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('delete from formretur where ipv='+Quotedstr(ipcomp)+' and quantity=0');
    ExecSQL;

{    Close;
    SQL.Clear;
    SQL.Add('update formretur set quantityretur=quantity where ipv='+Quotedstr(ipcomp));
    ExecSQL; }
  end;

  RefreshTabel(DataModule1.ZQryFormRetur);

  if DataModule1.ZQryFormRetur.IsEmpty then errordialog('Sudah tidak ada yang dapat di-Retur dari No. Faktur ini !');
end;

procedure TfrmRtrJual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    DataModule1.ZQryFormRetur.Close;

end;

procedure TfrmRtrJual.FormShow(Sender: TObject);
begin
  Panel.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panel.Color := $00808040;

 FormShowFirst;
end;

procedure TfrmRtrJual.RtrJualTxtFakturJualKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
{  if Key = VK_F1 then
  begin
    if (RtrJualTxtFaktur.Text='')or(SellTxtCustomer.ItemIndex=-1) then
    begin
     ErrorDialog('Isi dahulu No. Retur dan Customer !');
     exit;
    end;
    frmSrcProd.formSender := frmRtrJual;
    frmSrcProd.ShowModal;
  end;
 }
end;

procedure TfrmRtrJual.ccx_isppnClick(Sender: TObject);
begin
 calculateretur;
end;

end.
