unit sellmaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, PDJDBGridex, RzEdit, StdCtrls, RzCmboBx, Mask,
  RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, frxClass, RzButton, RzRadChk, db,
  RzRadGrp, ComCtrls, strutils;

type
  TFrmsellmaster = class(TForm)
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
    RzPanel15: TRzPanel;
    RzLabel62: TRzLabel;
    SellTxtTotalJual: TRzNumericEdit;
    PenjualanDB: TPDJDBGridEx;
    pnl_cetak_list: TRzPanel;
    RzLabel43: TRzLabel;
    SellBtnPrintList: TAdvSmoothButton;
    pnl_del: TRzPanel;
    SellBtnDel: TAdvSmoothButton;
    RzLabel42: TRzLabel;
    pnl_cetak_faktur: TRzPanel;
    SellBtnPrintStruck: TAdvSmoothButton;
    RzLabel204: TRzLabel;
    RGgroup: TRzRadioGroup;
    edtnum_terlakutop: TRzNumericEdit;
    UpDown1: TUpDown;
    edt_nama: TRzEdit;
    procedure SellBtnDelClick(Sender: TObject);
    procedure SellBtnPrintListClick(Sender: TObject);
    procedure SellBtnPrintStruckClick(Sender: TObject);
    procedure SellBtnSearchClick(Sender: TObject);
    procedure SellBtnClearClick(Sender: TObject);
    procedure PenjualanDBDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SellTxtSearchbyChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure PrintListPenjualan;
    procedure PrintListPenjualanItem;
    procedure ZQrySellMasterAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmsellmaster: TFrmsellmaster;
  ShowDetail : boolean;

implementation

uses SparePartFunction, U_cetak, Data;

{$R *.dfm}

procedure TFrmsellmaster.FormShowFirst;
begin
 ShowDetail := false;

 ipcomp := getComputerIP;

 DataModule1.ZQrySellMaster.AfterScroll := ZQrySellMasterAfterScroll;


 pnl_del.Visible       := isdel;


 SellTxtSearchFirst.Date := TglSkrg;
 SellTxtSearchLast.Date  := TglSkrg;

 edtnum_terlakutop.Value := 20;

 edt_nama.Text := '';

 SellBtnClearClick(Self);
end;

procedure TFrmsellmaster.PrintListPenjualan;
var
  FrxMemo: TfrxMemoView;
  ketstr : string;
begin
  DataModule1.frxReport1.LoadFromFile(vpath+'Report\selling.fr3');
//  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Judul'));
//  FrxMemo.Memo.Text := HeaderTitleRep;
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));

  ketstr := '';
  if (SellTxtSearch.Text<>'')and(SellTxtSearchby.ItemIndex>=0) then ketstr := ' ' + uppercase(SellTxtSearchby.Text) + ' : ' + SellTxtSearch.Text + '...';

  FrxMemo.Memo.Text := 'PENJUALAN'+ketstr;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglJual'));
  FrxMemo.Memo.Text := 'Tanggal ' + FormatDateTime('dd/MM/yyyy',frmSellMaster.SellTxtSearchFirst.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',frmSellMaster.SellTxtSearchLast.Date);
  DataModule1.frxReport1.ShowReport();
end;

procedure TFrmsellmaster.PrintListPenjualanItem;
var
  FrxMemo: TfrxMemoView;
  ketstr, SearchCategories, strfilter : string;
begin
  case SellTxtSearchby.ItemIndex of
  0 : SearchCategories := 's.faktur';
  1 : SearchCategories := 's.kasir';
  2 : SearchCategories := 'g.kode';
  3 : SearchCategories := 'd.kode';
  4 : SearchCategories := 'd.nama';
  5 : SearchCategories := 'l.nama';
  end;

  strfilter := '';
  if SellTxtSearch.Text<>'' then strfilter := 'and ('+SearchCategories + ' like ' + Quotedstr(SellTxtSearch.Text + '%') + ') ';

  case RGgroup.ItemIndex of
  0 : DataModule1.frxReport1.LoadFromFile(vpath+'Report\selling.fr3');
  1 :
  begin
   DataModule1.ZQrysellinggol.Close;
   DataModule1.ZQrysellinggol.SQL.Text := 'select g.kode,g.nama,count(d.kode) frek,sum(d.quantity) qty,sum(d.diskon*d.quantity*d.hargajual*0.01) disc, sum(d.subtotal) subtotal, sum(d.quantity*d.hargabeli) modal from selldetail d ' +
                                          'left join sellmaster s on d.faktur=s.faktur ' +
                                          'left join product p on d.kode=p.kode ' +
                                          'left join golongan g on p.IDgolongan=g.IDgolongan ' +
                                          'left join sales l on s.IDsales=l.IDsales ' +
                                          'where (s.isposted = 1) and (s.tanggal between '+Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date))+' and '+Quotedstr(getmysqldatestr(SellTxtSearchLast.Date))+') '+ strfilter +
                                          'group by g.kode,g.nama order by g.kode,g.nama ';
   DataModule1.ZQrysellinggol.Open;


   DataModule1.frxReport1.LoadFromFile(vpath+'Report\sellinggol.fr3');
  end;
  2 :
  begin
   if trim(edt_nama.Text)<>'' then strfilter := strfilter + ' and ((p.nama like ' + Quotedstr('%' + trim(edt_nama.Text) + '%') + ')or(p.kode like ' + Quotedstr('%' + trim(edt_nama.Text) + '%') + ')) ';

   DataModule1.ZQrysellingitem.Close;
   DataModule1.ZQrysellingitem.SQL.Text := 'select p.kode,p.nama,sum(d.quantity) qty,avg(d.hargajual) harga, sum((d.diskon*d.quantity*d.hargajual*0.01)+d.diskon_rp) diskon'+', sum(d.subtotal) subtotal,avg(d.hargabeli) hargabeli,sum(d.quantity*d.hargabeli) modal from selldetail d ' +
                                           'left join sellmaster s on d.faktur=s.faktur '+
                                           'left join product p on d.kode=p.kode ' +
                                           'where (s.isposted = 1) and (s.tanggal between '+Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date))+' and '+Quotedstr(getmysqldatestr(SellTxtSearchLast.Date))+') '+ strfilter + ' group by d.kode order by p.kode';
   DataModule1.ZQrysellingitem.Open;


   DataModule1.frxReport1.LoadFromFile(vpath+'Report\sellingitem.fr3');
  end;
  3 :
  begin
   DataModule1.ZQrysellingkasir.Close;
   DataModule1.ZQrysellingkasir.SQL.Text := 'select left(s.faktur,2) nokasir,s.kasir,sum(s.subtotal) subtotal,sum(s.discrp+s.discbulat) diskon,sum(s.grandtotal) totaljual,sum(s.bayartunai-s.kembali) tunai,sum(s.bayarcard) card,sum(s.totalretur) totalretur from sellmaster s ' +
                                            'where (s.isposted = 1) and (s.tanggal between '+Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date))+' and '+Quotedstr(getmysqldatestr(SellTxtSearchLast.Date))+') '+ strfilter + ' group by nokasir,kasir order by nokasir,kasir';
   DataModule1.ZQrysellingkasir.Open;


   DataModule1.frxReport1.LoadFromFile(vpath+'Report\sellingkasir.fr3');
  end;
  4 :
  begin
   DataModule1.ZQrysellingtop.Close;
   DataModule1.ZQrysellingtop.SQL.Text := 'select p.kode,p.barcode,p.nama,(p.'+kodegudang+'+p.'+kodegudang+'T) stok,sum(d.quantity) qty,p.hargajual from selldetail d ' +
                                          'left join sellmaster s on d.faktur=s.faktur '+
                                          'left join product p on d.kode=p.kode ' +
                                          'left join sales l on s.IDsales=l.IDsales ' +
                                          'where (s.isposted = 1) and (s.tanggal between '+Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date))+' and '+Quotedstr(getmysqldatestr(SellTxtSearchLast.Date))+') '+ strfilter +
                                          'group by p.kode,p.barcode,p.nama,stok,p.hargajual ' +
                                          'having qty>0 ' +
                                          'order by qty desc limit '+floattostr(edtnum_terlakutop.value);

   DataModule1.ZQrysellingtop.Open;


   DataModule1.frxReport1.LoadFromFile(vpath+'Report\sellingtop.fr3');
  end;

  end;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  ketstr := '';
  if (SellTxtSearch.Text<>'')and(SellTxtSearchby.ItemIndex>=0) then ketstr := ' (' + uppercase(SellTxtSearchby.Text) + ' : ' + SellTxtSearch.Text + '...)';

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));
  if RGGroup.itemindex=4 then FrxMemo.Memo.Text := 'BARANG TERLAKU TOP '+floattostr(edtnum_terlakutop.value)+ketstr
  else FrxMemo.Memo.Text := 'LAPORAN PENJUALAN'+ketstr;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglJual'));
  FrxMemo.Memo.Text := 'Tanggal ' + FormatDateTime('dd/MM/yyyy',SellTxtSearchFirst.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',SellTxtSearchLast.Date);

  DataModule1.frxReport1.ShowReport();

  DataModule1.ZQrysellingitem.Close;
  DataModule1.ZQrysellingkasir.Close;
  DataModule1.ZQrysellinggol.Close;
  DataModule1.ZQrysellingtop.Close;
end;

procedure TFrmsellmaster.SellBtnDelClick(Sender: TObject);
var
  Qs: string;
begin
  if DataModule1.ZQrySellMaster.IsEmpty then Exit;
  with DataModule1.ZQrySearch do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from returjualmaster ');
    SQL.Add('where fakturjual = "' + DataModule1.ZQrySellMasterfaktur.Value + '"');
    Open;
    if not IsEmpty then
    begin
      ErrorDialog('Penjualan tidak bisa dibatalkan karena sudah ada retur');
      Exit;
    end;
  end;
  if DataModule1.ZQrySellMasterisposted.Value = 0 then
    Qs := 'Hapus '
  else
    Qs := 'Faktur ' + DataModule1.ZQrySellMasterfaktur.Value + ' sudah diposting !' + #13+#10 + 'Batalkan ';
  if QuestionDialog(Qs + 'penjualan ' + DataModule1.ZQrySellMasterfaktur.Value + ' ?') = True then
  begin
    if Qs = 'Hapus ' then
    begin
      LogInfo(UserName,'Menghapus faktur penjualan ' + DataModule1.ZQrySellMasterfaktur.Text + ', nilai penjualan : ' + FormatCurr('Rp ###,##0',DataModule1.ZQrySellMastergrandtotal.Value));
      with DataModule1.ZQryFunction do
      begin
        Close;
        SQL.Clear;
        SQL.Add('delete from selldetail');
        SQL.Add('where faktur = ' + QuotedStr(DataModule1.ZQrySellMasterfaktur.Value));
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('delete from sellmaster');
        SQL.Add('where faktur = ' + QuotedStr(DataModule1.ZQrySellMasterfaktur.Value));
        ExecSQL;

        ///Hapus data di inventory
        Close;
        SQL.Clear;
        SQL.Add('delete from inventory');
        SQL.Add('where faktur = ' + QuotedStr(DataModule1.ZQrySellMasterfaktur.Value)  + ' and typetrans = ' + Quotedstr('penjualan') );
        ExecSQL;
      end;
      InfoDialog('Faktur ' + DataModule1.ZQrySellMasterfaktur.Value + ' berhasil dihapus !');
    end
    else
    begin
      LogInfo(UserName,'Membatalkan faktur penjualan ' + DataModule1.ZQrySellMasterfaktur.Text + ', nilai penjualan : ' + FormatCurr('Rp ###,##0',DataModule1.ZQrySellMastergrandtotal.Value));
      with DataModule1.ZQryFunction do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update selldetail set');
        SQL.Add('isposted = ''' + '-1' + '''');
        SQL.Add('where faktur = ''' + DataModule1.ZQrySellMasterfaktur.Value + '''');
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('update sellmaster set');
        SQL.Add('isposted = ''' + '-1' + '''');
        SQL.Add('where faktur = ''' + DataModule1.ZQrySellMasterfaktur.Value + '''');
        ExecSQL;

        ///Hapus data di operasional
        Close;
        SQL.Clear;
        SQL.Add('delete from operasional');
        SQL.Add('where (faktur = ' + Quotedstr(DataModule1.ZQrySellMasterfaktur.Value) + ') and ((kategori = '+ Quotedstr('PENJUALAN') + ') or (kategori = '+ Quotedstr('FEE BIRO') + ') or (kategori = '+ Quotedstr('FEE DRIVER') + '))' );
        ExecSQL;

        ///Hapus data di hutang

        ///Hapus data di inventory
        Close;
        SQL.Clear;
        SQL.Add('delete from inventory');
        SQL.Add('where faktur = ' + Quotedstr(DataModule1.ZQrySellMasterfaktur.Value) + ' and typetrans = ' + Quotedstr('penjualan') );
        ExecSQL;
      end;
      InfoDialog('Faktur ' + DataModule1.ZQrySellMasterfaktur.Value + ' berhasil dibatalkan !');
    end;
    ///Hitung Ulang Sum of Total
    if Trim(SellTxtSearch.Text) = '' then SellBtnClearClick(Self)
    else SellBtnSearchClick(Self);
  end;
end;

procedure TFrmsellmaster.SellBtnPrintListClick(Sender: TObject);
begin
  PrintListPenjualanItem;

end;

procedure TFrmsellmaster.SellBtnPrintStruckClick(Sender: TObject);
var FrxMemo: TfrxMemoView;
    F : TextFile;
    i : integer;
    nmfile,vcardbank,vcardno : string;
    totqty : single;
begin
  ///Hanya berlaku untuk yang sudah diposting saja
  ///(Sebagai Backup jika ada trouble pada saat pencetakan struck
{  if DataModule1.ZQrySellMasterisposted.Value <> 1 then
  begin
    ErrorDialog('Faktur ' + DataModule1.ZQrySellMasterfaktur.Value + ' belum diposting !');
    Exit;
  end;     }
  if (DataModule1.ZQrySellMaster.IsEmpty)or(DataModule1.ZQrySellMasterfaktur.IsNull) then
  begin
   ErrorDialog('Tidak ada Faktur !');
   exit;
  end;

 // ClearTabel('formsell where ipv='+ Quotedstr(ipcomp) );
  DataModule1.ZConnection1.ExecuteDirect('truncate formsell'+standpos);

  DataModule1.ZConnection1.ExecuteDirect('insert into formsell'+standpos+' '+
    ' (ipv,faktur,kode,nama,kategori,merk,seri,harga,diskon,diskonrp,diskon_rp,quantity,hargabeli,satuan,subtotal)' +
    ' select '+Quotedstr(ipcomp)+',faktur,kode,nama,kategori,merk,seri,hargajual,diskon,diskonrp,diskon_rp,quantity,hargabeli,satuan,subtotal from selldetail' +
    ' where faktur = "' + DataModule1.ZQrySellMasterfaktur.Value + '" order by kode');

  DataModule1.ZQryFormSell.Close;
  DataModule1.ZQryFormSell.SQL.Text := 'select * from formsell'+standpos+' where ipv='+Quotedstr(ipcomp)+' order by kode ';
  RefreshTabel(DataModule1.ZQryFormSell);

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
   Writeln(F,' Nota No.'+DataModule1.ZQrySellMasterfaktur.Value);
   Writeln(F,' Tgl.'+FormatDatetime('dd/mm/yyyy',DataModule1.ZQrySellMastertanggal.Value));
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
   Writeln(F,'        Subtotal       : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterSubTotal.value));
   Writeln(F,'        Disc '+FormatFloat('###,##0', DataModule1.ZQrySellMasterdiscpct.value)+'%        : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterdiscrp.value));
   Writeln(F,'        Disc Pembulatan: Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterdiscbulat.value));
   Writeln(F,'        Total          : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMastergrandtotal.value));
   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        Cash           : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterbayartunai.value));
   Writeln(F,'        Card           : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterbayarcard.value));
   Writeln(F,'        ---------------------------- ');
   Writeln(F,'        ' + inttostr(DataModule1.ZQryFormSell.RecordCount)+' Item Dibayar: Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterbayartunai.Value + DataModule1.ZQrySellMasterbayarcard.Value));
//   Writeln(F,' DISKON PEMBULATAN....Rp.'+FormatFloat('###,##0', edtnum_discbulat.Value));
   Writeln(F,'        ' + FormatFloat(',0.###;(,0.###);0',totqty) +' Pcs Kembali : Rp.'+FormatFloat('###,##0', DataModule1.ZQrySellMasterkembali.Value));
   Writeln(F,' ----------------------------------- ');

   vcardbank:=''; vcardno:='';
   if (DataModule1.ZQrySellMastercardbank.IsNull=false) then vcardbank:=DataModule1.ZQrySellMastercardbank.value;
   if (DataModule1.ZQrySellMastercardno.IsNull=false) then vcardno:=DataModule1.ZQrySellMastercardno.value;
   Writeln(F,' '+ vcardbank +' '+vcardno);
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

   cetakFile(nmfile);
  end
  else
  begin
  DataModule1.frxReport1.LoadFromFile(vpath+'Report\fakturpenjualan.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('NoNota'));
  FrxMemo.Memo.Text := DataModule1.ZQrySellMasterfaktur.Value;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglNota'));
  FrxMemo.Memo.Text := 'Tanggal : ' + FormatDatetime('dd/mm/yyyy',DataModule1.ZQrySellMastertanggal.Value);


  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('ItemSubTotal'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)', DataModule1.ZQrySellMasterSubTotal.value);


  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('diskonbulat'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',DataModule1.ZQrySellMasterdiscbulat.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('bayar'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',DataModule1.ZQrySellMasterbayartunai.Value + DataModule1.ZQrySellMasterbayarcard.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('diskonbulat2'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',DataModule1.ZQrySellMasterdiscbulat.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('kembali'));
  FrxMemo.Memo.Text := FormatFloat(',0;(,0)',DataModule1.ZQrySellMasterkembali.value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Kasir'));
  FrxMemo.Memo.Text := 'Printed By ' + DataModule1.ZQrySellMasterkasir.value + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',getnow);

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
  if DataModule1.ZQrySellMastergrandtotal.Value>=Datamodule1.ZQrystrukmintrans.Value then
  begin
   FrxMemo.Memo.Add(Datamodule1.ZQrystrukendfooter1.Value);
   FrxMemo.Memo.Add(Datamodule1.ZQrystrukendfooter2.Value);
   FrxMemo.Memo.Add(Datamodule1.ZQrystrukendfooter3.Value);
  end;

  Datamodule1.ZQrystruk.Close;

  DataModule1.frxReport1.ShowReport();
  end;
end;

procedure TFrmsellmaster.SellBtnSearchClick(Sender: TObject);
var
  SearchCategories: string;
begin
  if (Trim(SellTxtSearch.Text) = '')and(SellTxtSearchby.ItemIndex>=0) then Exit;
  case SellTxtSearchby.ItemIndex of
  0 : SearchCategories := 's.faktur like ''' + SellTxtSearch.Text + '%' + ''' ';
  1 : SearchCategories := 's.kasir like ''' + SellTxtSearch.Text + '%' + ''' ';
  2 : SearchCategories := 'l.nama like ''' + SellTxtSearch.Text + '%' + ''' ';
  3 : SearchCategories := 'c.nama like ''' + SellTxtSearch.Text + '%' + ''' ';
  4 : SearchCategories := 'concat(g.norental,if(g.norental="","","/"),g.nogroup) like ''' + SellTxtSearch.Text + '%' + ''' ';
  end;

  with DataModule1.ZQrySellMaster do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select s.*,l.nama nmsales,c.nama nmcust,concat(g.norental,if(g.norental="","","/"),g.nogroup) nogrp,sum(d.quantity*d.hargabeli) modal from sellmaster s ');
    SQL.Add('left join selldetail d on s.faktur=d.faktur ');
    SQL.Add('left join sales l on s.idsales=l.idsales ');
    SQL.Add('left join customer c on s.IDcustomer=c.IDcustomer ');
    SQL.Add('left join selltourgroup g on s.IDselltourgroup=g.IDselltourgroup ');

    SQL.Add('where ' + SearchCategories );
    SQL.Add('and s.isposted <> -1 ');

    SQL.Add('and s.tanggal between ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchFirst.Date) + ''' ');
    SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchLast.Date) + ''' group by s.faktur ');

    Open;
    Last;
  end;

  ///cari total nilai jual
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select sum(s.grandtotal) from sellmaster s left join sales l on s.IDsales=l.IDsales ');
    SQL.Add('left join customer c on s.IDcustomer=c.IDcustomer ');
    SQL.Add('left join selltourgroup g on s.IDselltourgroup=g.IDselltourgroup ');

//    if SellTxtSearchby.ItemIndex<2 then
//    begin
     SQL.Add('where ' + SearchCategories );
     SQL.Add('and s.isposted <> -1 ');
//    end
//    else SQL.Add('where s.isposted <> -1 ');

    SQL.Add('and s.tanggal between ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchFirst.Date) + ''' ');
    SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchLast.Date) + ''' ');
    Open;
    SellTxtTotalJual.Value := Fields[0].AsFloat;
    Close;
  end;

  SellBtnPrintList.Enabled := true;
end;

procedure TFrmsellmaster.SellBtnClearClick(Sender: TObject);
begin
  with DataModule1.ZQrySellMaster do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select s.*,l.nama nmsales,c.nama nmcust,concat(g.norental,if(g.norental="","","/"),g.nogroup) nogrp,sum(d.quantity*d.hargabeli) modal from sellmaster s ');
    SQL.Add('left join selldetail d on s.faktur=d.faktur ');
    SQL.Add('left join sales l on s.idsales=l.idsales ');
    SQL.Add('left join customer c on s.IDcustomer=c.IDcustomer ');
    SQL.Add('left join selltourgroup g on s.IDselltourgroup=g.IDselltourgroup ');
    SQL.Add('where (s.tanggal between ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchFirst.Date) + ''' ');
    SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchLast.Date) + ''') ');
    SQL.Add('and (s.isposted <> -1) group by s.faktur ');
    Open;
    Last;
  end;

  SellTxtSearchBy.ItemIndex  :=  0;
//  SellTxtSearchBychange(sender);
  SellTxtSearch.Text := '';

  ///Cari Total Nilai Jual
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select sum(grandtotal) from sellmaster');
      SQL.Add('where (tanggal between ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchFirst.Date) + '''');
      SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',SellTxtSearchLast.Date) + ''') ');
      SQL.Add('and (isposted <> -1) ');
    Open;
    SellTxtTotalJual.Value := Fields[0].AsFloat;
    Close;
  end;

  SellBtnPrintList.Enabled := true;

end;

procedure TFrmsellmaster.PenjualanDBDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DataModule1.ZQrySellMasterisposted.Value <> 0 then
    PenjualanDB.Canvas.Brush.Color := $00A8FFA8
  else
    PenjualanDB.Canvas.Brush.Color := clWindow;
  PenjualanDB.DefaultDrawColumnCell(Rect, DataCol, Column, State);


end;

procedure TFrmsellmaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
// if ShowDetail=false then

 DataModule1.ZQrySellMaster.Close;

end;

procedure TFrmsellmaster.SellTxtSearchbyChange(Sender: TObject);
begin
  SellBtnPrintList.Enabled := true;

end;

procedure TFrmsellmaster.ZQrySellMasterAfterScroll(DataSet: TDataSet);
begin
end;

procedure TFrmsellmaster.FormShow(Sender: TObject);
begin
  Panelpenjualan.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelpenjualan.Color := $00808040;

end;

end.
