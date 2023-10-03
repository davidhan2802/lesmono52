unit memberabsensilist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, PDJDBGridex, RzEdit, StdCtrls, RzCmboBx, Mask,
  RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, frxClass;

type
  TFrmmemberabsensilist = class(TForm)
    PanelReturBeli: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel3: TRzLabel;
    RzGroupBox9: TRzGroupBox;
    RzLabel10: TRzLabel;
    RzLabel129: TRzLabel;
    cb_cardno: TRzComboBox;
    dte_tglawal: TRzDateTimeEdit;
    RtrBeliDBGrid: TPDJDBGridEx;
    pnl_del: TRzPanel;
    RtrBeliBtnDel: TAdvSmoothButton;
    RzLabel6: TRzLabel;
    cb_nama: TRzComboBox;
    pnl_cetak_faktur: TRzPanel;
    RzLabel204: TRzLabel;
    SellBtnPrintStruck: TAdvSmoothButton;
    dte_tglakhir: TRzDateTimeEdit;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    btn_printabsensi: TAdvSmoothButton;
    procedure RtrBeliBtnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cb_cardnoChange(Sender: TObject);
    procedure cb_namaChange(Sender: TObject);
    procedure dte_tglawalChange(Sender: TObject);
    procedure SellBtnPrintStruckClick(Sender: TObject);
    procedure btn_printabsensiClick(Sender: TObject);
  private
    { Private declarations }
    procedure tampil;
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmmemberabsensilist: TFrmmemberabsensilist;

implementation

uses SparePartFunction, U_cetak, Data;

{$R *.dfm}

procedure TFrmmemberabsensilist.FormShowFirst;
begin
  readandexecutesql_from_remotemysql;

  ipcomp := getComputerIP;

  pnl_del.Visible    := isdel;

  FillcomboBox('cardno','member',cb_cardno,false,'cardno',true);
  FillcomboBox('nama','member',cb_nama,false,'cardno',true);

  cb_cardno.ItemIndex := 0;
  cb_nama.ItemIndex := 0;

  dte_tglawal.Date := Tglskrg;
  dte_tglakhir.Date := Tglskrg;

  tampil;
end;

procedure TFrmmemberabsensilist.RtrBeliBtnDelClick(Sender: TObject);
var vsqlfromme : string;
begin
  if DataModule1.ZQrymemberabsensi.IsEmpty then Exit;

  if (lokasigudang<>DataModule1.ZQrymemberabsensilokasi.Value) then
  begin
   errordialog('Maaf, hanya ' + DataModule1.ZQrymemberabsensilokasi.Value + ' yang boleh hapus ini!');
  end;

  if QuestionDialog('Benar Hendak menghapus Absensi Member '+ DataModule1.ZQrymemberabsensinama.Value + ' pada tanggal '+ FormatDateTime('dd-MM-yyyy', DataModule1.ZQrymemberabsensitgl.Value) +' ?') then
  begin
   readandexecutesql_from_remotemysql;
   vsqlfromme := 'delete from memberabsensi where date(tgl) = ' + Quotedstr(FormatDateTime('yyyy-MM-dd',DataModule1.ZQrymemberabsensitgl.Value)) + ' and cardno = ' + Quotedstr(DataModule1.ZQrymemberabsensicardno.Value)+';';
   if Datamodule1.ZConnection1.ExecuteDirect(vsqlfromme) then
   begin
    write_and_sendsql_to_remotemysql('('+Quotedstr(vsqlfromme)+');');
    infodialog('Berhasil menghapus Absensi Member '+DataModule1.ZQrymemberabsensinama.Value+ ' pada tanggal ' + FormatDateTime('dd-MM-yyyy', DataModule1.ZQrymemberabsensitgl.Value) );
   end;
   tampil;
  end;
end;

procedure TFrmmemberabsensilist.tampil;
var strtgl : string;
begin
 strtgl := '';
 if (trim(dte_tglawal.Text)<>'')and(trim(dte_tglakhir.Text)<>'') then
   strtgl := 'and date(a.tgl) between ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglawal.Date)) + ' and ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglakhir.Date)) + ' '
 else if (trim(dte_tglawal.Text)='')and(trim(dte_tglakhir.Text)<>'') then
   strtgl := 'and date(a.tgl) <= ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglakhir.Date)) + ' '
 else if (trim(dte_tglawal.Text)<>'')and(trim(dte_tglakhir.Text)='') then
   strtgl := 'and date(a.tgl) >= ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglawal.Date)) + ' ';


  with DataModule1.ZQrymemberabsensi do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select a.nogroup, a.namatour, a.tgl, m.cardno, m.nama, a.lokasi, a.username, m.golongan, a.presentfee, getjumlmembergroup(a.nogroup,date(a.tgl)) jumlmbr from memberabsensi a ');
    SQL.Add('left join member m on a.cardno=m.cardno ');
    SQL.Add('where (1=1) ' + strtgl);
    if cb_cardno.ItemIndex>0 then SQL.Add('and a.cardno = ' + Quotedstr(cb_cardno.Text) );
    SQL.Add('order by a.nogroup,a.tgl,m.cardno ');
    Open;
  end;
end;

procedure TFrmmemberabsensilist.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 DataModule1.ZQrymemberabsensi.Close;
end;

procedure TFrmmemberabsensilist.FormShow(Sender: TObject);
begin
  Panelreturbeli.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelreturbeli.Color := $00808040;

end;

procedure TFrmmemberabsensilist.cb_cardnoChange(Sender: TObject);
begin
 cb_nama.ItemIndex := cb_cardno.ItemIndex;
 tampil;
end;

procedure TFrmmemberabsensilist.cb_namaChange(Sender: TObject);
begin
  cb_cardno.ItemIndex := cb_nama.ItemIndex;
  tampil;
end;

procedure TFrmmemberabsensilist.dte_tglawalChange(Sender: TObject);
begin
 tampil;
end;

procedure TFrmmemberabsensilist.SellBtnPrintStruckClick(Sender: TObject);
var
  F : TextFile;
  i,totrp : integer;
  nmfile,vnumstr : string;
begin
  nmfile := vpath + 'absensistruk.txt';

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQrystruk.Open;

   AssignFile(F,nmfile);
   Rewrite(F);
   Writeln(F,'   '+Datamodule1.ZQrystrukcompany.value);
   Writeln(F,' '+Datamodule1.ZQrystrukalamat.value);
   Writeln(F,' '+Datamodule1.ZQrystrukphone.value);
   Writeln(F,' =================================== ');
   Writeln(F,' ABSENSI MEMBER');
   Writeln(F,' Tanggal: ' + FormatDatetime('dd-mm-yyyy hh:nn:ss',DataModule1.ZQrymemberabsensitgl.Value));
   Writeln(F,' Lokasi : ' + DataModule1.ZQrymemberabsensilokasi.Value);
   Writeln(F,' Member : ' + DataModule1.ZQrymemberabsensicardno.value + ' ' + DataModule1.ZQrymemberabsensinama.value);
   Writeln(F,' Biro   : ' + DataModule1.ZQrymemberabsensinamatour.Value);
   Writeln(F,' Group  : ' + DataModule1.ZQrymemberabsensinogroup.value );
   Writeln(F,' ----------------------------------- ');
   i:=1;

   Writeln(F,'');
   Writeln(F,' Dibuat Oleh,       Mengetahui,');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,' (            )    (            )');
   Writeln(F,'');
   Writeln(F,'Reprinted By ' + UserName + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',getnow));
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,chr(27)+chr(105));
   Writeln(F,chr(27)+chr(112)+chr(0)+chr(50)+chr(250));

   CloseFile(F);

   Datamodule1.ZQrystruk.Close;

   cetakFile(nmfile);

end;

procedure TFrmmemberabsensilist.btn_printabsensiClick(Sender: TObject);
var FrxMemo: TfrxMemoView;
begin
 readandexecutesql_from_remotemysql;
 tampil;

 DataModule1.frxReport1.LoadFromFile(vpath+'Report\absensilist.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));
  FrxMemo.Memo.Text := 'LAPORAN ABSENSI MEMBER'+#13+ 'Periode '+FormatDateTime('dd/MM/yyyy',dte_tglawal.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',dte_tglakhir.Date);

  DataModule1.frxReport1.ShowReport();
end;

end.
