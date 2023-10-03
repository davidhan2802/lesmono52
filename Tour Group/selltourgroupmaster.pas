unit selltourgroupmaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzRadGrp, Grids, DBGrids, PDJDBGridex, StdCtrls, RzCmboBx, Mask,
  RzEdit, RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, strutils, frxclass, db,
  RzButton, RzRadChk;

type
  TFrmselltourgroupmaster = class(TForm)
    PanelSales: TRzPanel;
    RzPanel58: TRzPanel;
    RzLabel243: TRzLabel;
    RzPanel60: TRzPanel;
    RzLabel246: TRzLabel;
    RzLabel247: TRzLabel;
    RzLabel248: TRzLabel;
    SalesBtnAdd: TAdvSmoothButton;
    SalesBtnEdit: TAdvSmoothButton;
    SalesBtnDel: TAdvSmoothButton;
    RzGroupBox18: TRzGroupBox;
    RzLabel250: TRzLabel;
    RzLabel251: TRzLabel;
    RzLabel252: TRzLabel;
    RzLabel253: TRzLabel;
    SalesBtnSearch: TAdvSmoothButton;
    SalesTxtSearch: TRzEdit;
    SalesTxtSearchby: TRzComboBox;
    SalesBtnClear: TAdvSmoothButton;
    salesDBGrid: TPDJDBGridEx;
    pnl_cetak_faktur: TRzPanel;
    lblbiro: TRzLabel;
    SellBtnPrintStruckBiro: TAdvSmoothButton;
    SellBtnPrintStrucktldriver: TAdvSmoothButton;
    RzLabel1: TRzLabel;
    RzLabel60: TRzLabel;
    SellTxtSearchFirst: TRzDateTimeEdit;
    Timer1: TTimer;
    RzPanel1: TRzPanel;
    RzLabel2: TRzLabel;
    btnprintlist: TAdvSmoothButton;
    ccx_ispoint: TRzCheckBox;
    procedure salesDBGridTitleClick(Column: TColumn);
    procedure SalesBtnAddClick(Sender: TObject);
    procedure SalesBtnEditClick(Sender: TObject);
    procedure SalesBtnDelClick(Sender: TObject);
    procedure SalesBtnSearchClick(Sender: TObject);
    procedure SalesBtnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SellBtnPrintStruckBiroClick(Sender: TObject);
    procedure SellBtnPrintStrucktldriverClick(Sender: TObject);
    procedure salesDBGridDblClick(Sender: TObject);
    procedure salesDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Timer1Timer(Sender: TObject);
    procedure btnprintlistClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isbusrental : boolean;
    procedure FormShowFirst;
  end;

var
  Frmselltourgroupmaster: TFrmselltourgroupmaster;
  ShowDetail : boolean;

implementation

uses selltourgroup, U_cetak, SparePartFunction, Data;

{$R *.dfm}

procedure TFrmselltourgroupmaster.FormShowFirst;
begin
 ShowDetail := false;

 SellBtnPrintStruckBiro.Visible := (IDUserGroup=1) and (isbusrental);
 lblbiro.Visible := SellBtnPrintStruckBiro.Visible;

 salesdbgrid.Columns[7].Visible := false;

 SellTxtSearchFirst.Date := tglskrg;

 SalesBtnEdit.Enabled := isedit;
 SalesBtnDel.Enabled  := isdel;

 SalesBtnClearClick(Self);

 Timer1.Enabled := true;
end;

procedure TFrmselltourgroupmaster.salesDBGridTitleClick(Column: TColumn);
var
  i: integer;
  s: string;
  sorted: string;
begin
  for i := 0 to SalesDBGrid.Columns.Count - 1 do
  begin
    if (SalesDBGrid.PDJDBGridExColumn[i].FieldName = Column.FieldName) then
    begin
      if SalesDBGrid.PDJDBGridExColumn[i].SortArrow = saDown then
      begin
        SalesDBGrid.PDJDBGridExColumn[i].SortArrow := saUp;
        s := 'order by ' + SalesDBGrid.PDJDBGridExColumn[i].FieldName;
        sorted := '';
      end
      else
      begin
        SalesDBGrid.PDJDBGridExColumn[i].SortArrow := saDown;
        s := 'order by ' + SalesDBGrid.PDJDBGridExColumn[i].FieldName + ' desc';
        sorted := 'desc';
      end;
      with DataModule1.ZQryselltourgroup do
      begin
        Close;
        SQL.Strings[5] := s;
        Open;
      end;
      ConfigINI.Strings[33] := 'sort-by=' + SalesDBGrid.PDJDBGridExColumn[i].FieldName;
      ConfigINI.Strings[34] := 'sort=' + sorted;
      ConfigINI.SaveToFile(ExtractFilePath(Application.ExeName) + 'config.ini');
    end
    else
      SalesDBGrid.PDJDBGridExColumn[i].SortArrow := saNone;
  end;
end;

procedure TFrmselltourgroupmaster.SalesBtnAddClick(Sender: TObject);
begin
 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF Frmselltourgroup=nil then
 application.CreateForm(TFrmselltourgroup,Frmselltourgroup);
 Frmselltourgroup.Align:=alclient;
 Frmselltourgroup.Parent:=self.parent;
 Frmselltourgroup.BorderStyle:=bsnone;
 frmselltourgroup.LblCaption.Caption := 'Tambah Tour Group';
 frmselltourgroup.isbusrental := isbusrental;
 Frmselltourgroup.FormShowFirst;
 Frmselltourgroup.Show;

end;

procedure TFrmselltourgroupmaster.SalesBtnEditClick(Sender: TObject);
begin
  if DataModule1.ZQryselltourgroup.IsEmpty then Exit;

 ShowDetail := true;

 TUTUPFORM(self.parent);
 IF Frmselltourgroup=nil then
 application.CreateForm(TFrmselltourgroup,Frmselltourgroup);
 Frmselltourgroup.Align:=alclient;
 Frmselltourgroup.Parent:=self.parent;
 Frmselltourgroup.BorderStyle:=bsnone;
 frmselltourgroup.LblCaption.Caption := 'Edit Tour Group';
 frmselltourgroup.isbusrental := isbusrental;
 Frmselltourgroup.FormShowFirst;
 Frmselltourgroup.Show;

end;

procedure TFrmselltourgroupmaster.SalesBtnDelClick(Sender: TObject);
var Posrecord : integer;
begin
  if DataModule1.ZQryselltourgroup.IsEmpty then Exit;


  if QuestionDialog('Hapus Tour Group ' + DataModule1.ZQryselltourgroupnamatour.Value + ' ?') = True then
  begin
   if isdataexist('select idselltourgroup from sellmaster where idselltourgroup=' + DataModule1.ZQryselltourgroupIDselltourgroup.AsString) then
   begin
    errordialog('Maaf, No. Rombongan ini sudah dipakai di penjualan!');
    exit;
   end;

   DataModule1.ZConnection1.ExecuteDirect('delete from selltourgroup where IDselltourgroup='+ DataModule1.ZQryselltourgroupIDselltourgroup.AsString);
   PosRecord := DataModule1.ZQryselltourgroup.RecNo;
   DataModule1.ZQryselltourgroup.Close;
   DataModule1.ZQryselltourgroup.Open;
   DataModule1.ZQryselltourgroup.RecNo := PosRecord;
   LogInfo(UserName,'Menghapus Tour Group ' + DataModule1.ZQryselltourgroupnamatour.Value);
   InfoDialog('Tour Group ' + DataModule1.ZQryselltourgroupnamatour.Value + ' berhasil dihapus !');
  end;

end;

procedure TFrmselltourgroupmaster.SalesBtnSearchClick(Sender: TObject);
var
  SearchCategories,vjnsbus: string;
begin
  if Trim(SalesTxtSearch.Text) = '' then Exit;
  case SalesTxtSearchby.ItemIndex of
  0 : SearchCategories := 'nogrp';
  1 : SearchCategories := 'namatour';
  end;

  if isbusrental then vjnsbus:='g.jenisbus=0' else vjnsbus:='g.jenisbus>0';

  with DataModule1.ZQryselltourgroup do
  begin
    Close;
    SQL.Strings[0] :=  'select g.*,coalesce(sum(if(s.isposted=-1,0,round(if(g.jenisbus=0,d.feerent,d.feedrivertl)*d.quantity))),0)+g.presentfee totrp,'+'case when g.jenisbus=0 then "Bus Rental" when g.jenisbus=1 then "Bus Besar" when g.jenisbus=2 then "Bus Kecil" end nmjenisbus, concat(g.norental,if(g.norental="","","/"),g.nogroup) nogrp from selltourgroup g ';
    SQL.Strings[3] :=  'where '+ vjnsbus +' and g.tgl=' + Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date)) + ' and g.' + SearchCategories + ' like ''' + '%' + SalesTxtSearch.Text + '%' + '''';
    SQL.Strings[5] :=  'order by ' + SearchCategories;
    open;
  end;


end;

procedure TFrmselltourgroupmaster.SalesBtnClearClick(Sender: TObject);
var vjnsbus: string;
begin
  if isbusrental then vjnsbus:='g.jenisbus=0' else vjnsbus:='g.jenisbus>0';
  with DataModule1.ZQryselltourgroup do
  begin
    Close;
    SQL.Strings[0] :=  'select g.*,coalesce(sum(if(s.isposted=-1,0,round(if(g.jenisbus=0,d.feerent,d.feedrivertl)*d.quantity))),0)+g.presentfee totrp,'+'case when g.jenisbus=0 then "Bus Rental" when g.jenisbus=1 then "Bus Besar" when g.jenisbus=2 then "Bus Kecil" end nmjenisbus, concat(g.norental,if(g.norental="","","/"),g.nogroup) nogrp from selltourgroup g ';
    SQL.Strings[3] :=  'where '+ vjnsbus +' and g.tgl=' + Quotedstr(getmysqldatestr(SellTxtSearchFirst.Date)) + ' ';
    SQL.Strings[5] :=  'order by nogrp';
    open;
  end;

  SalesTxtSearch.Text := '';

end;

procedure TFrmselltourgroupmaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if ShowDetail=false then DataModule1.ZQryselltourgroup.Close;

 Timer1.Enabled := false;
end;

procedure TFrmselltourgroupmaster.SellBtnPrintStruckBiroClick(
  Sender: TObject);
var
  F : TextFile;
  i,totrp : integer;
  nmfile,vnumstr : string;
begin
  nmfile := vpath + 'birostruk.txt';

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQrystruk.Open;

   Datamodule1.ZQryutil.Close;
   Datamodule1.ZQryutil.SQL.Clear;
   Datamodule1.ZQryutil.SQL.Text := 'select rpad(left(d.nama,17),23," "),round(d.feebiro*d.subtotal) totrp from selldetail d '+
                                    'left join sellmaster s on d.idsell=s.idsell '+
                                    'where s.isposted=1 and s.IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString + ' ' +
                                    'order by d.nama';
   Datamodule1.ZQryutil.Open;

   if Datamodule1.ZQryutil.IsEmpty then exit;

   AssignFile(F,nmfile);
   Rewrite(F);
   Writeln(F,'   '+Datamodule1.ZQrystrukcompany.value);
   Writeln(F,' '+Datamodule1.ZQrystrukalamat.value);
   Writeln(F,' '+Datamodule1.ZQrystrukphone.value);
   Writeln(F,' =================================== ');
   Writeln(F,' REKAP (Fee Biro)');
   Writeln(F,' Tanggal : ' + FormatDatetime('dd-mm-yyyy',Datamodule1.ZQryselltourgrouptgl.value));
   Writeln(F,' Kasir   :(' + getdata('GROUP_CONCAT(DISTINCT left(faktur,2) order by left(faktur,2) SEPARATOR ",")','sellmaster where IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString) + ')');
   Writeln(F,' Member  : ' + getdata('c.kode','customer c left join sellmaster s on c.IDcustomer=s.IDcustomer where s.IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString + ' limit 1'));
   Writeln(F,' ----------------------------------- ');
   i:=1;
   totrp := 0;
   while not DataModule1.ZQryutil.Eof do
   begin
    if i<10 then vnumstr := inttostr(i)+'  ' else vnumstr := inttostr(i)+' ';

    Writeln(F,' '+vnumstr + DataModule1.ZQryutil.fields[0].AsString + FormatFloat('###,##0',DataModule1.ZQryutil.Fields[1].Asfloat));
    Writeln(F,'');

    totrp := totrp + DataModule1.ZQryutil.Fields[1].Asinteger;

    i := i + 1;
    DataModule1.ZQryutil.Next;
   end;

   Writeln(F,' ----------------------------------- ');
   Writeln(F,'                Total : Rp.'+FormatFloat('###,##0', totrp));
   Writeln(F,'');
   Writeln(F,' Dibuat Oleh,       Mengetahui,');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,' (            )    (            )');
   Writeln(F,'');
   Writeln(F,'Printed By ' + UserName + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',getnow));
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,chr(27)+chr(105));
   Writeln(F,chr(27)+chr(112)+chr(0)+chr(50)+chr(250));

   CloseFile(F);

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQryutil.Close;

   cetakFile(nmfile);

end;

procedure TFrmselltourgroupmaster.SellBtnPrintStrucktldriverClick(
  Sender: TObject);
var
  F : TextFile;
  i,totrp : integer;
  nmfile,vnumstr,vstrbus : string;
begin
  nmfile := vpath + 'tlstruk.txt';

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQrystruk.Open;

   if  Datamodule1.ZQryselltourgroupjenisbus.Value=0 then vstrbus := 'd.feerent' else vstrbus := 'd.feedrivertl';

   Datamodule1.ZQryutil.Close;
   Datamodule1.ZQryutil.SQL.Clear;
   if ccx_ispoint.Checked then
   Datamodule1.ZQryutil.SQL.Text := 'select rpad(left(g.nama,17),16," ") nmgol,rpad(sum(round(d.quantity)),10," "),sum(round('+vstrbus+'*d.quantity)) totrp from selldetail d '+
                                    'left join sellmaster s on d.idsell=s.idsell ' +
                                    'left join product p on d.kode=p.kode '+
                                    'left join golongan g on p.IDgolongan=g.IDgolongan ' +
                                    'where trim(left(g.nama,17)) not in ("BAKPIA","BANDENG 52","WINGKO BABAT") and s.isposted=1 and s.IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString + ' ' +
                                    'group by g.nama ' +
                                    'having totrp>0 union ' +

                                    'select rpad(left(g.nama,17),16," ") nmgol,concat(rpad(sum(round(d.quantity)),3," "),rpad(replace(format(round('+vstrbus+'),0),",","."),7," ")),sum(round('+vstrbus+'*d.quantity)) totrp from selldetail d '+
                                    'left join sellmaster s on d.idsell=s.idsell ' +
                                    'left join product p on d.kode=p.kode '+
                                    'left join golongan g on p.IDgolongan=g.IDgolongan ' +
                                    'where trim(left(g.nama,17)) in ("BAKPIA","BANDENG 52","WINGKO BABAT") and s.isposted=1 and s.IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString + ' ' +
                                    'group by g.nama,' + vstrbus + ' ' +
                                    'having totrp>0 ' +
                                    'order by nmgol '
   else
   Datamodule1.ZQryutil.SQL.Text := 'select rpad(left(g.nama,17),18," ") nmgol,rpad(sum(round(d.quantity)),5," "),sum(round('+vstrbus+'*d.quantity)) totrp from selldetail d '+
                                    'left join sellmaster s on d.idsell=s.idsell ' +
                                    'left join product p on d.kode=p.kode '+
                                    'left join golongan g on p.IDgolongan=g.IDgolongan ' +
                                    'where s.isposted=1 and s.IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString + ' ' +
                                    'group by g.nama ' +
                                    'having totrp>0 ' +
                                    'order by g.nama ';
   Datamodule1.ZQryutil.Open;

   if Datamodule1.ZQryutil.IsEmpty then exit;

   AssignFile(F,nmfile);
   Rewrite(F);
   Writeln(F,'   '+Datamodule1.ZQrystrukcompany.value);
   Writeln(F,' '+Datamodule1.ZQrystrukalamat.value);
   Writeln(F,' '+Datamodule1.ZQrystrukphone.value);
   Writeln(F,' =================================== ');
   Writeln(F,' REKAP (Fee Driver & TL)');
   Writeln(F,' Tanggal : ' + FormatDatetime('dd-mm-yyyy',Datamodule1.ZQryselltourgrouptgl.value));
   Writeln(F,' Kasir   :(' + getdata('GROUP_CONCAT(DISTINCT left(faktur,2) order by left(faktur,2) SEPARATOR ",")','sellmaster where IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString) + ')' + '  ['+Datamodule1.ZQryselltourgroupnogrp.asString+']');
   Writeln(F,' Member  : ' + getdata('c.kode','customer c left join sellmaster s on c.IDcustomer=s.IDcustomer where s.IDselltourgroup=' + Datamodule1.ZQryselltourgroupIDselltourgroup.asString + ' limit 1'));
   Writeln(F,' PO      : ' + Datamodule1.ZQryselltourgroupnamatour.value);
   Writeln(F,' ----------------------------------- ');
   i:=1;
   totrp := 0;
   while not DataModule1.ZQryutil.Eof do
   begin
    if i<10 then vnumstr := inttostr(i)+'  ' else vnumstr := inttostr(i)+'. ';

    Writeln(F,' '+vnumstr + DataModule1.ZQryutil.fields[0].AsString + DataModule1.ZQryutil.fields[1].AsString + FormatFloat('###,##0',DataModule1.ZQryutil.Fields[2].Asfloat));
    Writeln(F,'');

    totrp := totrp + DataModule1.ZQryutil.Fields[2].Asinteger;

    i := i + 1;
    DataModule1.ZQryutil.Next;
   end;

   Writeln(F,' ----------------------------------- ');
   Writeln(F,'                Total : Rp.'+FormatFloat('###,##0', totrp));

   if Datamodule1.ZQryselltourgrouppresentfee.value<>0 then
   begin
    Writeln(F,'');
    Writeln(F,'      Fee            : Rp.'+FormatFloat('###,##0', Datamodule1.ZQryselltourgrouppresentfee.value));
    Writeln(F,'      '+Datamodule1.ZQryselltourgroupnmjenisbus.value);
    Writeln(F,' ----------------------------------- ');
    totrp := totrp + Datamodule1.ZQryselltourgrouppresentfee.AsInteger;
    Writeln(F,'          Grand Total : Rp.'+FormatFloat('###,##0', totrp));
   end;

   Writeln(F,'');
   Writeln(F,' Dibuat Oleh,       Mengetahui,');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,' (            )    (            )');
   Writeln(F,'');
   Writeln(F,'Printed By ' + UserName + ' ' + FormatDatetime('dd/mm/yyyy hh:nn:ss',getnow));
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,'');
   Writeln(F,chr(27)+chr(105));
   Writeln(F,chr(27)+chr(112)+chr(0)+chr(50)+chr(250));

   CloseFile(F);

   Datamodule1.ZQrystruk.Close;
   Datamodule1.ZQryutil.Close;

   cetakFile(nmfile);


   Datamodule1.ZConnection1.ExecuteDirect('delete from operasional where idTrans='+Datamodule1.ZQryselltourgroupIDselltourgroup.AsString+' and kategori='+Quotedstr('FEE TL & DRIVER'));
   Datamodule1.ZConnection1.ExecuteDirect('insert into operasional ' +
      '(idTrans,faktur,tanggal,waktu,kasir,kategori,keterangan,kredit) values ' +
      '(''' + Datamodule1.ZQryselltourgroupIDselltourgroup.AsString + ''',' +
      '''' + Datamodule1.ZQryselltourgroupnogrp.AsString + ''',' +
      '''' + FormatDateTime('yyyy-MM-dd',Datamodule1.ZQryselltourgrouptgl.AsDatetime) + ''',' +
      '''' + FormatDateTime('hh:nn:ss',getnow) + ''',' +
      '''' + UserName + ''',' +
      '''' + 'FEE TL & DRIVER' + ''',' +
      '''' + 'FEE TL & DRIVER' + ''',' +
      '''' + number2mysql(Datamodule1.ZQryselltourgrouptotrp.value) + ''')');


end;

procedure TFrmselltourgroupmaster.salesDBGridDblClick(Sender: TObject);
var totrpshow : boolean;
begin
 totrpshow := salesdbgrid.Columns[7].Visible;
 salesdbgrid.Columns[7].Visible := not totrpshow;
end;

procedure TFrmselltourgroupmaster.salesDBGridDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 if DataModule1.ZQryselltourgrouptotrp.value>0 then
    salesDBGrid.Canvas.Brush.Color:= $00D9D9FF
 else salesDBGrid.Canvas.Brush.Color:= clwindow;

 salesDBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TFrmselltourgroupmaster.Timer1Timer(Sender: TObject);
var PosRecord : integer;
begin
 PosRecord := DataModule1.ZQryselltourgroup.RecNo;
 DataModule1.ZQryselltourgroup.Refresh;
 DataModule1.ZQryselltourgroup.RecNo := PosRecord;
end;

procedure TFrmselltourgroupmaster.btnprintlistClick(Sender: TObject);
var
  FrxMemo: TfrxMemoView;
  ketstr : string;
begin
  DataModule1.frxReport1.LoadFromFile(vpath+'Report\selltourgroup.fr3');

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Printed By ' + UserName + ' ' + FormatDateTime('dd-MM-yyyy hh:nn:ss',Now) ;

  ketstr := '';
  if (SalesTxtSearch.Text<>'')and(SalesTxtSearchby.ItemIndex>=0) then ketstr := ' (' + uppercase(SalesTxtSearchby.Text) + ' : ' + SalesTxtSearch.Text + '...)';

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Judul'));
  FrxMemo.Memo.Text := 'LIST TOUR GROUP '+ketstr;

  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('Tanggal'));
  FrxMemo.Memo.Text := 'Tanggal ' + FormatDateTime('dd/MM/yyyy',SellTxtSearchFirst.Date) ;

  DataModule1.frxReport1.ShowReport();

end;

procedure TFrmselltourgroupmaster.FormShow(Sender: TObject);
begin
  Panelsales.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelsales.Color := $00808040;

end;

end.
