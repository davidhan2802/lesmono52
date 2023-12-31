unit retursellmaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, PDJDBGridex, RzEdit, StdCtrls, RzCmboBx, Mask,
  RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, frxClass;

type
  TFrmRtrJualMaster = class(TForm)
    PanelReturJual: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel3: TRzLabel;
    RzPanel48: TRzPanel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel7: TRzLabel;
    RtrJualBtnAdd: TAdvSmoothButton;
    RtrJualBtnEdit: TAdvSmoothButton;
    RtrJualBtnPosting: TAdvSmoothButton;
    RzGroupBox9: TRzGroupBox;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel75: TRzLabel;
    RzLabel129: TRzLabel;
    RzLabel156: TRzLabel;
    RtrJualBtnSearch: TAdvSmoothButton;
    RtrJualTxtSearch: TRzEdit;
    RtrJualTxtSearchBy: TRzComboBox;
    RtrJualBtnClear: TAdvSmoothButton;
    RtrJualTxtSearchFirst: TRzDateTimeEdit;
    RtrJualTxtSearchLast: TRzDateTimeEdit;
    RtrJualDBGrid: TPDJDBGridEx;
    pnl_cetak: TRzPanel;
    RzLabel171: TRzLabel;
    RzLabel172: TRzLabel;
    RtrJualBtnPrint: TAdvSmoothButton;
    RtrJualBtnPrintStruck: TAdvSmoothButton;
    pnl_del: TRzPanel;
    RtrJualBtnDel: TAdvSmoothButton;
    RzLabel6: TRzLabel;
    pnl_cetak_faktur: TRzPanel;
    RzLabel204: TRzLabel;
    RtrBtnPrintStruck: TAdvSmoothButton;
    RzLabel2: TRzLabel;
    edt_returpajakno: TRzEdit;
    procedure RtrJualDBGridDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure RtrJualBtnAddClick(Sender: TObject);
    procedure RtrJualBtnEditClick(Sender: TObject);
    procedure RtrJualBtnDelClick(Sender: TObject);
    procedure RtrJualBtnPostingClick(Sender: TObject);
    procedure RtrJualBtnPrintClick(Sender: TObject);
    procedure RtrJualBtnSearchClick(Sender: TObject);
    procedure RtrJualBtnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RtrBtnPrintStruckClick(Sender: TObject);
    procedure RtrJualTxtSearchByChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure PrintListReturJual;
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  FrmRtrJualMaster: TFrmRtrJualMaster;

implementation

uses SparePartFunction, Data;

{$R *.dfm}

procedure TFrmRtrJualMaster.FormShowFirst;
begin
  ipcomp := getComputerIP;

  pnl_del.Visible    := isdel;

  RtrJualTxtSearchFirst.Date := Tglskrg;
  RtrJualTxtSearchLast.Date  := TglSkrg;

  RtrJualBtnClearClick(Self);
end;

procedure TFrmRtrJualMaster.RtrJualDBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DataModule1.ZQryReturJualisposted.Value <> 0 then
    RtrJualDBGrid.Canvas.Brush.Color := $00D9D9FF
  else
    RtrJualDBGrid.Canvas.Brush.Color := clWindow;
  RtrJualDBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);


end;

procedure TFrmRtrJualMaster.RtrJualBtnAddClick(Sender: TObject);
begin
{  with frmRtrJual do
  begin
    LblCaption.Caption := 'Tambah Retur Penjualan';
    ShowModal;
  end;
  RefreshTabel(DataModule1.ZQryReturJual);
  if Trim(RtrJualTxtSearch.Text) = '' then RtrJualBtnClearClick(Self)
    else RtrJualBtnSearchClick(Self);
  DataModule1.ZQryReturJual.Last;
}
end;

procedure TFrmRtrJualMaster.RtrJualBtnEditClick(Sender: TObject);
begin
{  if DataModule1.ZQryReturJual.IsEmpty then Exit;
  if DataModule1.ZQryReturJualisposted.Value <> 0 then
  begin
    ErrorDialog('Faktur ' + DataModule1.ZQryReturJualfaktur.Value + ' tidak bisa diedit karena sudah diposting');
    Exit;
  end;
  with frmRtrJual do
  begin
    LblCaption.Caption := 'Edit Retur Penjualan';
    ShowModal;
  end;
  RefreshTabel(DataModule1.ZQryReturJual);
  if Trim(RtrJualTxtSearch.Text) = '' then RtrJualBtnClearClick(Self)
    else RtrJualBtnSearchClick(Self);
 }
end;

procedure TFrmRtrJualMaster.RtrJualBtnDelClick(Sender: TObject);
var
  Qs: string;
begin
  if DataModule1.ZQryReturJual.IsEmpty then Exit;
  if DataModule1.ZQryReturJualisposted.Value = 0 then
    Qs := 'Hapus Retur '
  else
    Qs := 'Faktur ' + DataModule1.ZQryReturJualfaktur.Value + ' sudah diposting !' + #13+#10 + 'Batalkan Retur ';
  if QuestionDialog(Qs + 'penjualan ' + DataModule1.ZQryReturJualfaktur.Value + ' ?') = True then
  begin
    if Qs = 'Hapus Retur ' then
    begin
      LogInfo(UserName,'Menghapus faktur retur penjualan ' + DataModule1.ZQryReturJualfaktur.Text + ', nilai penjualan : ' + FormatCurr('Rp ###,##0',DataModule1.ZQryReturJualtotalretur.Value));
      with DataModule1.ZQryFunction do
      begin
        Close;
        SQL.Clear;
        SQL.Add('delete from returjualdetail');
        SQL.Add('where faktur = ''' + DataModule1.ZQryReturJualfaktur.Value + '''');
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('delete from returjualmaster');
        SQL.Add('where faktur = ''' + DataModule1.ZQryReturJualfaktur.Value + '''');
        ExecSQL;
      end;
      InfoDialog('Faktur ' + DataModule1.ZQryReturJualfaktur.Value + ' berhasil dihapus !');
    end
    else
    begin
      LogInfo(UserName,'Membatalkan faktur retur penjualan ' + DataModule1.ZQryReturJualfaktur.Text + ', nilai retur penjualan : ' + FormatCurr('Rp ###,##0',DataModule1.ZQryReturJualtotalretur.Value));
      with DataModule1.ZQryFunction do
      begin
        {Close;
        SQL.Clear;
        SQL.Add('update returjualdetail set');
        SQL.Add('isposted = ''' + '-1' + '''');
        SQL.Add('where faktur = ''' + DataModule1.ZQryReturJualfaktur.Value + '''');
        ExecSQL;}

        Close;
        SQL.Clear;
        SQL.Add('update returjualmaster set');
        SQL.Add('isposted = ''' + '-1' + '''');
        SQL.Add('where faktur = ''' + DataModule1.ZQryReturJualfaktur.Value + '''');
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('update sellmaster set ');
        SQL.Add('totalretur = totalretur-'+ Quotedstr(DataModule1.ZQryReturJualtotalretur.AsString) +' ');
        SQL.Add('where faktur = ' + Quotedstr(DataModule1.ZQryReturJualfakturjual.AsString) );
        ExecSQL;

          {Close;
          SQL.Clear;
          SQL.Add('insert into operasional');
          SQL.Add('(idTrans,faktur,tanggal,waktu,kasir,kategori,keterangan,debet) values');
          SQL.Add('(''' + DataModule1.ZQrySellMasteridsell.AsString + ''',');
          SQL.Add('''' + DataModule1.ZQrySellMasterfaktur.Value + ''',');
          SQL.Add('''' + FormatDateTime('yyyy-MM-dd',TglSkrg) + ''',');
          SQL.Add('''' + FormatDateTime('hh:nn:ss',Now) + ''',');
          SQL.Add('''' + UserName + ''',');
          SQL.Add('''' + 'PEMBATALAN PENJUALAN TUNAI' + ''',');
          SQL.Add('''' + 'PEMBATALAN FAKTUR NO. ' + DataModule1.ZQrySellMasterfaktur.Value + ''',');
          SQL.Add('''' + FloatToStr(DataModule1.ZQrySellMastergrandtotal.Value) + ''')');
          ExecSQL;  }

        ///Hapus data di operasional
        Close;
        SQL.Clear;
        SQL.Add('delete from operasional ');
        SQL.Add('where faktur = ' + QuotedStr(DataModule1.ZQryReturJualfaktur.Value) + ' and kategori like "RETUR PENJUALAN%" ' );
        ExecSQL;

        ///Hapus data di hutang

        ///Hapus data di inventory
        Close;
        SQL.Clear;
        SQL.Add('delete from inventory');
        SQL.Add('where faktur=' + Quotedstr(DataModule1.ZQryReturJualfaktur.Value) + ' and typetrans=' + Quotedstr('retur penjualan') );
        ExecSQL;
      end;
      InfoDialog('Faktur ' + DataModule1.ZQryReturJualfaktur.Value + ' berhasil dibatalkan !');
    end;
    if Trim(RtrJualTxtSearch.Text) = '' then RtrJualBtnClearClick(Self)
      else RtrJualBtnSearchClick(Self);
  end;
end;

procedure TFrmRtrJualMaster.RtrJualBtnPostingClick(Sender: TObject);
begin
  ///frmRtrJual.PrintStruck(DataModule1.ZQryReturJualfaktur.Value);
  ///Exit;
{  if DataModule1.ZQryReturJual.IsEmpty then Exit;
  case DataModule1.ZQryReturJualisposted.Value of
  0 : begin
        if QuestionDialog('Posting Faktur ' + DataModule1.ZQryReturJualfaktur.Value + ' ?') = False then Exit;
        frmRtrJual.PostingReturJual(DataModule1.ZQryReturJualfaktur.Value);
{sementara ditutup if QuestionDialog('Cetak Struck untuk faktur ' + frmRtrJual.CetakFaktur + ' ?') = True then
          frmRtrJual.PrintStruck(frmRtrJual.CetakFaktur); }
 {     end;
  1 : begin
        ErrorDialog('Faktur ' + DataModule1.ZQryReturJualfaktur.Value + ' sudah diposting !');
        Exit;
      end;
  end;
  RefreshTabel(DataModule1.ZQryReturJual);   }
end;

procedure TFrmRtrJualMaster.PrintListReturJual;
var
  FrxMemo: TfrxMemoView;
  ketstr, SearchCategories, strfilter : string;
begin
  case RtrJualTxtSearchby.ItemIndex of
  0 : SearchCategories := 's.faktur';
  1 : SearchCategories := 's.customer';
  end;

  strfilter := '';
  if RtrJualTxtSearch.Text<>'' then strfilter := 'and ('+SearchCategories + ' like ' + Quotedstr(RtrJualTxtSearch.Text + '%') + ') ';
  DataModule1.ZQryreturitem.Close;
  DataModule1.ZQryreturitem.SQL.Text := 'select s.tanggal, s.faktur, s.customer, d.nama, d.qtyretur, d.hargajual, (d.qtyretur*d.hargajual) tot, (d.diskon*d.qtyretur*d.hargajual*0.01) disc, d.subtotal, d.keterangan from returjualdetail d ' +
                                        'inner join returjualmaster s on d.faktur=s.faktur where (s.isposted = 1) and (s.tanggal between '+Quotedstr(getmysqldatestr(RtrJualTxtSearchFirst.Date))+' and '+Quotedstr(getmysqldatestr(RtrJualTxtSearchLast.Date))+') '+ strfilter +'order by s.tanggal,s.faktur,d.nama';
  DataModule1.ZQryreturitem.Open;

  DataModule1.frxReport1.LoadFromFile(vpath+'Report\returitem.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  ketstr := '';
  if (RtrJualTxtSearch.Text<>'')and(RtrJualTxtSearchby.ItemIndex>=0) then ketstr := ' (' + uppercase(RtrJualTxtSearchby.Text) + ' : ' + RtrJualTxtSearch.Text + '...)';

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));
  FrxMemo.Memo.Text := 'LAPORAN RETUR PENJUALAN'+ketstr;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglJual'));
  FrxMemo.Memo.Text := 'Tanggal ' + FormatDateTime('dd/MM/yyyy',RtrJualTxtSearchFirst.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',RtrJualTxtSearchLast.Date);

  DataModule1.frxReport1.ShowReport();

  DataModule1.ZQryreturitem.Close;

end;

procedure TFrmRtrJualMaster.RtrJualBtnPrintClick(Sender: TObject);
begin
  if DataModule1.ZQryReturJual.IsEmpty then Exit;
  PrintListReturJual;

end;

procedure TFrmRtrJualMaster.RtrJualBtnSearchClick(Sender: TObject);
var
  SearchCategories: string;
begin
  if (Trim(RtrJualTxtSearch.Text) = '')and(RtrJualTxtSearchby.ItemIndex>=0) then Exit;
  case RtrJualTxtSearchBy.ItemIndex of
  0 : SearchCategories := 'r.faktur like ''' + RtrJualTxtSearch.Text + '%' + ''' ';
  1 : SearchCategories := 'r.customer like ''' + RtrJualTxtSearch.Text + '%' + ''' ';
  end;

  with DataModule1.ZQryReturJual do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select r.*,s.tanggal tglfaktur,s.fakturpajakno,c.nama namacust,c.alamat alamatcust,c.npwp npwpcust from returjualmaster r ');
    SQL.Add('left join sellmaster s on r.fakturjual=s.faktur ');
    SQL.Add('left join customer c on s.IDcustomer=c.IDcustomer ');
    SQL.Add('where ' + SearchCategories );
    SQL.Add('and r.isposted = 1 ');
    SQL.Add('and r.tanggal between ''' + FormatDateTime('yyyy-MM-dd',RtrJualTxtSearchFirst.Date) + ''' ');
    SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',RtrJualTxtSearchLast.Date) + ''' ');
    Open;
  end;

  RtrJualBtnPrint.Enabled := true;
end;

procedure TFrmRtrJualMaster.RtrJualBtnClearClick(Sender: TObject);
begin
  with DataModule1.ZQryReturJual do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select r.*,s.tanggal tglfaktur,s.fakturpajakno,c.nama namacust,c.alamat alamatcust,c.npwp npwpcust from returjualmaster r ');
    SQL.Add('left join sellmaster s on r.fakturjual=s.faktur ');
    SQL.Add('left join customer c on s.IDcustomer=c.IDcustomer ');
    SQL.Add('where (r.tanggal between ''' + FormatDateTime('yyyy-MM-dd',RtrJualTxtSearchFirst.Date) + ''' ');
    SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',RtrJualTxtSearchLast.Date) + ''') ');
    SQL.Add('and (r.isposted = 1) ');
    Open;
  end;
  RtrJualTxtSearch.Text := '';

  RtrJualTxtSearchBy.ItemIndex := 0;

  RtrJualBtnPrint.Enabled := true;
end;

procedure TFrmRtrJualMaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 DataModule1.ZQryReturJual.Close;
end;

procedure TFrmRtrJualMaster.RtrBtnPrintStruckClick(Sender: TObject);
var vfaktur : string;
begin
 if (DataModule1.ZQryReturJual.IsEmpty)or(DataModule1.ZQryReturJualfaktur.IsNull) then
 begin
  ErrorDialog('Tidak ada Retur !');
  exit;
 end;

 if (DataModule1.ZQryReturJualfakturpajakno.IsNull)or(trim(DataModule1.ZQryReturJualfakturpajakno.Value)='') then
 begin
  ErrorDialog('Belum Ada Faktur Pajaknya !');
  exit;
 end;

 if ((DataModule1.ZQryReturJualreturpajakno.IsNull)or(DataModule1.ZQryReturJualreturpajakno.Value=''))and(edt_returpajakno.Text='') then
 begin
  errordialog('Isi dahulu No. Retur Pajaknya!');
  exit;
 end;

 vfaktur := DataModule1.ZQryReturJualfaktur.Value;

 if (edt_returpajakno.Text<>'') then
  DataModule1.ZConnection1.ExecuteDirect('update returjualmaster set returpajakno='+Quotedstr(edt_returpajakno.Text)+
                                                                          ' where idReturJual='+DataModule1.ZQryReturJualidReturJual.AsString);

 DataModule1.ZQryReturJual.Close;
 DataModule1.ZQryReturJual.Open;
 try
  DataModule1.ZQryReturJual.Locate('faktur',vfaktur,[]);
 except RtrBtnPrintStruck.SetFocus;
 end;

 DataModule1.frxReport1.LoadFromFile(vpath+'Report\returpajak.fr3');

 ClearTabel('formretur where ipv='+ Quotedstr(ipcomp) );

 DataModule1.ZConnection1.ExecuteDirect('insert into formretur '+
    ' (ipv,faktur,nama,quantityretur,satuan,harga,diskon,diskon_rp,diskonrp,subtotal,fakturjual,seri,merk,kategori,kode)' +
    ' select '+Quotedstr(ipcomp)+',faktur,nama,qtyretur,satuan,hargajual,diskon,diskon_rp,diskonrp,subtotal,fakturjual,seri,merk,kategori,kode from returjualdetail' +
    ' where faktur = "' + DataModule1.ZQryReturJualfaktur.Value + '" order by kode');

 DataModule1.ZQryFormRetur.Close;
 DataModule1.ZQryFormRetur.SQL.Text := 'select * from formretur where ipv='+ Quotedstr(ipcomp) + ' order by kode ';
 RefreshTabel(DataModule1.ZQryFormRetur);

 DataModule1.frxReport1.ShowReport();

 DataModule1.ZQryFormRetur.Close;

 edt_returpajakno.Text := '';

end;
{var
  FrxMemo: TfrxMemoView;
begin
  if (DataModule1.ZQryReturJual.IsEmpty)or(DataModule1.ZQryReturJualfaktur.IsNull) then
  begin
   ErrorDialog('Tidak ada Retur !');
   exit;
  end;

  DataModule1.frxReport1.LoadFromFile(vpath+'Report\FakturReturJual.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('NoNota'));
  FrxMemo.Memo.Text := DataModule1.ZQryReturJualfaktur.Value;
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('TglNota'));
  FrxMemo.Memo.Text := FormatDatetime('dd/mm/yyyy',DataModule1.ZQryReturJualtanggal.Value);
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('NmCustomer'));
  FrxMemo.Memo.Text := DataModule1.ZQryReturJualcustomer.Value;
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('AlmCustomer'));
  FrxMemo.Memo.Text := DataModule1.ZQryReturJualalamat.Value + ' ' + DataModule1.ZQryReturJualkota.Value;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('ItemGrandTotal'));
  FrxMemo.Memo.Text := FormatCurr('Rp ###,##0',DataModule1.ZQryReturJualtotalretur.Value);

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Kasir'));
  FrxMemo.Memo.Text := 'Printed By ' + Username + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',now);

  ClearTabel('formretur where ipv='+ Quotedstr(ipcomp) );

  DataModule1.ZConnection1.ExecuteDirect('insert into formretur '+
    ' (ipv,faktur,nama,quantityretur,satuan,harga,diskon,diskon_rp,diskonrp,subtotal,fakturjual,seri,merk,kategori,kode)' +
    ' select '+Quotedstr(ipcomp)+',faktur,nama,qtyretur,satuan,hargajual,diskon,diskon_rp,diskonrp,subtotal,fakturjual,seri,merk,kategori,kode from returjualdetail' +
    ' where faktur = "' + DataModule1.ZQryReturJualfaktur.Value + '" order by kode');

  DataModule1.ZQryFormRetur.Close;
  DataModule1.ZQryFormRetur.SQL.Text := 'select * from formretur where ipv='+ Quotedstr(ipcomp) + ' order by kode ';
  RefreshTabel(DataModule1.ZQryFormRetur);

  DataModule1.frxReport1.ShowReport();

end;  }

procedure TFrmRtrJualMaster.RtrJualTxtSearchByChange(Sender: TObject);
begin
  RtrJualBtnPrint.Enabled := false;
end;

procedure TFrmRtrJualMaster.FormShow(Sender: TObject);
begin
  Panelreturjual.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelreturjual.Color := $00808040;

end;

end.
