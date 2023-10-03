unit Data;

interface
//isi ZQrySearchProduct select a.qty,b.*,cast('' as char(20)) faktur from v_stock a left join product b on a.kodebrg = b.kode
uses
  SysUtils, Classes, ZConnection, DB, Controls, Dialogs, Forms, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, frxClass, frxDBSet, ZSqlProcessor, ImgList, frxExportPDF,
  frxExportXLS, ZAbstractConnection, frxExportBaseDialog;

type
  TDataModule1 = class(TDataModule)
    ZConnection1: TZConnection;
    DSProduct: TDataSource;
    frxReport1: TfrxReport;
    frxDBProduct: TfrxDBDataset;
    DSSupplier: TDataSource;
    frxDBSupplier: TfrxDBDataset;
    DSCustomer: TDataSource;
    frxDBCustomer: TfrxDBDataset;
    DSSellMaster: TDataSource;
    ZQryFormSell: TZQuery;
    DSFormSell: TDataSource;
    DSSearchProduct: TDataSource;
    ZQryFormSellkode: TStringField;
    ZQryFormSellnama: TStringField;
    ZQryFormSellharga: TFloatField;
    ZQryFormSelltotalharga: TFloatField;
    ZQryFormSelldiskonrp: TFloatField;
    ZQryFormSellsubtotal: TFloatField;
    ZQryFormSelldiskon: TFloatField;
    ZQryFormBuy: TZQuery;
    DSFormBuy: TDataSource;
    ZQryFormBuykode: TStringField;
    ZQryFormBuynama: TStringField;
    ZQryFormBuyharga: TFloatField;
    ZQryFormBuydiskon: TFloatField;
    ZQryFormBuysubtotal: TFloatField;
    ZQryBuyMaster: TZQuery;
    DSBuyMaster: TDataSource;
    ZQryBuyMasterfaktur: TStringField;
    ZQryBuyMastertanggal: TDateField;
    ZQryBuyMasterwaktu: TTimeField;
    ZQryBuyMasterkasir: TStringField;
    ZQryBuyMasterkodesupplier: TStringField;
    ZQryBuyMastersupplier: TStringField;
    ZQryBuyMasterpembayaran: TStringField;
    ZQryBuyMasternogiro: TStringField;
    ZQryBuyMastertgljatuhtempo: TDateField;
    ZQryBuyMastersubtotal: TFloatField;
    ZQryBuyMasterppn: TFloatField;
    ZQryBuyMastertotal: TFloatField;
    ZQryBuyMasterdiskon: TFloatField;
    ZQryBuyMasterdiskonrp: TFloatField;
    ZQryBuyMastergrandtotal: TFloatField;
    ZQryBuyMasterDP: TFloatField;
    ZQryBuyMasterkurang: TFloatField;
    frxDBSelling: TfrxDBDataset;
    frxDBBuying: TfrxDBDataset;
    ZQryOperasional: TZQuery;
    DSOperasional: TDataSource;
    ZQryPiutang: TZQuery;
    DSPiutang: TDataSource;
    frxDBFormSell: TfrxDBDataset;
    frxDBFormOperasional: TfrxDBDataset;
    ZQryHutang: TZQuery;
    DSHutang: TDataSource;
    ZQryOperasionalfaktur: TStringField;
    ZQryOperasionaltanggal: TDateField;
    ZQryOperasionalwaktu: TTimeField;
    ZQryOperasionalkasir: TStringField;
    ZQryOperasionalkategori: TStringField;
    ZQryOperasionaldebet: TFloatField;
    ZQryOperasionalkredit: TFloatField;
    ZSQLProcessor1: TZSQLProcessor;
    ZQryOperasionalsaldo: TFloatField;
    ZQryFormRetur: TZQuery;
    DSFormRetur: TDataSource;
    ZQryUser: TZQuery;
    DSUser: TDataSource;
    ZQryUserusername: TStringField;
    ZQryUserpassword: TStringField;
    ZQryUserusergroup: TStringField;
    ZQryGudang: TZQuery;
    DSGudang: TDataSource;
    ZQryGudangnamagudang: TStringField;
    ZQryGudangkota: TStringField;
    ZQryGudangwilayah: TStringField;
    ZQryGudangalamat1: TStringField;
    ZQryGudangalamat2: TStringField;
    ZQryGudangkodegudang: TStringField;
    ZQryGudangtype: TStringField;
    ZQryGudangtelp: TStringField;
    ZQryGudangfax: TStringField;
    ZQryJasa: TZQuery;
    DSJasa: TDataSource;
    frxDBJasa: TfrxDBDataset;
    ZQryJasakode: TStringField;
    ZQryJasanama: TStringField;
    ZQryJasakomisi: TFloatField;
    ZQryJasatglnoneffective: TDateField;
    ZQryFormBuyfaktur: TStringField;
    ZQryFormBuykategori: TStringField;
    ZQryFormBuymerk: TStringField;
    ZQryFormBuyseri: TStringField;
    ZQryFormBuysatuan: TStringField;
    ZQryBuyMasteridBeli: TIntegerField;
    ZQryFormSellfaktur: TStringField;
    ZQryFormSellmerk: TStringField;
    ZQryFormSellseri: TStringField;
    ZQryFormSellsatuan: TStringField;
    ZQryFormSellhargabeli: TFloatField;
    ZQryOperasionalidTrans: TIntegerField;
    ZQryFormOperasional: TZQuery;
    DSFormOpr: TDataSource;
    ZQryFormOperasionalidTrans: TIntegerField;
    ZQryFormOperasionalfaktur: TStringField;
    ZQryFormOperasionaltanggal: TDateField;
    ZQryFormOperasionalwaktu: TTimeField;
    ZQryFormOperasionalkasir: TStringField;
    ZQryFormOperasionalkategori: TStringField;
    ZQryFormOperasionaldebet: TFloatField;
    ZQryFormOperasionalkredit: TFloatField;
    ZQryFormOperasionalsaldo: TFloatField;
    ZQryPiutangfaktur: TStringField;
    ZQryPiutangtanggal: TDateField;
    ZQryPiutangwaktu: TTimeField;
    ZQryPiutangkasir: TStringField;
    ZQryPiutangkodecustomer: TStringField;
    ZQryPiutangcustomer: TStringField;
    ZQryPiutangpembayaran: TStringField;
    ZQryPiutangnogiro: TStringField;
    ZQryPiutangtgljatuhtempo: TDateField;
    ZQryPiutangsubtotal: TFloatField;
    ZQryPiutangppn: TFloatField;
    ZQryPiutangtotal: TFloatField;
    ZQryPiutangdiskon: TFloatField;
    ZQryPiutangdiskonrp: TFloatField;
    ZQryPiutanggrandtotal: TFloatField;
    ZQryPiutangbayar: TFloatField;
    ZQryPiutangkembali: TFloatField;
    ZQryPiutangidsell: TIntegerField;
    frxDBPiutang: TfrxDBDataset;
    frxDBHutang: TfrxDBDataset;
    ZQryBuyingitem: TZQuery;
    frxDBBuyingitem: TfrxDBDataset;
    ZQryListSell: TZQuery;
    frxDBListSell: TfrxDBDataset;
    ZQryListSellfaktur: TStringField;
    ZQryListSelltanggal: TDateField;
    ZQryListSellnama: TStringField;
    ZQryListSellquantity: TIntegerField;
    ZQryListSellhargajual: TFloatField;
    ZQryListSellsubtotal: TFloatField;
    ZQryListSellcustomer: TStringField;
    ZQryListStock: TZQuery;
    frxDBListStock: TfrxDBDataset;
    ZQryListCash: TZQuery;
    frxDBListCash: TfrxDBDataset;
    ZQryListCashidTrans: TIntegerField;
    ZQryListCashfaktur: TStringField;
    ZQryListCashtanggal: TDateField;
    ZQryListCashwaktu: TTimeField;
    ZQryListCashkasir: TStringField;
    ZQryListCashkategori: TStringField;
    ZQryListCashdebet: TFloatField;
    ZQryListCashkredit: TFloatField;
    ZQryListRugiLaba: TZQuery;
    frxDBListRugiLaba: TfrxDBDataset;
    ZQryReturJual: TZQuery;
    DSReturJual: TDataSource;
    ZQryReturBeli: TZQuery;
    DSReturBeli: TDataSource;
    frxDBFormRetur: TfrxDBDataset;
    frxDBReturBeli: TfrxDBDataset;
    ZQryRusak: TZQuery;
    DSRusak: TDataSource;
    frxDBRusak: TfrxDBDataset;
    DSAdjustlist: TDataSource;
    ZQryReturJualidReturJual: TIntegerField;
    ZQryReturJualfaktur: TStringField;
    ZQryReturJualtanggal: TDateField;
    ZQryReturJualwaktu: TTimeField;
    ZQryReturJualoperator: TStringField;
    ZQryReturJualkodecustomer: TStringField;
    ZQryReturJualcustomer: TStringField;
    ZQryReturJualtotalretur: TFloatField;
    ZQryReturBeliidReturBeli: TIntegerField;
    ZQryReturBelifaktur: TStringField;
    ZQryReturBelitanggal: TDateField;
    ZQryReturBeliwaktu: TTimeField;
    ZQryReturBelioperator: TStringField;
    ZQryReturBelifakturbeli: TStringField;
    ZQryReturBelikodesupplier: TStringField;
    ZQryReturBelisupplier: TStringField;
    ZQryReturBelitotaltrans: TFloatField;
    ZQryReturBelitotalretur: TFloatField;
    ZQryFormReturkode: TStringField;
    ZQryFormReturnama: TStringField;
    ZQryFormReturketerangan: TStringField;
    ZQryFormReturharga: TFloatField;
    ZQryFormRetursubtotal: TFloatField;
    ZQryFormReturkategori: TStringField;
    ZQryFormReturmerk: TStringField;
    ZQryFormReturseri: TStringField;
    ZQryFormReturfaktur: TStringField;
    ZQryFormReturdiskonrp: TFloatField;
    frxDBReturJual: TfrxDBDataset;
    ZQryFormAdjust: TZQuery;
    DSFormAdjust: TDataSource;
    frxDBFormAdjust: TfrxDBDataset;
    ZQryPiutangtotalpayment: TFloatField;
    ZQryPaymentdet: TZQuery;
    DSPaymentdet: TDataSource;
    ZQryPaymentdetidTrans: TIntegerField;
    ZQryPaymentdetfaktur: TStringField;
    ZQryPaymentdettanggal: TDateField;
    ZQryPaymentdetwaktu: TTimeField;
    ZQryPaymentdetkasir: TStringField;
    ZQryPaymentdetkategori: TStringField;
    ZQryPaymentdetdebet: TFloatField;
    ZQryPaymentdetkredit: TFloatField;
    ZQryPaymentdetidoperasional: TLargeintField;
    DSSales: TDataSource;
    ZQryGudangisbadstock: TSmallintField;
    ZQryGudangkondisi: TStringField;
    ZQryFormRetursatuan: TStringField;
    ZQryFormReturfakturjual: TStringField;
    ZQryFormReturdiskon: TFloatField;
    ZQryFormReturkodegudang: TStringField;
    ZQryPiutangkodesales: TStringField;
    ZQryPiutangnamasales: TStringField;
    ZQryPiutangkodenmcust: TStringField;
    ZQryPiutangpiutang: TFloatField;
    ZQryPiutangbayarskrg: TFloatField;
    ZQryPaymentdetfakturpay: TStringField;
    ZQryPaymentdetsaldoawaltagihan: TFloatField;
    ZQrySellPayment: TZQuery;
    ZQrySellPaymentfaktur: TStringField;
    ZQrySellPaymentkodecustomer: TStringField;
    ZQrySellPaymentcustomer: TStringField;
    ZQrySellPaymenttanggal: TDateField;
    ZQrySellPaymentwaktu: TTimeField;
    ZQrySellPaymentkasir: TStringField;
    ZQrySellPaymenttunai: TFloatField;
    ZQrySellPaymentbg: TFloatField;
    ZQrySellPaymenttanggalinput: TDateField;
    ZQrySellPaymentnotes: TStringField;
    ZQrySellPaymentisposted: TSmallintField;
    DSSellPayment: TDataSource;
    ZQrySellPaymentkodenmcust: TStringField;
    ZQryOperasionalidoperasional: TLargeintField;
    ZQryOperasionalfakturpay: TStringField;
    ZQryOperasionalsaldoawaltagihan: TFloatField;
    ZQryListCashidoperasional: TLargeintField;
    ZQryListCashketerangan: TStringField;
    ZQryListCashfakturpay: TStringField;
    ZQryListCashsaldoawaltagihan: TFloatField;
    ZQryFormOperasionalidoperasional: TLargeintField;
    ZQryFormOperasionalfakturpay: TStringField;
    ZQryFormOperasionalsaldoawaltagihan: TFloatField;
    ZQryPiutangretur: TZQuery;
    ZQryPiutangreturidReturJual: TIntegerField;
    ZQryPiutangreturfaktur: TStringField;
    ZQryPiutangreturtanggal: TDateField;
    ZQryPiutangreturwaktu: TTimeField;
    ZQryPiutangreturoperator: TStringField;
    ZQryPiutangreturkodecustomer: TStringField;
    ZQryPiutangreturcustomer: TStringField;
    ZQryPiutangreturtotalretur: TFloatField;
    ZQryPiutangreturlunas: TSmallintField;
    ZQryPiutangreturpembayaran: TStringField;
    ZQryPiutangreturkodenmcust: TStringField;
    DSPiutangRetur: TDataSource;
    ZQrySellPaymenttotalpiutangfaktur: TFloatField;
    ZQrySellPaymenttotalretur: TFloatField;
    ZQryPaymentdetpiutangawal: TFloatField;
    ZQryPaymentdetbayar: TFloatField;
    ZQryPaymentdetsisatagihan: TFloatField;
    ZQryListRugiLabaidrugilaba: TIntegerField;
    ZQryListRugiLabatanggal: TDateField;
    ZQryListRugiLabaketerangan: TStringField;
    ZQryListRugiLabalabakotor: TFloatField;
    ZQryListRugiLabaoperasional: TFloatField;
    ZQryListRugiLabapajak: TFloatField;
    ZQryListRugiLabalababersih: TFloatField;
    ZQrySellPaymenttransfer: TFloatField;
    ZQryFormSellidstts: TSmallintField;
    ZQryFormBuyharganondiskon: TFloatField;
    frxDBFormBuy: TfrxDBDataset;
    ZQrySellPaymentdiskonrp: TFloatField;
    ZQryPiutangchecked: TSmallintField;
    ZQrySellPaymentsaldo_piutang: TFloatField;
    ZQryPiutangreturchecked: TSmallintField;
    ZQryListStockin: TZReadOnlyQuery;
    ZQryListStockinnama: TStringField;
    ZQryListStockinsatuan: TStringField;
    ZQryListStockinmerk: TStringField;
    ZQryListStockinkategori: TStringField;
    ZQryListStockinhargajual: TFloatField;
    frxDBListStockin: TfrxDBDataset;
    ZQryBuyMastertotalpayment: TFloatField;
    ZQryBuyPaymentdet: TZQuery;
    ZQryBuyPayment: TZQuery;
    ZQryBuyPaymentfaktur: TStringField;
    ZQryBuyPaymentkodesupplier: TStringField;
    ZQryBuyPaymentsupplier: TStringField;
    ZQryBuyPaymenttanggal: TDateField;
    ZQryBuyPaymentwaktu: TTimeField;
    ZQryBuyPaymentkasir: TStringField;
    ZQryBuyPaymenttransfer: TFloatField;
    ZQryBuyPaymenttunai: TFloatField;
    ZQryBuyPaymentbg: TFloatField;
    ZQryBuyPaymenttotalhutangfaktur: TFloatField;
    ZQryBuyPaymenttotalretur: TFloatField;
    ZQryBuyPaymentdiskonrp: TFloatField;
    ZQryBuyPaymenttanggalinput: TDateField;
    ZQryBuyPaymentnotes: TStringField;
    ZQryBuyPaymentisposted: TSmallintField;
    ZQryBuyPaymentsaldo_hutang: TFloatField;
    ZQryBuyPaymentkodenmsupp: TStringField;
    DSBuyPaymentdet: TDataSource;
    DSBuyPayment: TDataSource;
    ZQryBuyPaymentdetidoperasional: TLargeintField;
    ZQryBuyPaymentdetidTrans: TIntegerField;
    ZQryBuyPaymentdetfaktur: TStringField;
    ZQryBuyPaymentdettanggal: TDateField;
    ZQryBuyPaymentdetwaktu: TTimeField;
    ZQryBuyPaymentdetkasir: TStringField;
    ZQryBuyPaymentdetkategori: TStringField;
    ZQryBuyPaymentdetketerangan: TStringField;
    ZQryBuyPaymentdetdebet: TFloatField;
    ZQryBuyPaymentdetkredit: TFloatField;
    ZQryBuyPaymentdetfakturpay: TStringField;
    ZQryBuyPaymentdetsaldoawaltagihan: TFloatField;
    ZQryBuyPaymentdethutangawal: TFloatField;
    ZQryBuyPaymentdetbayar: TFloatField;
    ZQryBuyPaymentdetsisatagihan: TFloatField;
    ZQryHutangretur: TZQuery;
    ZQryHutangreturidReturBeli: TIntegerField;
    ZQryHutangreturfaktur: TStringField;
    ZQryHutangreturtanggal: TDateField;
    ZQryHutangreturwaktu: TTimeField;
    ZQryHutangreturoperator: TStringField;
    ZQryHutangreturfakturbeli: TStringField;
    ZQryHutangreturkodesupplier: TStringField;
    ZQryHutangretursupplier: TStringField;
    ZQryHutangreturtotaltrans: TFloatField;
    ZQryHutangreturtotalretur: TFloatField;
    ZQryHutangreturlunas: TSmallintField;
    ZQryHutangreturpembayaran: TStringField;
    ZQryHutangreturkodenmsupp: TStringField;
    DSHutangRetur: TDataSource;
    ZQryHutangreturchecked: TSmallintField;
    ZQryReturJualkota: TStringField;
    ZQryListSellkategori: TStringField;
    ZQryListSellmerk: TStringField;
    ZQryListSelldiskon: TFloatField;
    ZQryUtil: TZReadOnlyQuery;
    ZQrySearch: TZReadOnlyQuery;
    ZQryList: TZReadOnlyQuery;
    ZQryFunction: TZReadOnlyQuery;
    ZQrySearchProduct: TZReadOnlyQuery;
    ZQrySearchProductkode: TStringField;
    ZQrySearchProductnama: TStringField;
    ZQrySearchProductmerk: TStringField;
    ZQrySearchProductseri: TStringField;
    ZQrySearchProductsatuan: TStringField;
    ZQrySearchProducthargabeli: TFloatField;
    ZQrySearchProducthargajual: TFloatField;
    ZQrySearchProductketerangan: TStringField;
    ZQrySearchProducttglnoneffective: TDateField;
    ZQrySearchProductdiskon: TFloatField;
    ZQrySearchProductdiskonrp: TFloatField;
    ZQrySearchProductfaktur: TStringField;
    ZQryProduct: TZReadOnlyQuery;
    ZQryProductkode: TStringField;
    ZQryProductnama: TStringField;
    ZQryProductmerk: TStringField;
    ZQryProductseri: TStringField;
    ZQryProductsatuan: TStringField;
    ZQryProducthargabeli: TFloatField;
    ZQryProducthargajual: TFloatField;
    ZQryProductketerangan: TStringField;
    ZQryProducttglnoneffective: TDateField;
    ZQryProductdiskon: TFloatField;
    ZQryProductdiskonrp: TFloatField;
    ZQrySupplier: TZReadOnlyQuery;
    ZQrySupplierkode: TStringField;
    ZQrySuppliernama: TStringField;
    ZQrySupplieralamat: TStringField;
    ZQrySupplieralamat2: TStringField;
    ZQrySupplierkota: TStringField;
    ZQrySupplierkota2: TStringField;
    ZQrySupplierkodepos: TStringField;
    ZQrySuppliertelephone: TStringField;
    ZQrySuppliertelephone2: TStringField;
    ZQrySupplierfax: TStringField;
    ZQrySupplierrekening: TStringField;
    ZQrySupplierhp: TStringField;
    ZQrySupplierhp2: TStringField;
    ZQrySuppliernotes: TStringField;
    ZQrySuppliertglnoneffective: TDateField;
    ZQryCustomer: TZReadOnlyQuery;
    ZQryCustomerkode: TStringField;
    ZQryCustomernama: TStringField;
    ZQryCustomeralamat: TStringField;
    ZQryCustomeralamat2: TStringField;
    ZQryCustomerkota: TStringField;
    ZQryCustomerkota2: TStringField;
    ZQryCustomerkodepos: TStringField;
    ZQryCustomertelephone: TStringField;
    ZQryCustomertelephone2: TStringField;
    ZQryCustomerfax: TStringField;
    ZQryCustomeremail: TStringField;
    ZQryCustomerwebsite: TStringField;
    ZQryCustomerhp: TStringField;
    ZQryCustomerhp2: TStringField;
    ZQryCustomerhobby: TStringField;
    ZQryCustomernotes: TStringField;
    ZQryCustomertglreg: TDateField;
    ZQryCustomertgllahir: TDateField;
    ZQryCustomertglnoneffective: TDateField;
    ZQrySellMaster: TZReadOnlyQuery;
    ZQrySellMasteridsell: TIntegerField;
    ZQrySellMasterfaktur: TStringField;
    ZQrySellMastertanggal: TDateField;
    ZQrySellMasterwaktu: TTimeField;
    ZQrySellMasterkasir: TStringField;
    ZQrySellMastersubtotal: TFloatField;
    ZQrySellMastergrandtotal: TFloatField;
    ZQrySellMasterkembali: TFloatField;
    ZQrySellMasterisposted: TSmallintField;
    ZQrySellMasterlunas: TSmallintField;
    ZQrySellMastertotalpayment: TFloatField;
    ZQrySellMasterbayarskrg: TFloatField;
    ZQrySellMasterchecked: TSmallintField;
    ZQryFormSellquantity: TFloatField;
    ZQryFormReturquantity: TFloatField;
    ZQryFormReturquantityretur: TFloatField;
    ZQryFormBuyquantity: TFloatField;
    ZQryListStockinqty: TFloatField;
    ZQryCustomercp: TStringField;
    ZQrySales: TZReadOnlyQuery;
    ZQrySalesidsales: TIntegerField;
    ZQrySaleskode: TStringField;
    ZQrySalesnama: TStringField;
    ZQrySalesalamat: TStringField;
    ZQrySaleskota: TStringField;
    ZQrySalestgllahir: TDateField;
    ZQrySalestempatlahir: TStringField;
    ZQrySalestglmasuk: TDateField;
    ZQrySalesnoktp: TStringField;
    ZQrySalestglnoneffective: TDateField;
    ZQryFormSelldiskon_rp: TFloatField;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ZQryStockCard: TZQuery;
    frxDBStockCard: TfrxDBDataset;
    ZQryStock: TZQuery;
    ZQryStockkode: TStringField;
    ZQryStocknama: TStringField;
    frxDBStock: TfrxDBDataset;
    ZQrySearchCust: TZReadOnlyQuery;
    ZQrySearchCustkode: TStringField;
    ZQrySearchCustnama: TStringField;
    ZQrySearchCustalamat: TStringField;
    ZQrySearchCustkota: TStringField;
    ZQrySearchCusttgllahir: TDateField;
    dsSearchCust: TDataSource;
    ZQryReturJualalamat: TStringField;
    ZQryUserGroup: TZQuery;
    dsUserGroup: TDataSource;
    ZQryUserIDuser: TIntegerField;
    ZQryUserIDusergroup: TIntegerField;
    ZQryUsertglnoneffective: TDateField;
    ZQrysellingitem: TZReadOnlyQuery;
    frxDBsellingitem: TfrxDBDataset;
    frxXLSExport1: TfrxXLSExport;
    frxPDFExport1: TfrxPDFExport;
    ZQryFormReturhargabeli: TFloatField;
    ZQryFormReturdiskon_rp: TFloatField;
    ZQryReturJualfakturjual: TStringField;
    ZQryreturitem: TZReadOnlyQuery;
    ZQryreturitemtanggal: TDateField;
    ZQryreturitemfaktur: TStringField;
    ZQryreturitemcustomer: TStringField;
    ZQryreturitemnama: TStringField;
    ZQryreturitemqtyretur: TFloatField;
    ZQryreturitemhargajual: TFloatField;
    ZQryreturitemtot: TFloatField;
    ZQryreturitemdisc: TFloatField;
    ZQryreturitemsubtotal: TFloatField;
    frxDBreturitem: TfrxDBDataset;
    ZQryreturitemketerangan: TStringField;
    ZQryReturBelialamat: TStringField;
    ZQryReturBelikota: TStringField;
    ZQryReturBelilunas: TSmallintField;
    ZQryReturBelipembayaran: TStringField;
    ZQryReturBelichecked: TSmallintField;
    ZQryBuyingitemfaktur: TStringField;
    ZQryBuyingitemtanggal: TDateField;
    ZQryBuyingitemkode: TStringField;
    ZQryBuyingitemnama: TStringField;
    ZQryBuyingitemquantity: TFloatField;
    ZQryBuyingitemsatuan: TStringField;
    ZQryBuyingitemhargabeli: TFloatField;
    ZQryBuyingitemsubtotal: TFloatField;
    ZQryBuyingitemkodesupplier: TStringField;
    ZQryBuyingitemsupplier: TStringField;
    ZQryBuyMasteralamat: TStringField;
    ZQryBuyMasterkota: TStringField;
    ZQryFormAdjustkode: TStringField;
    ZQryFormAdjustnama: TStringField;
    ZQryFormAdjustquantity: TFloatField;
    ZQryFormAdjustquantityadjust: TFloatField;
    ZQryFormAdjustketerangan: TStringField;
    ZQryFormAdjustharga: TFloatField;
    ZQryFormAdjustsubtotal: TFloatField;
    ZQryFormAdjustkategori: TStringField;
    ZQryFormAdjustmerk: TStringField;
    ZQryFormAdjustseri: TStringField;
    ZQryFormAdjustfaktur: TStringField;
    ZQryFormAdjustdiskon: TFloatField;
    ZQryFormAdjustdiskonrp: TFloatField;
    ZQryFormAdjustsatuan: TStringField;
    ZQryHutangidBeli: TIntegerField;
    ZQryHutangfaktur: TStringField;
    ZQryHutangtanggal: TDateField;
    ZQryHutangwaktu: TTimeField;
    ZQryHutangkasir: TStringField;
    ZQryHutangkodesupplier: TStringField;
    ZQryHutangsupplier: TStringField;
    ZQryHutangalamat: TStringField;
    ZQryHutangkota: TStringField;
    ZQryHutangpembayaran: TStringField;
    ZQryHutangnogiro: TStringField;
    ZQryHutangtgljatuhtempo: TDateField;
    ZQryHutangsubtotal: TFloatField;
    ZQryHutangppn: TFloatField;
    ZQryHutangtotal: TFloatField;
    ZQryHutangdiskon: TFloatField;
    ZQryHutangdiskonrp: TFloatField;
    ZQryHutanggrandtotal: TFloatField;
    ZQryHutangDP: TFloatField;
    ZQryHutangkurang: TFloatField;
    ZQryHutangisposted: TSmallintField;
    ZQryHutanglunas: TSmallintField;
    ZQryHutangtotalpayment: TFloatField;
    ZQryHutangbayarskrg: TFloatField;
    ZQryHutangchecked: TSmallintField;
    ZQryHutanghutang: TFloatField;
    ZQryHutangkodenmsupp: TStringField;
    ZQryOperasionalketerangan: TStringField;
    ZQryFormOperasionalketerangan: TStringField;
    ZQryPaymentdetketerangan: TStringField;
    ZQryBuyMasternoinvoice: TStringField;
    ZQryStockCardtgltrans: TDateField;
    ZQryStockCardwaktu: TTimeField;
    ZQryStockCardfaktur: TStringField;
    ZQryStockCardtypetrans: TStringField;
    ZQryStockCardusername: TStringField;
    ZQryStockawal: TFloatField;
    ZQryStockbeli: TFloatField;
    ZQryStockjual: TFloatField;
    ZConnex: TZConnection;
    ZQryUtilex: TZReadOnlyQuery;
    ZQryReturBelinoinvoice: TStringField;
    ZQryReturBelisubtotal: TFloatField;
    ZQryReturBelippn: TFloatField;
    ZQryStockCardketerangan: TStringField;
    ZQryStockhargabeli: TFloatField;
    ZQryReturJualreturpajakno: TStringField;
    ZQryReturJualfakturpajakno: TStringField;
    ZQryReturJualnamacust: TStringField;
    ZQryReturJualalamatcust: TStringField;
    ZQryReturJualnpwpcust: TStringField;
    ZQryReturJualtglfaktur: TDateField;
    ZQryReturJualisposted: TSmallintField;
    ZQryReturBeliisposted: TSmallintField;
    ZQryPiutangisposted: TSmallintField;
    ZQryBuyMasterisposted: TSmallintField;
    ZQryBuyMasterlunas: TSmallintField;
    ZQryPiutanglunas: TSmallintField;
    ZQryPiutangreturisposted: TSmallintField;
    ZQryHutangreturisposted: TSmallintField;
    ZQrySearchProductIDproduct: TLargeintField;
    ZQrySearchProductbarcode: TStringField;
    ZQryFormSellipv: TStringField;
    ZQryFormOperasionalsigncolor: TSmallintField;
    ZQryFormOperasionalnourut: TLargeintField;
    ZQryFormOperasionalipv: TStringField;
    ZQryFormAdjustipv: TStringField;
    ZQryFormBuyipv: TStringField;
    ZQryFormReturipv: TStringField;
    ZQryFormSellnourut: TLargeintField;
    ZQryFormReturnourut: TLargeintField;
    ZQryFormAdjustnourut: TLargeintField;
    ZQrySellMasterIDcustomer: TIntegerField;
    ZQrySellMasterdiscbulat: TFloatField;
    ZQrySellMasterbayartunai: TFloatField;
    ZQrySellMasterbayarcard: TFloatField;
    ZQrySellMastercardbank: TStringField;
    ZQrySellMastercardno: TStringField;
    ZQrySellMastercardname: TStringField;
    ZQrySellMasterketerangan: TStringField;
    ZQryProductIDproduct: TLargeintField;
    ZQryProductbarcode: TStringField;
    ZQrypindahgudanglist: TZReadOnlyQuery;
    ZQrypindahgudanglistIDpindahgudang: TIntegerField;
    ZQrypindahgudanglistdocno: TStringField;
    ZQrypindahgudanglistdoctgl: TDateField;
    ZQrypindahgudanglistIDgudang: TIntegerField;
    ZQrypindahgudanglistIDgudangto: TIntegerField;
    ZQrypindahgudanglistnotes: TStringField;
    ZQrypindahgudanglistIDuserposted: TIntegerField;
    ZQrypindahgudanglistusernameposted: TStringField;
    ZQrypindahgudanglistposted: TDateTimeField;
    ZQrypindahgudanglistnmgudang: TStringField;
    ZQrypindahgudanglistnmgudangto: TStringField;
    dspindahgudanglist: TDataSource;
    ZQrypindahgudanglistdet: TZReadOnlyQuery;
    dspindahgudanglistdet: TDataSource;
    ZQrypindahgudanglistdetIDpindahgudang: TIntegerField;
    ZQrypindahgudanglistdetIDproduct: TIntegerField;
    ZQrypindahgudanglistdetkode: TStringField;
    ZQrypindahgudanglistdetsatuan: TStringField;
    ZQrypindahgudanglistdetqty: TFloatField;
    ZQrypindahgudangdetform: TZQuery;
    dspindahgudangdetform: TDataSource;
    ZQrypindahgudangdetformipv: TStringField;
    ZQrypindahgudangdetformkode: TStringField;
    ZQrypindahgudangdetformsatuan: TStringField;
    ZQrypindahgudangdetformqty: TFloatField;
    ZQrypindahgudanglistrep: TZReadOnlyQuery;
    frxDBpindahgudanglistrep: TfrxDBDataset;
    ZQryProductqty: TFloatField;
    ZQryProductqtybad: TFloatField;
    ZQrySearchProductqty: TFloatField;
    ZQrySearchProductqtybad: TFloatField;
    ZQrypindahgudangdetformnama: TStringField;
    ZQrypindahgudanglistdetnama: TStringField;
    ZQryProductIDgolongan: TIntegerField;
    ZQrySearchProductIDgolongan: TIntegerField;
    ZQrySearchProductreorderqty: TFloatField;
    ZQryProductreorderqty: TFloatField;
    ZQrygolongan: TZReadOnlyQuery;
    ZQrygolonganIDgolongan: TIntegerField;
    ZQrygolongankode: TStringField;
    ZQrygolongannama: TStringField;
    dsgolongan: TDataSource;
    ZQryFormSellkategori: TStringField;
    ZQryFormAdjusthargajual: TFloatField;
    ZQrypindahgudangdetformhargabeli: TFloatField;
    ZQrypindahgudangdetformhargajual: TFloatField;
    ZQrystokGol: TZReadOnlyQuery;
    dsstokGol: TDataSource;
    ZQrystokGolIDgolongan: TIntegerField;
    ZQrystokGolkode: TStringField;
    ZQrystokGolnama: TStringField;
    ZQrystokGolqty: TFloatField;
    ZQrystokGolvalue: TFloatField;
    ZQryProductSL: TFloatField;
    ZQryProductSLT: TFloatField;
    ZQryProductCT: TFloatField;
    ZQryProductCTT: TFloatField;
    ZQryProductCB: TFloatField;
    ZQryProductCBT: TFloatField;
    ZQryProductSLR: TFloatField;
    ZQryProductCTR: TFloatField;
    ZQryProductCBR: TFloatField;
    ZQryProductqtytoko: TFloatField;
    ZQrySearchProductSL: TFloatField;
    ZQrySearchProductSLT: TFloatField;
    ZQrySearchProductCT: TFloatField;
    ZQrySearchProductCTT: TFloatField;
    ZQrySearchProductCB: TFloatField;
    ZQrySearchProductCBT: TFloatField;
    ZQrySearchProductSLR: TFloatField;
    ZQrySearchProductCTR: TFloatField;
    ZQrySearchProductCBR: TFloatField;
    ZQrySearchProductqtytoko: TFloatField;
    frxDBstokGol: TfrxDBDataset;
    ZQrydiskondetform: TZQuery;
    dsdiskondetform: TDataSource;
    ZQrydiskondetformipv: TStringField;
    ZQrydiskondetformIDproduct: TLargeintField;
    ZQrydiskondetformkode: TStringField;
    ZQrydiskondetformnama: TStringField;
    ZQrydiskondetformsatuan: TStringField;
    ZQrydiskondetformhargajual: TFloatField;
    ZQrydiskondetformdiskonrp: TFloatField;
    ZQrydiskondetformminqty: TFloatField;
    ZQrydiskondetformmaxqty: TFloatField;
    ZQrydiskondetformhargajualakhir: TFloatField;
    ZQrydiskondetformhargabeli: TFloatField;
    ZQrydiskonlist: TZReadOnlyQuery;
    dsdiskonlist: TDataSource;
    ZQrydiskondetlist: TZReadOnlyQuery;
    dsdiskondetlist: TDataSource;
    ZQrydiskonlistIDdiskon: TIntegerField;
    ZQrydiskonlistdocno: TStringField;
    ZQrydiskonlistdoctgl: TDateField;
    ZQrydiskonlisttglawal: TDateField;
    ZQrydiskonlisttglakhir: TDateField;
    ZQrydiskonlistisactive: TSmallintField;
    ZQrydiskonlistnotes: TStringField;
    ZQrydiskonlistIDuserposted: TIntegerField;
    ZQrydiskonlistusernameposted: TStringField;
    ZQrydiskonlistposted: TDateTimeField;
    ZQrydiskondetlistIDdiskon: TIntegerField;
    ZQrydiskondetlistIDproduct: TLargeintField;
    ZQrydiskondetlistkode: TStringField;
    ZQrydiskondetlistnama: TStringField;
    ZQrydiskondetlistsatuan: TStringField;
    ZQrydiskondetlisthargajual: TFloatField;
    ZQrydiskondetlistdiskonrp: TFloatField;
    ZQrydiskondetlistminqty: TFloatField;
    ZQrydiskondetlistmaxqty: TFloatField;
    ZQrydiskondetlisthargabeli: TFloatField;
    ZQrydiskondetlisthargajualakhir: TFloatField;
    ZQrydiskondetlistbarcode: TStringField;
    frxDBdiskondetlist: TfrxDBDataset;
    ZQryterimagudangdetform: TZQuery;
    dsterimagudangdetform: TDataSource;
    ZQryterimagudangdetformipv: TStringField;
    ZQryterimagudangdetformIDproduct: TIntegerField;
    ZQryterimagudangdetformkode: TStringField;
    ZQryterimagudangdetformnama: TStringField;
    ZQryterimagudangdetformsatuan: TStringField;
    ZQryterimagudangdetformqty: TFloatField;
    ZQryterimagudangdetformhargabeli: TFloatField;
    ZQryterimagudangdetformhargajual: TFloatField;
    ZQryterimagudanglist: TZReadOnlyQuery;
    dsterimagudanglist: TDataSource;
    ZQryterimagudanglistIDterimagudang: TIntegerField;
    ZQryterimagudanglistdocno: TStringField;
    ZQryterimagudanglistdoctgl: TDateField;
    ZQryterimagudanglistIDgudangfrom: TIntegerField;
    ZQryterimagudanglistIDgudang: TIntegerField;
    ZQryterimagudanglistnotes: TStringField;
    ZQryterimagudanglistIDuserposted: TIntegerField;
    ZQryterimagudanglistusernameposted: TStringField;
    ZQryterimagudanglistposted: TDateTimeField;
    ZQryterimagudanglistnmgudang: TStringField;
    ZQryterimagudanglistnmgudangto: TStringField;
    ZQryterimagudanglistdet: TZReadOnlyQuery;
    dsterimagudanglistdet: TDataSource;
    ZQryterimagudanglistdetIDproduct: TIntegerField;
    ZQryterimagudanglistdetkode: TStringField;
    ZQryterimagudanglistdetnama: TStringField;
    ZQryterimagudanglistdetsatuan: TStringField;
    ZQryterimagudanglistdetqty: TFloatField;
    ZQryterimagudanglistdethargabeli: TFloatField;
    ZQryterimagudanglistdethargajual: TFloatField;
    ZQryterimagudanglistrep: TZReadOnlyQuery;
    frxDBterimagudanglistrep: TfrxDBDataset;
    ZQrypodetform: TZQuery;
    dspodetform: TDataSource;
    ZQrypodetformipv: TStringField;
    ZQrypodetformkode: TStringField;
    ZQrypodetformnama: TStringField;
    ZQrypodetformsatuan: TStringField;
    ZQrypodetformqty: TFloatField;
    ZQrypodetformhargabeli: TFloatField;
    ZQrypodetformhargajual: TFloatField;
    ZQrypolist: TZReadOnlyQuery;
    dspolist: TDataSource;
    ZQrypodetlist: TZReadOnlyQuery;
    dspodetlist: TDataSource;
    ZQrypolistIDpurchaseorder: TIntegerField;
    ZQrypolistIDsupplier: TIntegerField;
    ZQrypolistpono: TStringField;
    ZQrypolisttgl: TDateField;
    ZQrypolisttotalprice: TFloatField;
    ZQrypolistnotes: TStringField;
    ZQrypolistIDuserposted: TIntegerField;
    ZQrypolistusernameposted: TStringField;
    ZQrypodetlistIDpurchaseorder: TIntegerField;
    ZQrypodetlistIDproduct: TIntegerField;
    ZQrypodetlistkode: TStringField;
    ZQrypodetlistnama: TStringField;
    ZQrypodetlistsatuan: TStringField;
    ZQrypodetlistqty: TFloatField;
    ZQrypodetlisthargabeli: TFloatField;
    ZQrypodetlisthargajual: TFloatField;
    ZQrypodetlisttotalrp: TFloatField;
    frxDBpodetlist: TfrxDBDataset;
    ZQrypodetlistbarcode: TStringField;
    ZQrypolistnmsupplier: TStringField;
    ZQrypolistposted: TDateTimeField;
    ZQrypodetformtotalprice: TFloatField;
    ZQryBuyMastertempohari: TSmallintField;
    ZQryBuyMasterbayarskrg: TFloatField;
    ZQryBuyMasterchecked: TSmallintField;
    ZQryBuyMasterkodegudang: TStringField;
    ZQryBuyMasterpono: TStringField;
    ZQryProductexpdate: TDateField;
    ZQrystokexpdate: TZReadOnlyQuery;
    ZQrystokexpdatekode: TStringField;
    ZQrystokexpdatebarcode: TStringField;
    ZQrystokexpdatenama: TStringField;
    ZQrystokexpdatehargabeli: TFloatField;
    ZQrystokexpdatehargajual: TFloatField;
    ZQrystokexpdateqty: TFloatField;
    ZQrystokexpdateexpdate: TDateField;
    ZQrystokexpdatesisahari: TLargeintField;
    frxDBstokexpdate: TfrxDBDataset;
    ZQrystokgoldet: TZReadOnlyQuery;
    dsstokgoldet: TDataSource;
    frxDBstokgoldet: TfrxDBDataset;
    ZQrystokgoldetIDgolongan: TIntegerField;
    ZQrystokgoldetkode: TStringField;
    ZQrystokgoldetbarcode: TStringField;
    ZQrystokgoldetnama: TStringField;
    ZQrystokgoldetqty: TFloatField;
    ZQrystokgoldetvalue: TFloatField;
    ZQryterimagudanglistrepIDgolongan: TIntegerField;
    ZQryterimagudanglistrepkode: TStringField;
    ZQryterimagudanglistrepnama: TStringField;
    ZQryterimagudanglistrepqty: TFloatField;
    ZQryterimagudanglistrepvalue: TFloatField;
    ZQryterimagudanglistrepdet: TZReadOnlyQuery;
    frxDBterimagudanglistrepdet: TfrxDBDataset;
    dsterimagudanglistrep: TDataSource;
    ZQryterimagudanglistrepdetIDterimagudang: TIntegerField;
    ZQryterimagudanglistrepdetIDgolongan: TIntegerField;
    ZQryterimagudanglistrepdetkode: TStringField;
    ZQryterimagudanglistrepdetbarcode: TStringField;
    ZQryterimagudanglistrepdetnama: TStringField;
    ZQryterimagudanglistrepdetqty: TFloatField;
    ZQryterimagudanglistrepdetvalue: TFloatField;
    ZQryterimagudanglistrepIDterimagudang: TIntegerField;
    ZQryterimagudanglistdetIDterimagudang: TIntegerField;
    ZQrypindahgudanglistrepIDpindahgudang: TIntegerField;
    ZQrypindahgudanglistrepIDgolongan: TIntegerField;
    ZQrypindahgudanglistrepkode: TStringField;
    ZQrypindahgudanglistrepnama: TStringField;
    ZQrypindahgudanglistrepqty: TFloatField;
    ZQrypindahgudanglistrepvalue: TFloatField;
    ZQrypindahgudanglistrepdet: TZReadOnlyQuery;
    frxDBpindahgudanglistrepdet: TfrxDBDataset;
    dspindahgudanglistrep: TDataSource;
    ZQrypindahgudanglistrepdetIDpindahgudang: TIntegerField;
    ZQrypindahgudanglistrepdetIDgolongan: TIntegerField;
    ZQrypindahgudanglistrepdetkode: TStringField;
    ZQrypindahgudanglistrepdetbarcode: TStringField;
    ZQrypindahgudanglistrepdetnama: TStringField;
    ZQrypindahgudanglistrepdetqty: TFloatField;
    ZQrypindahgudanglistrepdetvalue: TFloatField;
    ZQrystokmutasirep: TZReadOnlyQuery;
    frxDBstokmutasirep: TfrxDBDataset;
    ZQryReturBelikodegudang: TStringField;
    ZQrystokmutasirepqtyawal: TFloatField;
    ZQrystokmutasirepamountawal: TFloatField;
    ZQrystokmutasirepqtymasuk: TFloatField;
    ZQrystokmutasirepamountmasuk: TFloatField;
    ZQrystokmutasirepqtyjual: TFloatField;
    ZQrystokmutasirepamountjual: TFloatField;
    ZQrystokmutasirepqtykeluar: TFloatField;
    ZQrystokmutasirepamountkeluar: TFloatField;
    ZQrystokmutasirepkode: TStringField;
    ZQrystokmutasirepnama: TStringField;
    ZQrySellMasterppn: TFloatField;
    ZQrySellMasterfakturpajakno: TStringField;
    ZQrySellMastertotalretur: TFloatField;
    ZQrysellingkasir: TZReadOnlyQuery;
    frxDBsellingkasir: TfrxDBDataset;
    ZQrysellingkasirnokasir: TStringField;
    ZQrysellingkasirkasir: TStringField;
    ZQrysellingkasirsubtotal: TFloatField;
    ZQrysellingkasirdiskon: TFloatField;
    ZQrysellingkasirtotaljual: TFloatField;
    ZQrysellingkasirtunai: TFloatField;
    ZQrysellingkasircard: TFloatField;
    ZQrysellingkasirtotalretur: TFloatField;
    ZQrysellinggol: TZReadOnlyQuery;
    frxDBsellinggol: TfrxDBDataset;
    ZQrysellinggolkode: TStringField;
    ZQrysellinggolnama: TStringField;
    ZQrysellinggolfrek: TLargeintField;
    ZQrysellinggolqty: TFloatField;
    ZQrysellinggoldisc: TFloatField;
    ZQrysellinggolsubtotal: TFloatField;
    ZQrybuyingrep: TZReadOnlyQuery;
    frxDBbuyingrep: TfrxDBDataset;
    ZQrybuyingreptanggal: TDateField;
    ZQrybuyingrepfaktur: TStringField;
    ZQrybuyingrepnoinvoice: TStringField;
    ZQrybuyingrepsupplier: TStringField;
    ZQrybuyingrepquantity: TFloatField;
    ZQrybuyingrepgrandtotal: TFloatField;
    ZQrybuyingrep2: TZReadOnlyQuery;
    frxDBbuyingrep2: TfrxDBDataset;
    ZQrybuyingrep2tanggal: TDateField;
    ZQrybuyingrep2faktur: TStringField;
    ZQrybuyingrep2noinvoice: TStringField;
    ZQrybuyingrep2supplier: TStringField;
    ZQrybuyingrep2quantity: TFloatField;
    ZQrybuyingrep2totalbeli: TFloatField;
    ZQrybuyingrep2totaljual: TFloatField;
    ZQrybuyingrep2tgljatuhtempo: TDateField;
    ZQrybuyingrep2pembayaran: TStringField;
    ZQrysellingtop: TZReadOnlyQuery;
    frxDBsellingtop: TfrxDBDataset;
    ZQrysellingtopkode: TStringField;
    ZQrysellingtopbarcode: TStringField;
    ZQrysellingtopnama: TStringField;
    ZQrysellingtopqty: TFloatField;
    ZQrysellingtophargajual: TFloatField;
    ZQrysellingtopstok: TFloatField;
    ZQryubahhargadetform: TZQuery;
    dsubahhargadetform: TDataSource;
    ZQryubahhargadetformipv: TStringField;
    ZQryubahhargadetformkode: TStringField;
    ZQryubahhargadetformnama: TStringField;
    ZQryubahhargadetformsatuan: TStringField;
    ZQryubahhargadetformhargabeli: TFloatField;
    ZQryubahhargadetformhargajual: TFloatField;
    ZQryubahhargadetformhargajualbaru: TFloatField;
    ZQryubahhargadetformtglberlaku: TDateField;
    ZQryubahhargalist: TZReadOnlyQuery;
    dsubahhargalist: TDataSource;
    ZQryubahhargalistIDubahharga: TIntegerField;
    ZQryubahhargalistdocno: TStringField;
    ZQryubahhargalistdoctgl: TDateField;
    ZQryubahhargalistnotes: TStringField;
    ZQryubahhargalistIDuserposted: TIntegerField;
    ZQryubahhargalistusernameposted: TStringField;
    ZQryubahhargalistposted: TDateTimeField;
    ZQryubahhargalistdet: TZReadOnlyQuery;
    dsubahhargalistdet: TDataSource;
    ZQryubahhargalistdetIDubahharga: TIntegerField;
    ZQryubahhargalistdetIDproduct: TIntegerField;
    ZQryubahhargalistdetkode: TStringField;
    ZQryubahhargalistdetnama: TStringField;
    ZQryubahhargalistdetsatuan: TStringField;
    ZQryubahhargalistdethargabeli: TFloatField;
    ZQryubahhargalistdethargajual: TFloatField;
    ZQryubahhargalistdethargajualbaru: TFloatField;
    ZQryubahhargalistdettglberlaku: TDateField;
    ZQryubahhargalistdetket: TStringField;
    ZQryubahhargalistdetkodegol: TStringField;
    ZQryubahhargalistdetnamagol: TStringField;
    frxDBubahhargalistdet: TfrxDBDataset;
    ZQryubahhargalistdetbarcode: TStringField;
    ZConserverrw: TZConnection;
    ZQryFormBuybarcode: TStringField;
    ZQryBuyMasterIDuserposted: TIntegerField;
    ZQrySearchProductexpdate: TDateField;
    ZQrySearchProductkategori: TStringField;
    ZQrystruk: TZReadOnlyQuery;
    ZQrystrukIDstruk: TSmallintField;
    ZQrystrukcompany: TStringField;
    ZQrystrukalamat: TStringField;
    ZQrystrukkota: TStringField;
    ZQrystrukcabang: TStringField;
    ZQrystrukfooter1: TStringField;
    ZQrystrukfooter2: TStringField;
    ZQrystrukfooter3: TStringField;
    ZQrystrukfooter4: TStringField;
    ZQrystrukfooter5: TStringField;
    ZQrystrukendfooter1: TStringField;
    ZQrystrukendfooter2: TStringField;
    ZQrystrukendfooter3: TStringField;
    ZQrystrukmintrans: TFloatField;
    ZQrystrukisaktif: TSmallintField;
    ZQryUserGroupIDusergroup: TIntegerField;
    ZQryUserGroupusergroup: TStringField;
    ZQryUserGroupisedit: TSmallintField;
    ZQryUserGroupisdel: TSmallintField;
    ZQrypindahgudanglistrepbarcode: TStringField;
    ZQrylabelharga: TZReadOnlyQuery;
    ZQrylabelhargakode1: TStringField;
    ZQrylabelhargakode2: TStringField;
    ZQrylabelhargakode3: TStringField;
    ZQrylabelharganama1: TStringField;
    ZQrylabelharganama2: TStringField;
    ZQrylabelharganama3: TStringField;
    ZQrylabelhargahjual1: TFloatField;
    ZQrylabelhargahjual2: TFloatField;
    ZQrylabelhargahjual3: TFloatField;
    ZQrylabelhargabarcode1: TStringField;
    ZQrylabelhargabarcode2: TStringField;
    ZQrylabelhargabarcode3: TStringField;
    frxDBlabelharga: TfrxDBDataset;
    ZQryubahhargadetformIDproduct: TLargeintField;
    ZQrypindahgudangdetformIDproduct: TLargeintField;
    ZQrypodetformIDproduct: TLargeintField;
    ZQryselltourgroup: TZReadOnlyQuery;
    ZQryselltourgroupIDselltourgroup: TLargeintField;
    ZQryselltourgroupnogroup: TStringField;
    ZQryselltourgrouptgl: TDateField;
    ZQryselltourgroupnamatour: TStringField;
    ZQryselltourgroupleader: TStringField;
    ZQryselltourgroupdriver: TStringField;
    ZQryselltourgroupasal: TStringField;
    ZQryselltourgrouptujuan: TStringField;
    ZQryselltourgroupketerangan: TMemoField;
    dsselltourgroup: TDataSource;
    ZQrySellMasterIDselltourgroup: TLargeintField;
    ZQrySellMasterIDsales: TIntegerField;
    ZQrySellMasternmsales: TStringField;
    ZQryProductfeebiro: TFloatField;
    ZQryFormSellfeebiro: TFloatField;
    ZQrySearchProductfeebiro: TFloatField;
    ZQrySearchProductfeedrivertl: TFloatField;
    ZQrystrukphone: TStringField;
    ZQrySearchCustIDcustomer: TIntegerField;
    ZQryProductmargin: TFloatField;
    ZQryProductfeedrivertl: TFloatField;
    ZQryFormSellfeedrivertl: TFloatField;
    ZQrygolongandepartemen: TStringField;
    ZQrySellMasternmcust: TStringField;
    ZQryFormBuybarcode128: TStringField;
    ZQryProductbarcode128: TStringField;
    ZQryprintbarcode: TZReadOnlyQuery;
    frxDBprintbarcode: TfrxDBDataset;
    ZQryprintbarcodenama1: TStringField;
    ZQryprintbarcodebbarcode1: TStringField;
    ZQryprintbarcodebarcode1: TStringField;
    ZQryprintbarcodenama2: TStringField;
    ZQryprintbarcodebbarcode2: TStringField;
    ZQryprintbarcodebarcode2: TStringField;
    ZQryselltourgrouptotrp: TFloatField;
    ZQryprintbarcodeprice1: TStringField;
    ZQryprintbarcodeprice2: TStringField;
    ZQryFormSell2: TZQuery;
    ZQryFormSell2kode: TStringField;
    ZQryFormSell2nama: TStringField;
    ZQryFormSell2harga: TFloatField;
    ZQryFormSell2quantity: TFloatField;
    ZQryFormSell2totalharga: TFloatField;
    ZQryFormSell2diskon: TFloatField;
    ZQryFormSell2diskonrp: TFloatField;
    ZQryFormSell2diskon_rp: TFloatField;
    ZQryFormSell2subtotal: TFloatField;
    ZQryFormSell2faktur: TStringField;
    ZQryFormSell2kategori: TStringField;
    ZQryFormSell2merk: TStringField;
    ZQryFormSell2seri: TStringField;
    ZQryFormSell2satuan: TStringField;
    ZQryFormSell2hargabeli: TFloatField;
    ZQryFormSell2idstts: TSmallintField;
    ZQryFormSell2nourut: TLargeintField;
    ZQryFormSell2ipv: TStringField;
    ZQryFormSell2feebiro: TFloatField;
    ZQryFormSell2feedrivertl: TFloatField;
    ZQryselltourgroupjenisbus: TSmallintField;
    ZQryselltourgroupnmjenisbus: TStringField;
    ZQryselltourgrouppresentfee: TFloatField;
    ZQrystrukpresentfeebusbesar: TFloatField;
    ZQrystrukpresentfeebuskecil: TFloatField;
    ZQrystrukpresentfeebusrental: TFloatField;
    ZQryselltourgroupjumlorg: TIntegerField;
    ZQrysellingitemkode: TStringField;
    ZQrysellingitemnama: TStringField;
    ZQrysellingitemqty: TFloatField;
    ZQrysellingitemharga: TFloatField;
    ZQrysellingitemdiskon: TFloatField;
    ZQrysellingitemsubtotal: TFloatField;
    ZQrysellingitemhargabeli: TFloatField;
    ZQrysellingitemmodal: TFloatField;
    ZQryadjustlist: TZReadOnlyQuery;
    ZQryadjustlistidAdjust: TIntegerField;
    ZQryadjustlistfaktur: TStringField;
    ZQryadjustlisttanggal: TDateField;
    ZQryadjustlistwaktu: TTimeField;
    ZQryadjustlistoperator: TStringField;
    ZQryadjustlisttotaladjust: TFloatField;
    ZQryadjustlistisposted: TIntegerField;
    ZQryadjustlistkodegudang: TStringField;
    ZQryadjustlistnmgdg: TStringField;
    ZQryadjustlistdet: TZReadOnlyQuery;
    dsadjustlistdet: TDataSource;
    ZQryadjustlistdetidAdjust: TIntegerField;
    ZQryadjustlistdetfaktur: TStringField;
    ZQryadjustlistdetkode: TStringField;
    ZQryadjustlistdetnama: TStringField;
    ZQryadjustlistdetkategori: TStringField;
    ZQryadjustlistdetmerk: TStringField;
    ZQryadjustlistdetseri: TStringField;
    ZQryadjustlistdetketerangan: TStringField;
    ZQryadjustlistdetqtybefore: TFloatField;
    ZQryadjustlistdetqtyafter: TFloatField;
    ZQryadjustlistdethargabeli: TFloatField;
    ZQryadjustlistdethargajual: TFloatField;
    ZQryadjustlistdetdiskon: TFloatField;
    ZQryadjustlistdetdiskonrp: TFloatField;
    ZQryadjustlistdetsatuan: TStringField;
    ZQryadjustlistdetsubtotal: TFloatField;
    frxDBadjustlistdet: TfrxDBDataset;
    ZQrySellMasterdiscpct: TFloatField;
    ZQrySellMasterdiscrp: TFloatField;
    frxDBselltourgroup: TfrxDBDataset;
    ZQrysellinggolmodal: TFloatField;
    ZQrySellMastermodal: TFloatField;
    ZQryFormSellfeerent: TFloatField;
    ZQryProductfeerent: TFloatField;
    ZQrySearchProductfeerent: TFloatField;
    ZConserver: TZConnection;
    ZQryselltourgroup2: TZReadOnlyQuery;
    dsselltourgroup2: TDataSource;
    ZQryselltourgroup2IDselltourgroup: TLargeintField;
    ZQryselltourgroup2nogroup: TStringField;
    ZQryselltourgroup2tgl: TDateField;
    ZQryselltourgroup2namatour: TStringField;
    ZQryselltourgroup2jumlorg: TIntegerField;
    ZQryselltourgroup2leader: TStringField;
    ZQryselltourgroup2driver: TStringField;
    ZQryselltourgroup2asal: TStringField;
    ZQryselltourgroup2tujuan: TStringField;
    ZQryselltourgroup2keterangan: TMemoField;
    ZQryselltourgroup2jenisbus: TSmallintField;
    ZQryselltourgroup2presentfee: TFloatField;
    ZQryselltourgroup2totrp: TFloatField;
    ZQryselltourgroup2nmjenisbus: TStringField;
    ZQrySearchProductbarcode128: TStringField;
    ZQryFormBuynourut: TLargeintField;
    ZQryCustomerIDcustomer: TIntegerField;
    ZQryCustomernpwp: TStringField;
    ZQryStockCardmasuk: TLargeintField;
    ZQryStockCardsisa: TLargeintField;
    ZQryStockCardkeluar: TFloatField;
    ZQryStockCardkodegdg: TStringField;
    ZQrystrukmt: TSmallintField;
    ZQryttkonsi: TZQuery;
    ZQryttkonsiidttkonsi: TIntegerField;
    ZQryttkonsiidbeli: TIntegerField;
    ZQryttkonsisubtotal: TFloatField;
    dsttkonsi: TDataSource;
    ZQryuseraccessreport: TZReadOnlyQuery;
    ZQryuseraccessreportno: TIntegerField;
    ZQryuseraccessreporttanggal: TDateField;
    ZQryuseraccessreportwaktu: TTimeField;
    ZQryuseraccessreportusername: TStringField;
    ZQryuseraccessreportcomputername: TStringField;
    ZQryuseraccessreportketerangan: TStringField;
    dsuseraccessreport: TDataSource;
    frxuseraccessreport: TfrxDBDataset;
    ZQrymember: TZReadOnlyQuery;
    dsmember: TDataSource;
    ZQrymembercardno: TStringField;
    ZQrymembernama: TStringField;
    ZQrymemberktpno: TStringField;
    ZQrymemberhpno: TStringField;
    ZQrymembergolongan: TStringField;
    ZQrymembertglreg: TDateField;
    ZQrymembertglnoneffective: TDateField;
    frxDBMember: TfrxDBDataset;
    ZQrymemberketerangan: TMemoField;
    ZQrymemberabsensi: TZReadOnlyQuery;
    dsmemberabsensi: TDataSource;
    ZQrymemberabsensinogroup: TStringField;
    ZQrymemberabsensinamatour: TStringField;
    ZQrymemberabsensitgl: TDateTimeField;
    ZQrymemberabsensicardno: TStringField;
    ZQrymemberabsensinama: TStringField;
    ZQrymemberabsensireward: TZQuery;
    dsmemberabsensireward: TDataSource;
    ZQrymemberabsensirewardtgl: TDateTimeField;
    ZQrymemberabsensirewardIDselltourgroup: TLargeintField;
    ZQrymemberabsensirewardIDuser: TIntegerField;
    ZQrymemberabsensirewardrewardmember: TFloatField;
    ZQrymemberabsensirewardisprint: TSmallintField;
    ZQrymemberreward: TZReadOnlyQuery;
    dsmemberreward: TDataSource;
    ZQrymemberrewardfaktur: TStringField;
    ZQrymemberrewardtgl: TDateTimeField;
    ZQrymemberrewardtotalreward: TFloatField;
    ZQrymemberrewardIDuser: TIntegerField;
    ZQrymemberrewardcardno: TStringField;
    ZQrymemberrewardnama: TStringField;
    ZQryprintreward: TZReadOnlyQuery;
    ZQryprintrewardfaktur: TStringField;
    ZQryprintrewardcardno: TStringField;
    ZQryprintrewardnama: TStringField;
    ZQryprintrewardgolongan: TStringField;
    ZQryprintrewardnogroup: TStringField;
    ZQryprintrewardnamatour: TStringField;
    ZQryprintrewardjenis: TStringField;
    ZQryprintrewardrewardmember: TFloatField;
    ZQryprintrewardtglreward: TDateField;
    ZQryprintrewardusername: TStringField;
    ZQryprintrewardtglwktreward: TDateTimeField;
    frxDBprintreward: TfrxDBDataset;
    ZQrymemberIDuser: TIntegerField;
    ZQrymemberusername: TStringField;
    ZQrymemberlokasi: TStringField;
    ZQrymemberabsensirewardcardno: TStringField;
    ZQrymemberabsensirewardnogroup: TStringField;
    ZQrymemberabsensirewardnamatour: TStringField;
    ZQrymemberabsensirewardjenisbus: TSmallintField;
    ZQrymemberabsensirewardfaktur: TStringField;
    ZQrymemberabsensirewardusername: TStringField;
    ZQrymemberabsensirewardlokasi: TStringField;
    ZQrymemberrewardusername: TStringField;
    ZQrymemberrewardlokasi: TStringField;
    ZQrymemberabsensilokasi: TStringField;
    frxDBmemberabsensi: TfrxDBDataset;
    ZQryprintrewardtgl: TDateTimeField;
    ZQryprintrewardlokasi: TStringField;
    frxDBmemberreward: TfrxDBDataset;
    ZQrymemberrewardtgldate: TDateField;
    ZQryprintoutreward: TZReadOnlyQuery;
    frxDBprintoutreward: TfrxDBDataset;
    ZQryprintoutrewardcardno: TStringField;
    ZQryprintoutrewardnama: TStringField;
    ZQryprintoutrewardtgl: TDateTimeField;
    ZQryprintoutrewardgolongan: TStringField;
    ZQryprintoutrewardlokasi: TStringField;
    ZQryprintoutrewardnogroup: TStringField;
    ZQryprintoutrewardnamatour: TStringField;
    ZQryprintoutrewardrewardmember: TFloatField;
    ZQryprintoutrewardjenisbus: TStringField;
    ZConnremotemysql: TZConnection;
    ZQryremotemysql: TZReadOnlyQuery;
    ZQrystrukrewardmember: TFloatField;
    ZSQLProc: TZSQLProcessor;
    ZQrymemberabsensiusername: TStringField;
    ZQryselltourgroup2norental: TStringField;
    ZQryselltourgroupnorental: TStringField;
    ZQryselltourgroupnogrp: TStringField;
    ZQryselltourgroup2nogrp: TStringField;
    ZQrySellMasternogrp: TStringField;
    ZQrymemberabsensigolongan: TStringField;
    ZQrystrukrewardcair: TSmallintField;
    ZQrymemberabsensipresentfee: TFloatField;
    ZQrymemberabsensijumlmbr: TSmallintField;
    procedure CanGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure ZQryFormOperasionalketeranganGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure ZQrydiskondetformCalcFields(DataSet: TDataSet);
    procedure ZQrypodetformCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure connectdb;
  public
    { Public declarations }
    procedure exportcustomer;
    procedure exportproduct;
    procedure exportsales;
    procedure exportsupplier;
    procedure exportexternal;
    procedure exportbuy;
  end;

const
  BROWSE_ACCESS = 0;
  ADD_ACCESS    = 1;
  EDIT_ACCESS   = 2;
  CLEAR_ACCESS  = 3;

  ALL_ITEM_VAL = '-- SEMUA --';

var
  DataModule1: TDataModule1;
  ConfigINI: TStringList;
  hostname,dbname,usernamedb,passworddb,portstruk,vpathsource,printerbarcode: string;
  TglSkrg: TDatetime;
  ConfigList: TStringList;
  UserName, passwd, UserGroup, vpath,PicturePath,ConfigPath,KodeGudang,standpos,HeaderTitleRep,UserRight,ipcomp,namagudang,pgpathloc,lokasigudang: string;
  isLoged,isedit,isdel : boolean;
  IDuserlogin, IDUserGroup : integer;
  isdblocal,konekserver : boolean;
  rewardmember : double;
  rewardcair : byte;

implementation

uses sparepartfunction;

{$R *.dfm}

procedure TDataModule1.exportcustomer;
var vidcustomer : integer;
    vtglreg, vtgllahir, vtglnonef : string;
begin
//// export customer   ////////////////////////
 ZQryUtilex.Close;
 ZQryUtilex.SQL.Text := 'select max(IDcustomer) from customer ';
 ZQryUtilex.Open;
 if (ZQryUtilex.IsEmpty)or(ZQryUtilex.Fields[0].IsNull) then vidcustomer := -1001
 else vidcustomer := ZQryUtilex.Fields[0].AsInteger;
 ZQryUtilex.Close;

 ZQryUtil.Close;
 ZQryUtil.SQL.Text := 'select IDcustomer,kode,nama,alamat,alamat2,kota,kota2,kodepos'+
                      ',telephone,telephone2,fax,email,website,cp,hp,hp2,hobby,notes,tglreg,tgllahir,tglnoneffective from customer where IDcustomer>'+inttostr(vidcustomer);
 ZQryUtil.Open;
 while not ZQryUtil.Eof do
 begin
  if ZQryUtil.Fields[18].IsNull then vtglreg := 'null' else vtglreg := Quotedstr(getmysqldatestr(ZQryUtil.Fields[18].Asdatetime));
  if ZQryUtil.Fields[19].IsNull then vtgllahir := 'null' else vtgllahir := Quotedstr(getmysqldatestr(ZQryUtil.Fields[19].Asdatetime));
  if ZQryUtil.Fields[20].IsNull then vtglnonef := 'null' else vtglnonef := Quotedstr(getmysqldatestr(ZQryUtil.Fields[20].Asdatetime));

  ZConnex.ExecuteDirect('insert into customer (IDcustomer,kode,nama,alamat,alamat2,kota,kota2,kodepos,telephone,telephone2,fax,email,website,cp,hp,hp2,hobby,notes,tglreg,tgllahir,tglnoneffective) '+
                        'values ('+ Quotedstr(ZQryUtil.Fields[0].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[1].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[2].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[3].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[4].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[5].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[6].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[7].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[8].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[9].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[10].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[11].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[12].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[13].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[14].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[15].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[16].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[17].AsString) +
                               ','+ vtglreg   +
                               ','+ vtgllahir +
                               ','+ vtglnonef +
                        ')');

  ZQryUtil.Next;
 end;
 ZQryUtil.Close;
///////////////////////////////////////////////////////////
end;

procedure TDataModule1.exportproduct;
var vidproduct : integer;
    vtglnonef  : string;
begin
//// export customer   ////////////////////////
 ZQryUtilex.Close;
 ZQryUtilex.SQL.Text := 'select max(IDproduct) from product ';
 ZQryUtilex.Open;
 if (ZQryUtilex.IsEmpty)or(ZQryUtilex.Fields[0].IsNull) then vidproduct := -1001
 else vidproduct := ZQryUtilex.Fields[0].AsInteger;
 ZQryUtilex.Close;

 ZQryUtil.Close;
 ZQryUtil.SQL.Text := 'select IDproduct,kode,nama,merk,seri,satuan,kategori'+
                      ',hargabeli,hargajual,keterangan,tglnoneffective,diskon,diskonrp,qty,qtybad from product where IDproduct>'+inttostr(vidproduct);
 ZQryUtil.Open;
 while not ZQryUtil.Eof do
 begin
  if ZQryUtil.Fields[10].IsNull then vtglnonef := 'null' else vtglnonef := Quotedstr(getmysqldatestr(ZQryUtil.Fields[10].Asdatetime));

  ZConnex.ExecuteDirect('insert into product (IDproduct,kode,nama,merk,seri,satuan,kategori,hargabeli,hargajual,keterangan,tglnoneffective,diskon,diskonrp,qty,qtybad) '+
                        'values ('+ Quotedstr(ZQryUtil.Fields[0].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[1].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[2].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[3].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[4].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[5].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[6].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[7].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[8].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[9].AsString) +
                               ','+ vtglnonef +
                               ','+ Quotedstr(ZQryUtil.Fields[11].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[12].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[13].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[14].AsString) +
                        ')');

  ZQryUtil.Next;
 end;
 ZQryUtil.Close;
///////////////////////////////////////////////////////////
end;

procedure TDataModule1.exportsales;
var vidsales : integer;
    vtgllahir,vtglmasuk,vtglnonef  : string;
begin
//// export customer   ////////////////////////
 ZQryUtilex.Close;
 ZQryUtilex.SQL.Text := 'select max(IDsales) from sales ';
 ZQryUtilex.Open;
 if (ZQryUtilex.IsEmpty)or(ZQryUtilex.Fields[0].IsNull) then vidsales := -1001
 else vidsales := ZQryUtilex.Fields[0].AsInteger;
 ZQryUtilex.Close;

 ZQryUtil.Close;
 ZQryUtil.SQL.Text := 'select idsales,kode,nama,alamat,kota,tgllahir,tempatlahir,tglmasuk,noktp,tglnoneffective from sales where IDsales>'+inttostr(vidsales);
 ZQryUtil.Open;
 while not ZQryUtil.Eof do
 begin
  if ZQryUtil.Fields[5].IsNull then vtgllahir := 'null' else vtgllahir := Quotedstr(getmysqldatestr(ZQryUtil.Fields[5].Asdatetime));
  if ZQryUtil.Fields[7].IsNull then vtglmasuk := 'null' else vtglmasuk := Quotedstr(getmysqldatestr(ZQryUtil.Fields[7].Asdatetime));
  if ZQryUtil.Fields[9].IsNull then vtglnonef := 'null' else vtglnonef := Quotedstr(getmysqldatestr(ZQryUtil.Fields[9].Asdatetime));

  ZConnex.ExecuteDirect('insert into sales (idsales,kode,nama,alamat,kota,tgllahir,tempatlahir,tglmasuk,noktp,tglnoneffective) '+
                        'values ('+ Quotedstr(ZQryUtil.Fields[0].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[1].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[2].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[3].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[4].AsString) +
                               ','+ vtgllahir +
                               ','+ Quotedstr(ZQryUtil.Fields[6].AsString) +
                               ','+ vtglmasuk +
                               ','+ Quotedstr(ZQryUtil.Fields[8].AsString) +
                               ','+ vtglnonef +
                        ')');

  ZQryUtil.Next;
 end;
 ZQryUtil.Close;
///////////////////////////////////////////////////////////
end;

procedure TDataModule1.exportsupplier;
var vidsupplier : integer;
    vtglnonef : string;
begin
//// export supplier   ////////////////////////
 ZQryUtilex.Close;
 ZQryUtilex.SQL.Text := 'select max(IDsupplier) from supplier ';
 ZQryUtilex.Open;
 if (ZQryUtilex.IsEmpty)or(ZQryUtilex.Fields[0].IsNull) then vidsupplier := -1001
 else vidsupplier := ZQryUtilex.Fields[0].AsInteger;
 ZQryUtilex.Close;

 ZQryUtil.Close;
 ZQryUtil.SQL.Text := 'select IDsupplier,kode,nama,alamat,alamat2,kota,kota2,kodepos'+
                      ',telephone,telephone2,fax,rekening,hp,hp2,notes,tglnoneffective from supplier where IDsupplier>'+inttostr(vidsupplier);
 ZQryUtil.Open;
 while not ZQryUtil.Eof do
 begin
  if ZQryUtil.Fields[15].IsNull then vtglnonef := 'null' else vtglnonef := Quotedstr(getmysqldatestr(ZQryUtil.Fields[15].Asdatetime));

  ZConnex.ExecuteDirect('insert into supplier (IDsupplier,kode,nama,alamat,alamat2,kota,kota2,kodepos,telephone,telephone2,fax,rekening,hp,hp2,notes,tglnoneffective) '+
                        'values ('+ Quotedstr(ZQryUtil.Fields[0].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[1].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[2].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[3].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[4].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[5].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[6].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[7].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[8].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[9].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[10].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[11].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[12].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[13].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[14].AsString) +
                               ','+ vtglnonef +
                        ')');

  ZQryUtil.Next;
 end;
 ZQryUtil.Close;
///////////////////////////////////////////////////////////
end;

procedure TDataModule1.exportbuy;
var vidsales  : integer;
    vtgl,vwkt,vtanggal,vjthtempo : string;
begin
//// export customer   ////////////////////////
 ZQryUtilex.Close;
 ZQryUtilex.SQL.Text := 'select tanggal,waktu from buymaster order by idBeli desc';
 ZQryUtilex.Open;
 if (ZQryUtilex.IsEmpty)or(ZQryUtilex.Fields[0].IsNull) then vtgl := Quotedstr('1899-12-31')
 else vtgl := Quotedstr(getmysqldatestr(ZQryUtilex.Fields[0].Asdatetime));
 if (ZQryUtilex.IsEmpty)or(ZQryUtilex.Fields[1].IsNull) then vwkt := Quotedstr('00:00:00')
 else vwkt := Quotedstr(ZQryUtilex.Fields[1].AsString);
 ZQryUtilex.Close;

 ZQryUtil.Close;
 ZQryUtil.SQL.Text := 'select faktur,noinvoice,tanggal,waktu,kasir,kodesupplier,supplier,alamat,kota'+
                      ',pembayaran,nogiro,tgljatuhtempo,tempohari,subtotal,ppn,total,diskon,diskonrp'+
                      ',grandtotal,DP,kurang,isposted,lunas,totalpayment from buymaster where (left(faktur,1)="A") and ((tanggal>'+vtgl+')or((tanggal='+vtgl+')and(waktu>'+vwkt+')))';
 ZQryUtil.Open;
 while not ZQryUtil.Eof do
 begin
  if ZQryUtil.Fields[2].IsNull then vtanggal := 'null' else vtanggal := Quotedstr(getmysqldatestr(ZQryUtil.Fields[2].Asdatetime));
  if ZQryUtil.Fields[11].IsNull then vjthtempo := 'null' else vjthtempo := Quotedstr(getmysqldatestr(ZQryUtil.Fields[11].Asdatetime));

  ZConnex.ExecuteDirect('insert into buymaster (faktur,noinvoice,tanggal'+
                        ',waktu,kasir,kodesupplier,supplier,alamat,kota,pembayaran,nogiro'+
                        ',tgljatuhtempo,tempohari,subtotal,ppn,total,diskon,diskonrp,grandtotal,DP,kurang,isposted,lunas,totalpayment) '+
                        'values ('+ Quotedstr(ZQryUtil.Fields[0].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[1].AsString) +
                               ','+ vtanggal +
                               ','+ Quotedstr(ZQryUtil.Fields[3].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[4].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[5].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[6].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[7].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[8].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[9].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[10].AsString) +
                               ','+ vjthtempo +
                               ','+ Quotedstr(ZQryUtil.Fields[12].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[13].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[14].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[15].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[16].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[17].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[18].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[19].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[20].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[21].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[22].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[23].AsString) +
                        ')');

  ZQryUtil.Next;
 end;
 ZQryUtil.Close;

////// Buy detail ////////////////////
 ZQryUtil.SQL.Text := 'select d.faktur,d.kode,d.nama,d.kategori,d.merk,d.seri,d.satuan,d.hargabeli,d.diskon'+
                      ',d.quantity,d.harganondiskon,d.isposted,d.subtotal from buydetail d left join buymaster b on d.faktur=b.faktur '+
                      'where (left(b.faktur,1)="A") and ((b.tanggal>'+vtgl+')or((b.tanggal='+vtgl+')and(b.waktu>'+vwkt+')))';
 ZQryUtil.Open;
 while not ZQryUtil.Eof do
 begin
  ZConnex.ExecuteDirect('insert into buymaster (faktur,kode,nama,kategori,merk,seri,satuan,hargabeli,diskon'+
                        ',quantity,harganondiskon,isposted,subtotal) '+
                        'values ('+ Quotedstr(ZQryUtil.Fields[0].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[1].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[2].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[3].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[4].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[5].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[6].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[7].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[8].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[9].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[10].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[11].AsString) +
                               ','+ Quotedstr(ZQryUtil.Fields[12].AsString) +
                        ')');

  ZQryUtil.Next;
 end;
 ZQryUtil.Close;

end;

procedure TDataModule1.exportexternal;
var idbuforg, idbufex : integer;
    vtglbuf : TDate;
    bufb : boolean;
begin
  {customer}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(IDcustomer) from customer';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(IDcustomer) from customer';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\customer.txt');

   ZConnection1.ExecuteDirect('select * from customer where IDcustomer>'+ inttostr(idbufex)+' into outfile "E:/mplus/bufext/customer.txt" ');
   while fileexists('E:\mplus\bufext\customer.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/customer.txt" INTO TABLE customer;');
  end;

  {product}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(IDproduct) from product';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(IDproduct) from product';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\product.txt');

   ZConnection1.ExecuteDirect('select * from product where IDproduct>'+ inttostr(idbufex)+' into outfile "E:/mplus/bufext/product.txt" ');
   while fileexists('E:\mplus\bufext\product.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/product.txt" INTO TABLE product;');
  end;

  {sales}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(idsales) from sales';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(idsales) from sales';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\sales.txt');

   ZConnection1.ExecuteDirect('select * from sales where IDsales>'+ inttostr(idbufex)+' into outfile "E:/mplus/bufext/sales.txt" ');
   while fileexists('E:\mplus\bufext\sales.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/sales.txt" INTO TABLE sales;');
  end;

  {supplier}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(IDsupplier) from supplier';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(IDsupplier) from supplier';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\supplier.txt');

   ZConnection1.ExecuteDirect('select * from supplier where IDsupplier>'+ inttostr(idbufex)+' into outfile "E:/mplus/bufext/supplier.txt" ');
   while fileexists('E:\mplus\bufext\supplier.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/supplier.txt" INTO TABLE supplier;');
  end;

  {buy}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(idBeli) from buymaster';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(idBeli) from buymaster';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\buymaster.txt');
   deletefile('E:\mplus\bufext\buydetail.txt');

   ZConnection1.ExecuteDirect('select * from buymaster where (left(faktur,1)="A") and (IDbeli>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/buymaster.txt" ');
   while fileexists('E:\mplus\bufext\buymaster.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/buymaster.txt" INTO TABLE buymaster;');

   ZConnection1.ExecuteDirect('select * from buydetail where (left(faktur,1)="A") and (IDbeli>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/buydetail.txt" ');
   while fileexists('E:\mplus\bufext\buydetail.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/buydetail.txt" INTO TABLE buydetail;');
  end;

  {sale}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(idsell) from sellmaster';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(idsell) from sellmaster';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\sellmaster.txt');
   deletefile('E:\mplus\bufext\selldetail.txt');

   ZConnection1.ExecuteDirect('select * from sellmaster where (left(faktur,1)="A") and (idsell>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/sellmaster.txt" ');
   while fileexists('E:\mplus\bufext\sellmaster.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/sellmaster.txt" INTO TABLE sellmaster;');

   ZConnection1.ExecuteDirect('select * from selldetail where (left(faktur,1)="A") and (idsell>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/selldetail.txt" ');
   while fileexists('E:\mplus\bufext\selldetail.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/selldetail.txt" INTO TABLE selldetail;');
  end;

  {returjual}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(idreturjual) from returjualmaster';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(idreturjual) from returjualmaster';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\returjualmaster.txt');
   deletefile('E:\mplus\bufext\returjualdetail.txt');

   ZConnection1.ExecuteDirect('select * from returjualmaster where (left(fakturjual,1)="A") and (idreturjual>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/returjualmaster.txt" ');
   while fileexists('E:\mplus\bufext\returjualmaster.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/returjualmaster.txt" INTO TABLE returjualmaster;');

   ZConnection1.ExecuteDirect('select * from returjualdetail where (left(fakturjual,1)="A") and (idreturjual>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/returjualdetail.txt" ');
   while fileexists('E:\mplus\bufext\returjualdetail.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/returjualdetail.txt" INTO TABLE returjualdetail;');
  end;

  {returbeli}
  ZQryUtil.Close;
  ZQryUtil.SQL.Clear;
  ZQryUtil.SQL.Text := 'select max(idreturbeli) from returbelimaster';
  ZQryUtil.Open;
  idbuforg := ZQryUtil.Fields[0].AsInteger;
  ZQryUtil.Close;

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(idreturbeli) from returbelimaster';
  ZQryUtilex.Open;
  idbufex := ZQryUtilex.Fields[0].AsInteger;
  ZQryUtilex.Close;

  if idbuforg>idbufex then
  begin
   deletefile('E:\mplus\bufext\returbelimaster.txt');
   deletefile('E:\mplus\bufext\returbelidetail.txt');

   ZConnection1.ExecuteDirect('select * from returbelimaster where (left(fakturbeli,1)="A") and (idreturbeli>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/returbelimaster.txt" ');
   while fileexists('E:\mplus\bufext\returbelimaster.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/returbelimaster.txt" INTO TABLE returbelimaster;');

   ZConnection1.ExecuteDirect('select * from returbelidetail where (left(fakturbeli,1)="A") and (idreturbeli>'+ inttostr(idbufex)+') into outfile "E:/mplus/bufext/returbelidetail.txt" ');
   while fileexists('E:\mplus\bufext\returbelidetail.txt')=false do bufb:= false;
   ZConnex.ExecuteDirect('LOAD DATA INFILE "E:/mplus/bufext/returbelidetail.txt" INTO TABLE returbelidetail;');
  end;

  { stock }

  ZQryUtilex.Close;
  ZQryUtilex.SQL.Clear;
  ZQryUtilex.SQL.Text := 'select max(tgltrans) from inventory';
  ZQryUtilex.Open;
  vtglbuf := ZQryUtilex.Fields[0].AsDatetime;
  ZQryUtilex.Close;

  deletefile('E:\mplus\bufext\inventory.txt');

  ZConnection1.ExecuteDirect('select * from inventory where (tgltrans>='+ Quotedstr(formatdatetime('yyyy-mm-dd',vtglbuf))+') and (typetrans<>"ADJUSTMENT") into outfile "J:/bufext/inventory.txt" ');
  while fileexists('E:\mplus\bufext\inventory.txt')=false do bufb:= false;
  ZConnex.ExecuteDirect('delete from inventory where tgltrans>='+ Quotedstr(formatdatetime('yyyy-mm-dd',vtglbuf)));
  ZConnex.ExecuteDirect('LOAD DATA INFILE "J:/bufext/inventory.txt" INTO TABLE inventory;');


end;

procedure TDataModule1.CanGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := Copy(ZQryOperasionalketerangan.Value,1,50);
end;

procedure TDataModule1.ZQryFormOperasionalketeranganGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  Text := Copy(ZQryFormOperasionalketerangan.Value,1,50);
end;

procedure TDataModule1.connectdb;
begin
 ZConnection1.Connected:=false;
 ZConnex.Connected:=false;
 ZConserverrw.Connected:=false;
// ZConn2.Connected:=false;

 isdblocal := false;
 konekserver := true;
// hostname   := 'localhost';
// dbname     := 'sparepart';
 usernamedb := 'metabrain';
 passworddb := 'meta289976';

{ ZConnex.HostName := hostname;
 ZConnex.User     := usernamedb;
 ZConnex.Password := passworddb;

 if hostname<>'localhost' then
 begin
  isdblocal := true;
  ZConserverrw.HostName := 'localhost';
  ZConserverrw.User     := usernamedb;
  ZConserverrw.Password := passworddb;
  try
   ZConserverrw.Connected:=True;
  except
   isdblocal := false;
  end;
  ZConserverrw.Connected:=false;
 end;

 if isdblocal then
 begin
  ZConserverrw.HostName := hostname;
  ZConserverrw.User     := usernamedb;
  ZConserverrw.Password := passworddb;
  try
   ZConserverrw.Connected:=True;
  except
   konekserver := false;
  end;

  ZConnection1.HostName := 'localhost';
 end
 else ZConnection1.HostName := hostname;
 }

 if (trim(dbname)='') then
 begin
  ZConnection1.HostName := hostname;
  ZConnection1.User     := usernamedb;
  ZConnection1.Password := passworddb;
  ZConnection1.Protocol := 'mysql-5';

//  if hostname='localhost' then ZConn2.HostName := hostname
//  else ZConn2.HostName := copy(hostname,1,length(hostname)-2);
 end
 else
 begin
  ZConnection1.HostName := '';
  ZConnection1.User     := '';
  ZConnection1.Password := '';
  ZConnection1.Protocol := 'sqlite-3';
 end;
// ZConnection1.Catalog  := dbname;
// ZConnection1.Database := dbname;

 try
  ZConnection1.Connected:=True;
 except
   MessageDlg('Tidak dapat terkoneksi dengan Server Database....', mtInformation, [mbOK], 0);
   Application.Terminate;
 end;

{ try
  ZConn2.Connected:=True;
 except
   MessageDlg('Tidak dapat terkoneksi dengan Server Database....', mtInformation, [mbOK], 0);
   Application.Terminate;
 end;  }

 /////////////////// setting con server /////////////////////////////////////////
 ZConserver.Connected := False;
 if (trim(dbname)<>'') then
 begin
  ZConserver.HostName := hostname;
  ZConserver.User     := usernamedb;
  ZConserver.Password := passworddb;
  ZConserver.Catalog  := 'sparepart';
  ZConserver.Database := 'sparepart';
 end;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var Listmbs: TStringList;
    vdbname : string;
begin
  ConfigPath := ExtractFilePath(Application.ExeName) + 'config.mbs';
  Listmbs := TStringList.Create;
  Listmbs.LoadFromFile(ConfigPath);

  hostname := Trim(Copy(Listmbs.Strings[5],AnsiPos('=',Listmbs.Strings[5])+1,250));
  if hostname<>'localhost' then hostname := hostname + '52';

  standpos := Trim(Copy(Listmbs.Strings[18],AnsiPos('=',Listmbs.Strings[18])+1,250));
  Kodegudang := Trim(Copy(Listmbs.Strings[21],AnsiPos('=',Listmbs.Strings[21])+1,250));

  portstruk := Trim(Copy(Listmbs.Strings[14],AnsiPos('=',Listmbs.Strings[14])+1,250));

  pgpathloc := Trim(Copy(Listmbs.Strings[24],AnsiPos('=',Listmbs.Strings[24])+1,250));

  printerbarcode := Trim(Copy(Listmbs.Strings[25],AnsiPos('=',Listmbs.Strings[25])+1,250));

  Listmbs.Destroy;


  vdbname := vpath + 'masdb.db';
  dbname  := '';
  if fileexists(vdbname) then
  begin
   decimalseparator := '.';
   Thousandseparator := ',';

   dbname := vdbname;
  end;

  dbname  := '';


  connectdb;

  namagudang := trim(getdata('namagudang','gudang where kodegudang='+Quotedstr(kodegudang)));
  lokasigudang := trim(getdata('lokasi','gudang where kodegudang='+Quotedstr(kodegudang)));

  ZQryutil.Close;
  ZQryutil.SQL.Text := 'select pathsource,ipremotemysql,dbremotemysql,unremotemysql,pwremotemysql from conf';
  ZQryutil.Open;

  vpathsource := ZQryutil.Fields[0].AsString;

  ZConnremotemysql.HostName := ZQryutil.Fields[1].AsString;
  ZConnremotemysql.Catalog  := ZQryutil.Fields[2].AsString;
  ZConnremotemysql.Database := ZQryutil.Fields[2].AsString;
  ZConnremotemysql.User     := ZQryutil.Fields[3].AsString;
  ZConnremotemysql.Password := ZQryutil.Fields[4].AsString;

  ZQryutil.Close;
  ZQryutil.SQL.Text := 'select rewardmember,rewardcair from struk where isaktif=1';
  ZQryutil.Open;

  rewardmember := ZQryutil.Fields[0].AsFloat;
  rewardcair   := ZQryutil.Fields[1].Asinteger;

  ZQryutil.Close;

end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
// UnInstallMetaService;
end;

procedure TDataModule1.ZQrydiskondetformCalcFields(DataSet: TDataSet);
begin
 ZQrydiskondetformhargajualakhir.Value := ZQrydiskondetformhargajual.Value - ZQrydiskondetformdiskonrp.Value;
end;

procedure TDataModule1.ZQrypodetformCalcFields(DataSet: TDataSet);
begin
 ZQrypodetformtotalprice.Value := ZQrypodetformqty.Value * ZQrypodetformhargabeli.Value;
end;

end.
