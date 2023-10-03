unit frmProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, RzCmboBx, Mask, RzEdit, RzPanel,
  AdvSmoothButton, RzLabel, ExtDlgs, JPEG, RzButton, RzRadChk, strutils, DB;

type
  TfrmProd = class(TForm)
    PanelProd: TRzPanel;
    RzPanel2: TRzPanel;
    ProdLblCaption: TRzLabel;
    RzPanel3: TRzPanel;
    RzLabel12: TRzLabel;
    RzLabel14: TRzLabel;
    ProdBtnAdd: TAdvSmoothButton;
    ProdBtnDel: TAdvSmoothButton;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    ProdTxtNama: TRzEdit;
    ProdTxtKategori: TRzComboBox;
    RzLabel5: TRzLabel;
    ProdTxtSatuan: TRzComboBox;
    RzLabel7: TRzLabel;
    ProdTxtHrgJual: TRzNumericEdit;
    RzLabel9: TRzLabel;
    ProdTxtNonEfektif: TRzDateTimeEdit;
    RzLabel16: TRzLabel;
    ProdTxtMerk: TRzEdit;
    RzLabel18: TRzLabel;
    ProdTxtSeri: TRzEdit;
    ProdTxtKeterangan: TRzEdit;
    RzLabel22: TRzLabel;
    ProdTxtKode: TRzEdit;
    RzLabel8: TRzLabel;
    RzLabel10: TRzLabel;
    ProdTxtDiskon: TRzNumericEdit;
    ProdTxtDiskonRp: TRzNumericEdit;
    RzLabel6: TRzLabel;
    ProdTxtQty: TRzNumericEdit;
    RzLabel1: TRzLabel;
    ProdTxtHrgBeli: TRzNumericEdit;
    lbl_rsk: TRzLabel;
    ProdTxtQtyrsk: TRzNumericEdit;
    RzLabel11: TRzLabel;
    edt_barcode: TRzEdit;
    RzLabel13: TRzLabel;
    edtnum_reorderqty: TRzNumericEdit;
    RzLabel15: TRzLabel;
    dte_expdate: TRzDateTimeEdit;
    RzLabel17: TRzLabel;
    RzLabel19: TRzLabel;
    edtnum_feebiro: TRzNumericEdit;
    edtnum_feedrivertl: TRzNumericEdit;
    RzLabel20: TRzLabel;
    RzLabel21: TRzLabel;
    RzLabel23: TRzLabel;
    edtnum_margin: TRzNumericEdit;
    RzLabel24: TRzLabel;
    RzLabel25: TRzLabel;
    RzLabel26: TRzLabel;
    RzLabel27: TRzLabel;
    edtnum_feerent: TRzNumericEdit;
    procedure ProdBtnAddClick(Sender: TObject);
    procedure ProdBtnDelClick(Sender: TObject);
//    procedure ProdImageDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProdTxtKategoriChange(Sender: TObject);
    procedure edtnum_marginChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure FillCombo;
    procedure InsertData;
    procedure UpdateData;
    function  getkodeproduct : string;
    { Private declarations }
  public
    PicPath: string;
    procedure FormShowFirst;
    { Public declarations }
  end;

var
  frmProd: TfrmProd;

implementation

uses productmaster, frmbuying, SparePartFunction, Data;

{$R *.dfm}

procedure TfrmProd.FillCombo;
begin
  Fill_ComboBox_with_Data_n_ID(ProdTxtKategori,'select IDgolongan,nama from golongan order by nama','nama','IDgolongan');
  FillComboBox('distinct Satuan','product',ProdTxtSatuan,false,'Satuan');

end;

procedure TfrmProd.InsertData;
begin
  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into product');
    SQL.Add('(kode,nama,merk,seri,satuan,IDgolongan,hargajual,hargabeli,margin,feebiro,feedrivertl,feerent,');
    SQL.Add('keterangan,diskon,diskonrp,barcode,reorderqty,expdate,tglnoneffective) values');
    SQL.Add('(' + QuotedStr(trim(ProdTxtKode.Text)) + ',');
    SQL.Add(QuotedStr(trim(ProdTxtNama.Text)) + ',');
    SQL.Add(QuotedStr(trim(ProdTxtMerk.Text)) + ',');
    SQL.Add(QuotedStr(trim(ProdTxtSeri.Text)) + ',');
    SQL.Add(QuotedStr(trim(ProdTxtSatuan.Text)) + ',');
    SQL.Add(inttoStr(longint(ProdTxtKategori.Items.Objects[ProdTxtKategori.ItemIndex])) + ',');
    SQL.Add(QuotedStr(Number2MySQL(ProdTxtHrgJual.Value)) + ',');
    SQL.Add(QuotedStr(Number2MySQL(ProdTxtHrgBeli.Value)) + ',');
    SQL.Add(QuotedStr(Number2MySQL(edtnum_margin.Value)) + ',');
    SQL.Add(QuotedStr(Number2MySQL(edtnum_feebiro.Value)) + ',');
    SQL.Add(QuotedStr(Number2MySQL(edtnum_feedrivertl.Value)) + ',');
    SQL.Add(QuotedStr(Number2MySQL(edtnum_feerent.Value)) + ',');
    SQL.Add(QuotedStr(trim(ProdTxtKeterangan.Text)) + ',');
    SQL.Add(QuotedStr(FloatToStr(ProdTxtDiskon.Value)) + ',');
    SQL.Add(QuotedStr(FloatToStr(ProdTxtDiskonRp.Value)) + ',');
    SQL.Add(QuotedStr(trim(edt_barcode.Text)) + ',');
    SQL.Add(QuotedStr(Floattostr(edtnum_reorderqty.value)) + ',');

    ///Set Tgl ke Null jika tgl tidak diisi
    if dte_expdate.Text = '' then
      SQL.Add('null,')
    else
      SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',dte_expdate.Date)) + ',');

    ///Set Tgl ke Null jika tgl tidak diisi
    if ProdTxtNonEfektif.Text = '' then
      SQL.Add('null)')
    else
      SQL.Add(QuotedStr(FormatDateTime('yyyy-MM-dd',ProdTxtNonEfektif.Date)) + ')');
    ExecSQL;
    ///Simpan Gambar
//    ProdImage.Picture.SaveToFile(PicturePath + '\' + ProdTxtKode.Text + '.jpg');

    ///Insert ke Inventory sebagai stock awal
 {   if ProdTxtQty.Value<>0 then
    begin
     Close;
     SQL.Clear;
     SQL.Add('insert into inventory');
     SQL.Add('(tgltrans,kodebrg,kodegudang,qty,satuan,waktu,username,typetrans) values ');
     SQL.Add('(' + QuotedStr(FormatDateTime('yyyy-MM-dd',TglSkrg)) + ',');
     SQL.Add(QuotedStr(ProdTxtKode.Text) + ',');
     SQL.Add(QuotedStr('TK') + ',');
     SQL.Add(QuotedStr(FloatToStr(ProdTxtQty.Value)) + ',');
     SQL.Add(QuotedStr(ProdTxtSatuan.Value) + ',');
     SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss',Now)) + ',');
     SQL.Add(QuotedStr(UserName) + ',');
     SQL.Add(QuotedStr('STOCK AWAL')+')');
     ExecSQL;
    end;

    if ProdTxtQtyrsk.Value<>0 then
    begin
     Close;
     SQL.Clear;
     SQL.Add('insert into inventory');
     SQL.Add('(tgltrans,kodebrg,kodegudang,qty,satuan,waktu,username,typetrans) values ');
     SQL.Add('(' + QuotedStr(FormatDateTime('yyyy-MM-dd',TglSkrg)) + ',');
     SQL.Add(QuotedStr(ProdTxtKode.Text) + ',');
     SQL.Add(QuotedStr('RSK') + ',');
     SQL.Add(QuotedStr(FloatToStr(ProdTxtQtyrsk.Value)) + ',');
     SQL.Add(QuotedStr(ProdTxtSatuan.Value) + ',');
     SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss',Now)) + ',');
     SQL.Add(QuotedStr(UserName) + ',');
     SQL.Add(QuotedStr('STOCK AWAL')+')');
     ExecSQL;
    end;   }

  end;

//  if (DataModule1.ZConnection1.Catalog='sparepart') then
//      DataModule1.ZConn2.ExecuteDirect(DataModule1.ZQryFunction.SQL.Text);

end;

procedure TfrmProd.UpdateData;
begin

  with DataModule1.ZQryFunction do
  begin
    Close;
    SQL.Clear;
    SQL.Add('update product set ');
    SQL.Add('kode = ' + QuotedStr(trim(ProdTxtKode.Text)) + ',');
    SQL.Add('nama = ' + QuotedStr(trim(ProdTxtNama.Text)) + ',');
    SQL.Add('merk = ' + QuotedStr(trim(ProdTxtMerk.Text)) + ',');
    SQL.Add('seri = ' + QuotedStr(trim(ProdTxtSeri.Text)) + ',');
    SQL.Add('satuan = ' + QuotedStr(trim(ProdTxtSatuan.Text)) + ',');
    SQL.Add('IDgolongan = ' + inttoStr(longint(ProdTxtKategori.Items.Objects[ProdTxtKategori.ItemIndex])) + ',');
    SQL.Add('hargajual = ' + QuotedStr(Number2MySQL(ProdTxtHrgJual.Value)) + ',');
    SQL.Add('hargabeli = ' + QuotedStr(Number2MySQL(ProdTxtHrgBeli.Value)) + ',');
    SQL.Add('margin = ' + QuotedStr(Number2MySQL(edtnum_margin.Value)) + ',');
    SQL.Add('feebiro = ' + QuotedStr(Number2MySQL(edtnum_feebiro.Value)) + ',');
    SQL.Add('feedrivertl = ' + QuotedStr(Number2MySQL(edtnum_feedrivertl.Value)) + ',');
    SQL.Add('feerent = ' + QuotedStr(Number2MySQL(edtnum_feerent.Value)) + ',');
    SQL.Add('keterangan = ' + QuotedStr(trim(ProdTxtKeterangan.Text)) + ',');
    SQL.Add('diskon = ' + QuotedStr(FloatToStr(ProdTxtDiskon.Value)) + ',');
    SQL.Add('diskonrp = ' + QuotedStr(FloatToStr(ProdTxtDiskonRp.Value)) + ',');
    SQL.Add('barcode = ' + QuotedStr(trim(edt_barcode.Text)) + ',');
    SQL.Add('reorderqty = ' + QuotedStr(Floattostr(edtnum_reorderqty.value)) + ',');

    ///Set Tgl ke Null jika tgl tidak diisi
    if dte_expdate.Text = '' then
      SQL.Add('expdate = null,')
    else
      SQL.Add('expdate = ' + QuotedStr(FormatDateTime('yyyy-MM-dd',dte_expdate.Date)) + ',');

    ///Set Tgl ke Null jika tgl tidak diisi
    if ProdTxtNonEfektif.Text = '' then
      SQL.Add('tglnoneffective = null')
    else
      SQL.Add('tglnoneffective = ' + QuotedStr(FormatDateTime('yyyy-MM-dd',ProdTxtNonEfektif.Date)) );
    SQL.Add('where IDproduct = ' + Datamodule1.ZQryProductIDproduct.AsString );
    ExecSQL;
    ///Simpan Gambar
//    ProdImage.Picture.SaveToFile(PicturePath + '\' + ProdTxtKode.Text + '.jpg');

 {   if (ProdTxtQty.Enabled)and(ProdTxtQty.Value<>DataModule1.ZQryProductqty.Value) then
    begin
     Close;
     SQL.Clear;
     SQL.Add('delete from inventory where kodebrg='+QuotedStr(ProdTxtKode.Text)+' and kodegudang='+QuotedStr('TK'));
     ExecSQL;

        ///Insert ke Inventory sebagai stock awal
     if ProdTxtQty.Value<>0 then
     begin
      Close;
      SQL.Clear;
      SQL.Add('insert into inventory');
      SQL.Add('(tgltrans,kodebrg,kodegudang,qty,satuan,waktu,username,typetrans) values ');
      SQL.Add('(' + QuotedStr(FormatDateTime('yyyy-MM-dd',TglSkrg)) + ',');
      SQL.Add(QuotedStr(ProdTxtKode.Text) + ',');
      SQL.Add(QuotedStr('TK') + ',');
      SQL.Add(QuotedStr(FloatToStr(ProdTxtQty.Value)) + ',');
      SQL.Add(QuotedStr(ProdTxtSatuan.Value) + ',');
      SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss',Now)) + ',');
      SQL.Add(QuotedStr(UserName) + ',');
      SQL.Add(QuotedStr('STOCK AWAL')+')');
      ExecSQL;
     end;
    end;

    if (ProdTxtQtyrsk.Enabled)and(ProdTxtQtyrsk.Value<>DataModule1.ZQryProductqtybad.Value) then
    begin
     Close;
     SQL.Clear;
     SQL.Add('delete from inventory where kodebrg='+QuotedStr(ProdTxtKode.Text)+' and kodegudang='+QuotedStr('RSK'));
     ExecSQL;

     if ProdTxtQtyrsk.Value<>0 then
     begin
      Close;
      SQL.Clear;
      SQL.Add('insert into inventory');
      SQL.Add('(tgltrans,kodebrg,kodegudang,qty,satuan,waktu,username,typetrans) values ');
      SQL.Add('(' + QuotedStr(FormatDateTime('yyyy-MM-dd',TglSkrg)) + ',');
      SQL.Add(QuotedStr(ProdTxtKode.Text) + ',');
      SQL.Add(QuotedStr('RSK') + ',');
      SQL.Add(QuotedStr(FloatToStr(ProdTxtQtyrsk.Value)) + ',');
      SQL.Add(QuotedStr(ProdTxtSatuan.Value) + ',');
      SQL.Add(QuotedStr(FormatDateTime('hh:nn:ss',Now)) + ',');
      SQL.Add(QuotedStr(UserName) + ',');
      SQL.Add(QuotedStr('STOCK AWAL')+')');
      ExecSQL;
     end;
    end;  }

  end;

//  if (DataModule1.ZConnection1.Catalog='sparepart') then
//      DataModule1.ZConn2.ExecuteDirect(DataModule1.ZQryFunction.SQL.Text);
  
end;

function TfrmProd.getkodeproduct : string;
var vkodegol : string;
begin
    vkodegol := trim(getdata('kode','golongan where IDgolongan='+inttoStr(longint(ProdTxtKategori.Items.Objects[ProdTxtKategori.ItemIndex]))));
    with DataModule1.ZQrySearch do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select max(right(trim(kode),3)) from product');
      SQL.Add('where trim(kode) like "' + copy(formatdatetime('yymm',tglskrg),2,3) + vkodegol + '%' + '"');
      Open;
      if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsString = '') then
        result := copy(formatdatetime('yymm',tglskrg),2,3) + vkodegol + '001'
      else
        result := copy(formatdatetime('yymm',tglskrg),2,3) + vkodegol + FormatCurr('000',Fields[0].AsInteger + 1);
      Close;
    end;
end;

procedure TfrmProd.FormShowFirst;
begin
  ipcomp := getComputerIP;

  FillCombo;
  if ProdLblCaption.Caption = 'Tambah Item' then
  begin
    ProdTxtKode.Enabled := True;
    ProdTxtQty.enabled := True;
    ProdTxtQtyrsk.enabled := True;
    ProdTxtHrgJual.enabled := True;
    ProdTxtHrgBeli.enabled := True;

    ProdTxtKode.Text := '';
    ProdTxtNama.Text := '';
    ProdTxtMerk.Text := '';
    ProdTxtSeri.Text := '';
    ProdTxtSatuan.Text := '';
    ProdTxtQty.Value := 0;
    ProdTxtQtyrsk.Value := 0;
    ProdTxtKategori.ItemIndex := -1;
    ProdTxtKategori.Text := '';
    ProdTxtHrgJual.Value := 0;
    ProdTxtHrgBeli.Value := 0;
    ProdTxtNonEfektif.Text := '';
    ProdTxtKeterangan.Text := '';
    ProdTxtDiskon.Value := 0;
    ProdTxtDiskonRp.Value := 0;
    edt_barcode.Text := '';
    edtnum_reorderqty.Value := 0;
    edtnum_margin.Value := 0;
    dte_expdate.Text := '';
    edtnum_feebiro.Value := 0;
    edtnum_feedrivertl.Value := 0;
    edtnum_feerent.Value := 0;

//    ProdImage.Picture := nil;
  end
  else
  begin
    ProdTxtKode.Text := '';
    ProdTxtNama.Text := '';
    ProdTxtMerk.Text := '';
    ProdTxtSeri.Text := '';
    ProdTxtSatuan.Text := '';
    ProdTxtQty.Value := 0;
    ProdTxtQtyrsk.Value := 0;
    ProdTxtKategori.ItemIndex := -1;
    ProdTxtKategori.Text := '';
    ProdTxtHrgJual.Value := 0;
    ProdTxtHrgBeli.Value := 0;
    ProdTxtNonEfektif.Text := '';
    ProdTxtKeterangan.Text := '';
    ProdTxtDiskon.Value := 0;
    ProdTxtDiskonRp.Value := 0;
    edt_barcode.Text := '';
    edtnum_reorderqty.Value := 0;
    edtnum_margin.Value := 0;
    dte_expdate.Text := '';
    edtnum_feebiro.Value := 0;
    edtnum_feedrivertl.Value := 0;
    edtnum_feerent.Value := 0;

    ProdTxtKode.Enabled := False;
//    ProdTxtQty.enabled    := (isDataExist('select kodebrg from inventory where kodebrg='+QuotedStr(DataModule1.ZQryProductkode.Text)+' and typetrans<>"STOCK AWAL" and kodegudang="TK" limit 1')=false);
//    ProdTxtQtyrsk.enabled := (isDataExist('select kodebrg from inventory where kodebrg='+QuotedStr(DataModule1.ZQryProductkode.Text)+' and typetrans<>"STOCK AWAL" and kodegudang="RSK" limit 1')=false);
//    ProdTxtHrgJual.enabled := (IDUserGroup=3);

    if DataModule1.ZQryProductkode.IsNull=false then
    ProdTxtKode.Text := DataModule1.ZQryProductkode.Text;

    if DataModule1.ZQryProductnama.IsNull=false then
    ProdTxtNama.Text := DataModule1.ZQryProductnama.Text;

    if DataModule1.ZQryProductmerk.IsNull=false then
    ProdTxtMerk.Text := DataModule1.ZQryProductmerk.Text;

    if DataModule1.ZQryProductseri.IsNull=false then
    ProdTxtSeri.Text := DataModule1.ZQryProductseri.Text;

    if DataModule1.ZQryProductsatuan.IsNull=false then
    ProdTxtSatuan.Text := DataModule1.ZQryProductsatuan.Text;

    if DataModule1.ZQryProductqty.IsNull=false then
    ProdTxtQty.Value := DataModule1.ZQryProductqty.Value;

    if DataModule1.ZQryProductqtybad.IsNull=false then
    ProdTxtQtyrsk.Value := DataModule1.ZQryProductqtybad.Value;

    if DataModule1.ZQryProducthargabeli.IsNull=false then
    ProdTxtHrgbeli.Value := DataModule1.ZQryProducthargabeli.Value;

    if DataModule1.ZQryProductmargin.IsNull=false then
    edtnum_margin.Value := DataModule1.ZQryProductmargin.Value;

    if DataModule1.ZQryProducthargajual.IsNull=false then
    ProdTxtHrgJual.Value := DataModule1.ZQryProducthargajual.Value;

    if DataModule1.ZQryProductexpdate.Text <> '' then
      dte_expdate.Date := DataModule1.ZQryProductexpdate.Value
    else
      dte_expdate.Text := '';

    if DataModule1.ZQryProducttglnoneffective.Text <> '' then
      ProdTxtNonEfektif.Date := DataModule1.ZQryProducttglnoneffective.Value
    else
      ProdTxtNonEfektif.Text := '';

    if DataModule1.ZQryProductketerangan.IsNull=false then
    ProdTxtKeterangan.Text := DataModule1.ZQryProductketerangan.Value;

    if DataModule1.ZQryProductdiskon.IsNull=false then
    ProdTxtDiskon.Value := DataModule1.ZQryProductdiskon.Value;

    if DataModule1.ZQryProductdiskonrp.IsNull=false then
    ProdTxtDiskonRp.Value := DataModule1.ZQryProductdiskonrp.Value;

    if DataModule1.ZQryProductbarcode.IsNull=false then
    edt_barcode.Text := DataModule1.ZQryProductbarcode.Value;

    if DataModule1.ZQryProductfeebiro.IsNull=false then
    edtnum_feebiro.Value := DataModule1.ZQryProductfeebiro.Value;

    if DataModule1.ZQryProductfeedrivertl.IsNull=false then
    edtnum_feedrivertl.Value := DataModule1.ZQryProductfeedrivertl.Value;

    if DataModule1.ZQryProductfeerent.IsNull=false then
    edtnum_feerent.Value := DataModule1.ZQryProductfeerent.Value;

    if DataModule1.ZQryProductIDgolongan.IsNull=false then
    ProdTxtKategori.itemindex := ProdTxtKategori.Items.IndexOfObject(TObject(DataModule1.ZQryProductIDgolongan.Value));

    if DataModule1.ZQryProductreorderqty.IsNull=false then
    edtnum_reorderqty.Value := DataModule1.ZQryProductreorderqty.Value;

    {    PicPath := PicturePath + '\' + DataModule1.ZQryProductkode.Text + '.jpg';
    if FileExists(PicPath) then
      ProdImage.Picture.LoadFromFile(PicPath); }
  end;
end;

procedure TfrmProd.ProdBtnAddClick(Sender: TObject);
var
  EmptyValue: Boolean;
begin
  if ProdTxtKode.Text='' then
  begin
   errorDialog('Masukkan Kode Item dahulu !');
   exit;
  end
  else if ProdTxtNama.Text='' then
  begin
   errorDialog('Masukkan Nama Item dahulu !');
   exit;
  end
{  else if ProdTxtMerk.Text='' then
  begin
   errorDialog('Masukkan Merk Item dahulu !');
   exit;
  end  }
  else if (ProdTxtKategori.Text='')or(ProdTxtKategori.ItemIndex=-1) then
  begin
   errorDialog('Masukkan Kategori Item dahulu !');
   exit;
  end
  else if ProdTxtsatuan.Text='' then
  begin
   errorDialog('Masukkan Satuan Item dahulu !');
   exit;
  end
  else if edtnum_reorderqty.Value<0 then
  begin
   errorDialog('Reorder Qty tidak boleh lebih kecil dari 0 !');
   exit;
  end
  else if ProdTxtHrgBeli.Value>=ProdTxtHrgJual.Value then
  begin
   errorDialog('Harga Jual lebih kecil atau sama dengan dari Harga Beli !');
   if IDusergroup<>1 then exit;
  end;

  with DataModule1.ZQrySearch do
  begin
    ///Check if exists
    Close;
    SQL.Clear;
    SQL.Add('select * from product');
    SQL.Add('where kode = ''' + ProdTxtKode.Text + '''');
    Open;
    EmptyValue := IsEmpty;
  end;

  if ProdLblCaption.Caption = 'Tambah Item' then
  begin
    if EmptyValue = False then
    begin
      InfoDialog('Kode ' + ProdTxtKode.Text + ' sudah terdaftar');
      Exit;
    end;

    DataModule1.ZConnection1.StartTransaction;
    try
    InsertData;
    LogInfo(UserName,'Insert Item kode: ' + ProdTxtKode.Text + ',nama: ' + ProdTxtNama.Text);
    DataModule1.ZConnection1.Commit;
    InfoDialog('Tambah Item ' + ProdTxtNama.Text + ' berhasil');
    except
     DataModule1.ZConnection1.Rollback;
     ErrorDialog('Gagal Simpan Item, coba ulangi Simpan lagi!');
    end;
  end
  else
  begin
    DataModule1.ZConnection1.StartTransaction;
    try
    UpdateData;
    LogInfo(UserName,'Edit Item kode: ' + ProdTxtKode.Text + ',nama: ' + ProdTxtNama.Text);
    DataModule1.ZConnection1.Commit;
    InfoDialog('Edit Item ' + ProdTxtNama.Text + ' berhasil');
    except
     DataModule1.ZConnection1.Rollback;
     ErrorDialog('Gagal Simpan Item, coba ulangi Simpan lagi!');
    end;
  end;

 if self.Tag = 1 then
 begin
  if DataModule1.ZQryFormBuy.State <> dsEdit then DataModule1.ZQryFormBuy.Append;
  DataModule1.ZQryFormBuyfaktur.Value := frmBuy.SellTxtNo.Text;
  DataModule1.ZQryFormBuykode.Value := trim(ProdTxtKode.Text);
  DataModule1.ZQryFormBuynama.Value := trim(ProdTxtnama.Text);;
  DataModule1.ZQryFormBuyharga.Value := ProdTxtHrgBeli.Value;
  DataModule1.ZQryFormBuyharganondiskon.Value := ProdTxtHrgJual.Value;
  DataModule1.ZQryFormBuykategori.Value := trim(ProdTxtKategori.Text);
  DataModule1.ZQryFormbuymerk.Value := trim(ProdTxtMerk.Text);
  DataModule1.ZQryFormbuyseri.Value := trim(ProdTxtSeri.Text);
  DataModule1.ZQryFormbuysatuan.Value := trim(ProdTxtSatuan.Text);
  DataModule1.ZQryFormBuybarcode.Value := trim(edt_barcode.Text);
  DataModule1.ZQryFormbuyipv.Value    := ipcomp;

  DataModule1.ZQryFormBuy.CommitUpdates;
  close;
  frmbuy.BuyDBGrid.SetFocus;
  frmbuy.BuyDBGrid.SelectedIndex := 5;

 end
 else Close;
end;

procedure TfrmProd.ProdBtnDelClick(Sender: TObject);
begin
  Close;

  if self.Tag = 1 then frmbuy.BuyDBGrid.SetFocus;
end;

{procedure TfrmProd.ProdImageDblClick(Sender: TObject);
begin
  frmGambar.ShowModal;
  if OpenPictureDialog1.Execute and OpenPictureDialog1.FileName= '' then
  begin
    ProdImage.Picture := nil;
    ProdTxtImage.Visible := True;
  end
  else
  begin
    ProdImage.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    ProdTxtImage.Visible := False;
  end;
end;  }

procedure TfrmProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// TUTUPFORM(Frmprod.Parent);
 if self.Tag = 0 then
 begin
  IF Frmproductmaster=nil then
  application.CreateForm(TFrmproductmaster,Frmproductmaster);
  Frmproductmaster.Align:=alclient;
  Frmproductmaster.Parent:=Self.Parent;
  Frmproductmaster.BorderStyle:=bsnone;
  Frmproductmaster.FormShowFirst;
  Frmproductmaster.Show;
 end;
end;

procedure TfrmProd.ProdTxtKategoriChange(Sender: TObject);
var vkodegol,vkode : string;
begin
 if (ProdTxtKategori.ItemIndex<=-1) then
 begin
  edt_barcode.Text := '';
  exit;
 end;

 vkodegol := getdata('kode','golongan where IDgolongan='+inttostr(longint(ProdTxtKategori.Items.Objects[ProdTxtKategori.ItemIndex])) );

 with DataModule1.ZQrySearch do
 begin
  Close;
  SQL.Clear;
  SQL.Add('select max(right(kode,4)) from product');
  SQL.Add('where IDgolongan=' + inttostr(longint(ProdTxtKategori.Items.Objects[ProdTxtKategori.ItemIndex])) );
  Open;
  if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsString = '') then
     ProdTxtKode.Text := vkodegol + '0001'
  else
     ProdTxtKode.Text := vkodegol + FormatCurr('0000',Fields[0].AsInteger + 1);
  Close;
 end;

{ with DataModule1.ZQrySearch do
 begin
  Close;
  SQL.Clear;
  SQL.Add('select max(right(trim(barcode),6)) from product');
  SQL.Add('where trim(barcode) like "' + ProdTxtKode.Text + '%' + '"');
  Open;
  if (isEmpty) or (Fields[0].IsNull) or (Fields[0].AsString = '') then
     edt_barcode.Text := ProdTxtKode.Text + '000001'
  else
     edt_barcode.Text := ProdTxtKode.Text + FormatCurr('000000',Fields[0].AsInteger + 1);
  Close;
 end;  }

 edt_barcode.Text := ProdTxtKode.Text;
end;

procedure TfrmProd.edtnum_marginChange(Sender: TObject);
begin
 ProdTxtHrgJual.Value := ProdTxtHrgBeli.Value + round(ProdTxtHrgBeli.Value*edtnum_margin.Value*0.01);
end;

procedure TfrmProd.FormShow(Sender: TObject);
begin
  Panelprod.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelprod.Color := $00808040;

end;

end.
