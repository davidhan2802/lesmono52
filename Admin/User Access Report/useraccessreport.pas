unit useraccessreport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, PDJDBGridex, RzEdit, StdCtrls, RzCmboBx, Mask,
  RzPanel, AdvSmoothButton, RzLabel, ExtCtrls, frxClass;

type
  TFrmUserAccessReport = class(TForm)
    PanelReturBeli: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel3: TRzLabel;
    RzGroupBox9: TRzGroupBox;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel75: TRzLabel;
    RzLabel129: TRzLabel;
    RzLabel156: TRzLabel;
    RtrBeliBtnSearch: TAdvSmoothButton;
    RtrBeliTxtSearch: TRzEdit;
    RtrBeliTxtSearchBy: TRzComboBox;
    RtrBeliBtnClear: TAdvSmoothButton;
    RtrBeliTxtSearchFirst: TRzDateTimeEdit;
    RtrBeliTxtSearchLast: TRzDateTimeEdit;
    DBGrid: TPDJDBGridEx;
    pnl_cetak: TRzPanel;
    RzLabel171: TRzLabel;
    RzLabel172: TRzLabel;
    RtrBeliBtnPrint: TAdvSmoothButton;
    procedure RtrBeliBtnPrintClick(Sender: TObject);
    procedure RtrBeliBtnSearchClick(Sender: TObject);
    procedure RtrBeliBtnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FormShowFirst;
  end;

var
  FrmUserAccessReport: TFrmUserAccessReport;

implementation

uses SparePartFunction, Data;

{$R *.dfm}

procedure TFrmUserAccessReport.FormShowFirst;
begin
  ipcomp := getComputerIP;

  RtrBeliTxtSearchFirst.Date := Tglskrg;
  RtrBeliTxtSearchLast.Date  := TglSkrg;

  RtrBeliBtnClearClick(Self);
end;

procedure TFrmUserAccessReport.RtrBeliBtnPrintClick(Sender: TObject);
var
  FrxMemo: TfrxMemoView;
begin
  if DataModule1.ZQryUserAccessReport.IsEmpty then Exit;

  DataModule1.frxReport1.LoadFromFile(vpath+'Report\loginfo.fr3');
  FrxMemo := TfrxMemoView(DataModule1.frxReport1.FindObject('FooterCaption'));
  FrxMemo.Memo.Text := 'Dicetak ' + FormatDateTime('dd-mm-yyyy hh:nn:ss',Now) + ' oleh ' + UserName;
  DataModule1.frxReport1.ShowReport();
end;

procedure TFrmUserAccessReport.RtrBeliBtnSearchClick(Sender: TObject);
var
  SearchCategories: string;
begin
  if (Trim(RtrBeliTxtSearch.Text) = '')and(RtrBeliTxtSearchby.ItemIndex>=0) then Exit;
  case RtrBeliTxtSearchBy.ItemIndex of
  0 : SearchCategories := 'computername like ''' + RtrBeliTxtSearch.Text + '%' + ''' ';
  1 : SearchCategories := 'username like ''' + RtrBeliTxtSearch.Text + '%' + ''' ';
  2 : SearchCategories := 'keterangan like ''' + '%' + RtrBeliTxtSearch.Text + '%' + ''' ';
  end;

  with DataModule1.ZQryUserAccessReport do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from loginfo ');
    SQL.Add('where ' + SearchCategories );
    SQL.Add('and tanggal between ''' + FormatDateTime('yyyy-MM-dd',RtrBeliTxtSearchFirst.Date) + ''' ');
    SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',RtrBeliTxtSearchLast.Date) + ''' ');
    Open;
  end;

  RtrBeliBtnPrint.Enabled := true;
end;

procedure TFrmUserAccessReport.RtrBeliBtnClearClick(Sender: TObject);
begin
  with DataModule1.ZQryUserAccessReport do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from loginfo ');
    SQL.Add('where (tanggal between ''' + FormatDateTime('yyyy-MM-dd',RtrBeliTxtSearchFirst.Date) + ''' ');
    SQL.Add('and ''' + FormatDateTime('yyyy-MM-dd',RtrBeliTxtSearchLast.Date) + ''') ');
    Open;
  end;
  RtrBeliTxtSearch.Text := '';

  RtrBeliTxtSearchBy.ItemIndex := 0;

  RtrBeliBtnPrint.Enabled := true;
end;

procedure TFrmUserAccessReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 DataModule1.ZQryuseraccessreport.Close;
end;

procedure TFrmUserAccessReport.FormShow(Sender: TObject);
begin
  Panelreturbeli.Color := $0092C9C9;
  if (DataModule1.ZConnection1.Catalog='sparepart52') then
      Panelreturbeli.Color := $00808040;

end;

end.
