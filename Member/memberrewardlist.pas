unit memberrewardlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, PDJDBGridex, RzEdit, StdCtrls, RzCmboBx, Mask,
  RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, frxClass;

type
  TFrmmemberrewardlist = class(TForm)
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
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    btn_printreward: TAdvSmoothButton;
    dte_tglakhir: TRzDateTimeEdit;
    RzPanel2: TRzPanel;
    RzLabel2: TRzLabel;
    btn_printrewardglobal: TAdvSmoothButton;
    RzPanel3: TRzPanel;
    RzLabel4: TRzLabel;
    btn_printoutstanding: TAdvSmoothButton;
    procedure RtrBeliBtnDelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cb_cardnoChange(Sender: TObject);
    procedure cb_namaChange(Sender: TObject);
    procedure dte_tglawalChange(Sender: TObject);
    procedure SellBtnPrintStruckClick(Sender: TObject);
    procedure btn_printrewardClick(Sender: TObject);
    procedure btn_printrewardglobalClick(Sender: TObject);
    procedure btn_printoutstandingClick(Sender: TObject);
  private
    { Private declarations }
    procedure tampil;
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  Frmmemberrewardlist: TFrmmemberrewardlist;

implementation

uses SparePartFunction, u_cetak, Data;

{$R *.dfm}

procedure TFrmmemberrewardlist.FormShowFirst;
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
  dte_tglawalChange(dte_tglawal);
end;

procedure TFrmmemberrewardlist.RtrBeliBtnDelClick(Sender: TObject);
var vsqlfromme,vsqlfromme2 : string;
begin
  if DataModule1.ZQrymemberreward.IsEmpty then Exit;

  if (lokasigudang<>DataModule1.ZQrymemberrewardlokasi.Value) then
  begin
   errordialog('Maaf, hanya ' + DataModule1.ZQrymemberrewardlokasi.Value + ' yang boleh hapus ini!');
  end;

  if QuestionDialog('Benar Hendak menghapus Print Reward Member No.Bukti'+ DataModule1.ZQrymemberrewardfaktur.AsString + ' pada tanggal '+formatdatetime('dd-mm-yyyy',DataModule1.ZQrymemberrewardtgl.Value) +' ?') then
  begin
   readandexecutesql_from_remotemysql;
   vsqlfromme  := 'update memberabsensi set faktur=null,isprint=0 where faktur = ' + Quotedstr(DataModule1.ZQrymemberrewardfaktur.AsString)+';';
   vsqlfromme2 := 'delete from memberreward where faktur = ' + Quotedstr(DataModule1.ZQrymemberrewardfaktur.AsString)+';';
   if Datamodule1.ZConnection1.ExecuteDirect(vsqlfromme) and Datamodule1.ZConnection1.ExecuteDirect(vsqlfromme2) then
   begin
    write_and_sendsql_to_remotemysql('('+Quotedstr(vsqlfromme)+'),('+Quotedstr(vsqlfromme2)+');');
    infodialog('Berhasil menghapus Print Reward Member No.Bukti'+ DataModule1.ZQrymemberrewardfaktur.AsString + ' pada tanggal '+formatdatetime('dd-mm-yyyy',DataModule1.ZQrymemberrewardtgl.Value) );
   end;
   tampil;
  end;
end;

procedure TFrmmemberrewardlist.tampil;
begin
  with DataModule1.ZQrymemberreward do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select r.*, m.nama, date(r.tgl) tgldate from memberreward r ');
    SQL.Add('left join member m on r.cardno=m.cardno ');
    SQL.Add('where date(r.tgl) between ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglawal.Date)) + ' and ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglakhir.Date)) + ' ');
    if cb_cardno.ItemIndex>0 then SQL.Add('and r.cardno = ' + Quotedstr(cb_cardno.Text) );
    SQL.Add('order by m.cardno,r.tgl');
    Open;
  end;
end;

procedure TFrmmemberrewardlist.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 DataModule1.ZQrymemberreward.Close;
end;

procedure TFrmmemberrewardlist.FormShow(Sender: TObject);
begin
  Panelreturbeli.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelreturbeli.Color := $00808040;

end;

procedure TFrmmemberrewardlist.cb_cardnoChange(Sender: TObject);
begin
 cb_nama.ItemIndex := cb_cardno.ItemIndex;
 tampil;
end;

procedure TFrmmemberrewardlist.cb_namaChange(Sender: TObject);
begin
  cb_cardno.ItemIndex := cb_nama.ItemIndex;
  tampil;
end;

procedure TFrmmemberrewardlist.dte_tglawalChange(Sender: TObject);
begin
 tampil;
end;

procedure TFrmmemberrewardlist.SellBtnPrintStruckClick(Sender: TObject);
var
  F : TextFile;
  i,totrp : integer;
  nmfile,vnumstr : string;
begin
  nmfile := vpath + 'rewardstruk.txt';

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQrystruk.Open;

   Datamodule1.ZQryUtil.Close;
   Datamodule1.ZQryUtil.SQL.Text := 'select nogroup,tgl,lokasi from memberabsensi '+
                                    'where faktur=' + Quotedstr(DataModule1.ZQrymemberrewardfaktur.AsString) + ' order by nogroup';
   Datamodule1.ZQryUtil.open;

   AssignFile(F,nmfile);
   Rewrite(F);
   Writeln(F,'   '+Datamodule1.ZQrystrukcompany.value);
   Writeln(F,' '+Datamodule1.ZQrystrukalamat.value);
   Writeln(F,' '+Datamodule1.ZQrystrukphone.value);
   Writeln(F,' =================================== ');
   Writeln(F,' REWARD MEMBER');
   Writeln(F,' No.Bukti: ' + DataModule1.ZQrymemberrewardfaktur.AsString);
   Writeln(F,' Tanggal : ' + FormatDatetime('dd-mm-yyyy',DataModule1.ZQrymemberrewardtgl.AsDateTime));
   Writeln(F,' Lokasi  : '  + DataModule1.ZQrymemberrewardlokasi.Value);
   Writeln(F,' Member  : ' + DataModule1.ZQrymemberrewardcardno.AsString + ' ' + DataModule1.ZQrymemberrewardnama.AsString);
   Writeln(F,' ----------------------------------- ');
   i:=1;

   DataModule1.ZQryutil.First;
   while not DataModule1.ZQryutil.Eof do
   begin
    if i<10 then vnumstr := inttostr(i)+'  ' else vnumstr := inttostr(i)+' ';

    Writeln(F,' '+vnumstr + FormatDatetime('dd-mm-yyyy',DataModule1.ZQryutil.Fields[1].Asdatetime) + ' [' + Datamodule1.ZQryUtil.Fields[0].AsString + '] ' + Datamodule1.ZQryUtil.Fields[2].AsString );
    Writeln(F,'');

    i := i + 1;
    DataModule1.ZQryutil.Next;
   end;

   Writeln(F,' ----------------------------------- ');
   Writeln(F,'                Total : Rp.' + FormatFloat('###,##0',DataModule1.ZQrymemberrewardtotalreward.Value));
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

   Datamodule1.ZQryUtil.Close;

   cetakFile(nmfile);
end;

procedure TFrmmemberrewardlist.btn_printrewardClick(Sender: TObject);
var strmember : string;
    FrxMemo: TfrxMemoView;
begin
 readandexecutesql_from_remotemysql;
 tampil;

 strmember := ' ';
 if cb_cardno.ItemIndex>0 then strmember := ' and r.cardno=' + Quotedstr(cb_cardno.Text) + ' ';

 Datamodule1.ZQryprintreward.close;
 Datamodule1.ZQryprintreward.SQL.text :=
  'select r.`faktur`,a.tgl,m.cardno,m.nama,m.golongan,a.`nogroup`,a.`namatour`,case when a.`jenisbus`=0 then "Bus Rental" when a.`jenisbus`=1 then "Bus Besar" when a.`jenisbus`=2 then "Bus Kecil" end jenis'+
  ',a.`rewardmember`,date(r.`tgl`) tglreward,u.username,r.tgl tglwktreward,a.lokasi from memberreward r ' +
  'left join member m on r.cardno=m.cardno ' +
  'left join memberabsensi a on r.`faktur`=a.faktur ' +
  'left join user u on r.`IDuser`=u.iduser '+
  'where date(r.`tgl`) between '+ Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglawal.Date)) + ' and ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglakhir.Date)) + strmember +
  'order by r.`faktur`,a.`tgl`,m.cardno ';
 Datamodule1.ZQryprintreward.Open;

 DataModule1.frxReport1.LoadFromFile(vpath+'Report\rewardlist.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));
  FrxMemo.Memo.Text := 'LAPORAN PENCAIRAN REWARD '+#13+ 'Periode '+FormatDateTime('dd/MM/yyyy',dte_tglawal.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',dte_tglakhir.Date);

  DataModule1.frxReport1.ShowReport();


 Datamodule1.ZQryprintreward.close;

end;

procedure TFrmmemberrewardlist.btn_printrewardglobalClick(Sender: TObject);
var FrxMemo: TfrxMemoView;
begin
  readandexecutesql_from_remotemysql;
  tampil;

  DataModule1.frxReport1.LoadFromFile(vpath+'Report\rewardglist.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));
  FrxMemo.Memo.Text := 'LAPORAN PENCAIRAN REWARD '+#13+ 'Periode '+FormatDateTime('dd/MM/yyyy',dte_tglawal.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',dte_tglakhir.Date);

  DataModule1.frxReport1.ShowReport();
end;

procedure TFrmmemberrewardlist.btn_printoutstandingClick(Sender: TObject);
var strmember : string;
    FrxMemo: TfrxMemoView;
begin
  readandexecutesql_from_remotemysql;
  tampil;

  strmember := ' ';
  if cb_cardno.ItemIndex>0 then strmember := ' and a.cardno=' + Quotedstr(cb_cardno.Text) + ' ';

  Datamodule1.ZQryprintoutreward.close;
  Datamodule1.ZQryprintoutreward.SQL.text :=
   'select a.cardno,m.nama,a.tgl,m.golongan,a.lokasi,a.nogroup,a.namatour,case when a.`jenisbus`=0 then "Bus Rental" when a.`jenisbus`=1 then "Bus Besar" when a.`jenisbus`=2 then "Bus Kecil" end jenisbus,s.rewardmember from memberabsensi a '+
   'left join member m on a.cardno=m.cardno  ' +
   'left join struk s on s.isaktif=1 ' +
   'where a.faktur is null and date(a.`tgl`) between '+ Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglawal.Date)) + ' and ' + Quotedstr(FormatDateTime('yyyy-MM-dd',dte_tglakhir.Date)) + strmember +
   'order by a.cardno,a.`tgl` ';
  Datamodule1.ZQryprintoutreward.Open;

  DataModule1.frxReport1.LoadFromFile(vpath+'Report\rewardoutstandinglist.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('titleJual'));
  FrxMemo.Memo.Text := 'LAPORAN OUTSTANDING REWARD '+#13+ 'Periode '+FormatDateTime('dd/MM/yyyy',dte_tglawal.Date) + ' s/d ' + FormatDateTime('dd/MM/yyyy',dte_tglakhir.Date);

  DataModule1.frxReport1.ShowReport();

  Datamodule1.ZQryprintoutreward.close;

end;

end.
