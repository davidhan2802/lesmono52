/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

USE `sparepart`;

CREATE TABLE `product` (
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDgolongan` INTEGER(11) NOT NULL,
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `keterangan` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tglnoneffective` DATE DEFAULT NULL,
  `diskon` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `barcode` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  `SL` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `SLT` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `CT` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `CTT` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `CB` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `CBT` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `SLR` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `CTR` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `CBR` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `reorderqty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `expdate` DATE DEFAULT NULL,
  `feebiro` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `feedrivertl` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `margin` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `barcode128` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  `feerent` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`kode`),
  UNIQUE KEY `IDproduct` (`IDproduct`),
  UNIQUE KEY `kode` (`kode`, `nama`, `merk`, `seri`, `satuan`, `IDgolongan`, `hargabeli`, `hargajual`, `keterangan`, `barcode`)
)ENGINE=InnoDB
AUTO_INCREMENT=686 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB; (`kodepromo`) REFER `sparepart/promo`(`kode`) ON UPDATE ';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `product_before_ins_tr` BEFORE INSERT ON `product`
  FOR EACH ROW
BEGIN
 set new.barcode128 = `TextTo128C`(new.barcode);
END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `product_after_ins_tr` AFTER INSERT ON `product`
  FOR EACH ROW
BEGIN
 insert into productgudang (IDproduct,IDgudang) select new.IDproduct,IDgudang from gudang order by IDgudang;
END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `product_before_upd_tr` BEFORE UPDATE ON `product`
  FOR EACH ROW
BEGIN
 if (old.barcode<>new.barcode) then set new.barcode128 = `TextTo128C`(new.barcode);
 end if;
END;

CREATE TABLE `adjustdetail` (
  `idAdjust` INTEGER(11) NOT NULL DEFAULT '0',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `keterangan` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `qtybefore` DOUBLE(15,3) DEFAULT '0.000',
  `qtyafter` DOUBLE(15,3) DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  KEY `kode` (`kode`),
  CONSTRAINT `adjustdetail_fk` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `adjustmaster` (
  `idAdjust` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `operator` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `totaladjust` DOUBLE(15,3) DEFAULT '0.000',
  `isposted` INTEGER(11) DEFAULT '0' COMMENT '-1 = batal posting\r\n0 = belum posting\r\n1 = sudah posting',
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci NOT NULL DEFAULT 'TK',
  PRIMARY KEY (`idAdjust`),
  UNIQUE KEY `faktur` (`faktur`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `adjustmaster_before_ins_tr` BEFORE INSERT ON `adjustmaster`
  FOR EACH ROW
BEGIN
 declare strtot VARCHAR(100);
 set strtot = cast(new.totaladjust as char(100));
 set strtot = REPLACE(strtot,',','.');
 set new.totaladjust = cast(strtot as DECIMAL(15));
END;

CREATE TABLE `buydetail` (
  `idBeli` INTEGER(11) NOT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `harganondiskon` DOUBLE(15,3) DEFAULT '0.000',
  `isposted` TINYINT(1) NOT NULL DEFAULT '1',
  `subtotal` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `barcode` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  KEY `faktur` (`faktur`),
  KEY `kode` (`kode`),
  CONSTRAINT `buydetail_fk` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `purchaseorder` (
  `IDpurchaseorder` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `IDsupplier` INTEGER(11) NOT NULL,
  `pono` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl` DATE NOT NULL,
  `totalprice` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDuserposted` INTEGER(11) DEFAULT NULL,
  `usernameposted` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `posted` DATETIME DEFAULT NULL,
  PRIMARY KEY (`IDpurchaseorder`),
  UNIQUE KEY `pono` (`pono`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `buymaster` (
  `idBeli` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `noinvoice` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `kasir` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodesupplier` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `supplier` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat` VARCHAR(250) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `pembayaran` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nogiro` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tgljatuhtempo` DATE DEFAULT NULL,
  `tempohari` TINYINT(4) DEFAULT '0',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `ppn` DOUBLE(15,3) DEFAULT '0.000',
  `total` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` DOUBLE(15,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `grandtotal` DOUBLE(15,3) DEFAULT '0.000',
  `DP` DOUBLE(15,3) DEFAULT '0.000',
  `kurang` DOUBLE(15,3) DEFAULT '0.000',
  `isposted` TINYINT(1) DEFAULT '0',
  `lunas` TINYINT(1) DEFAULT '0',
  `totalpayment` DOUBLE(15,3) DEFAULT '0.000',
  `bayarskrg` DOUBLE(15,3) DEFAULT '0.000',
  `checked` TINYINT(1) DEFAULT '0',
  `kodegudang` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `pono` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDuserposted` INTEGER(11) NOT NULL,
  `faktur2` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`idBeli`),
  UNIQUE KEY `faktur_2` (`faktur`),
  KEY `faktur` (`faktur`),
  KEY `pono` (`pono`),
  CONSTRAINT `buymaster_fk` FOREIGN KEY (`pono`) REFERENCES `purchaseorder` (`pono`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 11264 kB; InnoDB free: 731136 kB';

CREATE TABLE `buypayment` (
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kodesupplier` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `supplier` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tanggal` DATE NOT NULL,
  `waktu` TIME NOT NULL,
  `kasir` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `transfer` DOUBLE(15,3) DEFAULT '0.000',
  `tunai` DOUBLE(15,3) DEFAULT '0.000',
  `bg` DOUBLE(15,3) DEFAULT '0.000',
  `totalhutangfaktur` DOUBLE(15,3) DEFAULT '0.000',
  `totalretur` DOUBLE(15,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `tanggalinput` DATE NOT NULL,
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `isposted` TINYINT(1) DEFAULT '0',
  `saldo_hutang` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`faktur`)
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `buypaymentbg` (
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl` DATE DEFAULT NULL,
  `transfer` DOUBLE(15,3) DEFAULT '0.000',
  `bg` DOUBLE(15,3) DEFAULT '0.000',
  `bgno` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `bgbank` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `bgtempo` DATE DEFAULT NULL,
  `tobank` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `conf` (
  `pathsource` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ipremotemysql` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `dbremotemysql` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `unremotemysql` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `pwremotemysql` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `customer` (
  `IDcustomer` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat` VARCHAR(250) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat2` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota2` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodepos` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `telephone` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `telephone2` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `fax` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `email` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `website` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cp` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hp` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hp2` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hobby` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tglreg` DATE DEFAULT NULL,
  `tgllahir` DATE DEFAULT NULL,
  `tglnoneffective` DATE DEFAULT NULL,
  `npwp` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`kode`),
  UNIQUE KEY `IDcustomer` (`IDcustomer`)
)ENGINE=InnoDB
AUTO_INCREMENT=2 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `diskon` (
  `IDdiskon` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `docno` VARCHAR(30) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `doctgl` DATE DEFAULT NULL,
  `tglawal` DATE NOT NULL,
  `tglakhir` DATE NOT NULL,
  `isactive` TINYINT(1) NOT NULL DEFAULT '1',
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDuserposted` INTEGER(11) DEFAULT NULL,
  `usernameposted` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `posted` DATETIME DEFAULT NULL,
  PRIMARY KEY (`IDdiskon`),
  UNIQUE KEY `faktur` (`docno`),
  UNIQUE KEY `docno` (`docno`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `diskondet` (
  `IDdiskon` INTEGER(11) NOT NULL,
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `minqty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `maxqty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  KEY `kode` (`kode`),
  CONSTRAINT `diskondet_fk` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `diskondetform` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `minqty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `maxqty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000'
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `formadjust` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `quantityadjust` DOUBLE(15,3) DEFAULT '0.000',
  `keterangan` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harga` DOUBLE(15,3) DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nourut` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `formbg` (
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tgl` DATE DEFAULT NULL,
  `transfer` DOUBLE(15,3) DEFAULT '0.000',
  `bg` DOUBLE(15,3) DEFAULT '0.000',
  `bgno` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `bgbank` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `bgtempo` DATE DEFAULT NULL,
  `tobank` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nourut` TINYINT(4) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `formbuy` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harga` DOUBLE(15,3) DEFAULT '0.000',
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harganondiskon` DOUBLE(15,3) DEFAULT '0.000',
  `nourut` INTEGER(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `barcode` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  `barcode128` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `formkeuangan` (
  `idoperasional` BIGINT(20) DEFAULT NULL,
  `idTrans` INTEGER(11) DEFAULT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `kasir` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `keterangan` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `debet` DOUBLE(15,3) DEFAULT '0.000',
  `kredit` DOUBLE(15,3) DEFAULT '0.000',
  `fakturpay` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `saldoawaltagihan` DOUBLE(15,3) DEFAULT '0.000',
  `signcolor` TINYINT(1) NOT NULL DEFAULT '0',
  `nourut` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `formkeuangan_before_ins_tr` BEFORE INSERT ON `formkeuangan`
  FOR EACH ROW
BEGIN
 declare vtgl date;
 declare vsign TINYINT(1);
 set vtgl=null;
 set vsign=0;
 select tanggal,signcolor into vtgl,vsign from `formkeuangan` order by tanggal desc limit 1;
 if (vtgl is not null) then
 begin
  if vtgl=new.tanggal then set new.signcolor=vsign; else set new.signcolor= not vsign; end if;
 end;
 end if;
END;

CREATE TABLE `formretur` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `quantityretur` DOUBLE(15,3) DEFAULT '0.000',
  `keterangan` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harga` DOUBLE(15,3) DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskon_rp` DOUBLE(15,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `fakturjual` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `nourut` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `formsell` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harga` DOUBLE(15,3) DEFAULT '0.000',
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `totalharga` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `diskon_rp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `idstts` TINYINT(4) DEFAULT '0' COMMENT '0 = Value\r\n1 = Free\r\n2 = Tukar',
  `nourut` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `feebiro` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `feedrivertl` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `feerent` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `formsell01` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harga` DOUBLE(15,3) DEFAULT '0.000',
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `totalharga` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `diskon_rp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `idstts` TINYINT(4) DEFAULT '0' COMMENT '0 = Value\r\n1 = Free\r\n2 = Tukar',
  `nourut` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `feebiro` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `feedrivertl` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `feerent` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `formsell2` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harga` DOUBLE(15,3) DEFAULT '0.000',
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `totalharga` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `diskon_rp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `idstts` TINYINT(4) DEFAULT '0' COMMENT '0 = Value\r\n1 = Free\r\n2 = Tukar',
  `nourut` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `feebiro` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `feedrivertl` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `feerent` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `formsell201` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `harga` DOUBLE(15,3) DEFAULT '0.000',
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `totalharga` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `diskon_rp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `idstts` TINYINT(4) DEFAULT '0' COMMENT '0 = Value\r\n1 = Free\r\n2 = Tukar',
  `nourut` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `feebiro` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `feedrivertl` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `feerent` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`nourut`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `golongan` (
  `IDgolongan` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(150) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `departemen` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`IDgolongan`),
  UNIQUE KEY `kode` (`kode`),
  UNIQUE KEY `nama` (`nama`)
)ENGINE=InnoDB
AUTO_INCREMENT=39 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `gudang` (
  `IDgudang` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `namagudang` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat1` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat2` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `telp` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `fax` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `wilayah` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `type` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `isbadstock` TINYINT(1) NOT NULL DEFAULT '0',
  `lokasi` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`IDgudang`),
  UNIQUE KEY `kodegudang` (`kodegudang`)
)ENGINE=InnoDB
AUTO_INCREMENT=8 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `gudang_after_ins_tr` AFTER INSERT ON `gudang`
  FOR EACH ROW
BEGIN
 insert into productgudang (IDproduct,IDgudang) select IDproduct,new.IDgudang from product order by IDproduct;
END;

CREATE TABLE `inventory` (
  `IDinventory` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tgltrans` DATE NOT NULL,
  `kodebrg` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci NOT NULL DEFAULT 'TK',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `typetrans` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `idtrans` INTEGER(11) NOT NULL DEFAULT '0',
  `IDuser` INTEGER(11) DEFAULT NULL,
  `username` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `waktu` TIME NOT NULL,
  `keterangan` VARCHAR(500) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  UNIQUE KEY `IDinventory` (`IDinventory`),
  KEY `kodebrg` (`kodebrg`),
  CONSTRAINT `inventory_fk` FOREIGN KEY (`kodebrg`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=691 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `inventory_before_ins_tr` BEFORE INSERT ON `inventory`
  FOR EACH ROW
BEGIN
 if upper(new.kodegudang)='SL' THEN
  update product set SL = SL + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CT' THEN
  update product set CT = CT + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CB' THEN
  update product set CB = CB + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='SLR' THEN
  update product set SLR = SLR + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CTR' THEN
  update product set CTR = CTR + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CBR' THEN
  update product set CBR = CBR + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='SLT' THEN
  update product set SLT = SLT + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CTT' THEN
  update product set CTT = CTT + new.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CBT' THEN
  update product set CBT = CBT + new.qty where kode = new.kodebrg; 
 end if; 
 
 update productgudang p,gudang g,product r set p.`qty`=p.`qty`+new.qty 
 where r.kode=new.kodebrg and g.kodegudang=new.kodegudang and p.IDproduct=r.IDproduct and p.`IDgudang`=g.IDgudang;
 
END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `inventory_before_upd_tr` BEFORE UPDATE ON `inventory`
  FOR EACH ROW
BEGIN
 if upper(new.kodegudang)='SL' THEN
  update product set SL = SL + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CT' THEN
  update product set CT = CT + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CB' THEN
  update product set CB = CB + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='SLR' THEN
  update product set SLR = SLR + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CTR' THEN
  update product set CTR = CTR + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CBR' THEN
  update product set CBR = CBR + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='SLT' THEN
  update product set SLT = SLT + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CTT' THEN
  update product set CTT = CTT + new.qty - old.qty where kode = new.kodebrg; 
 elseif upper(new.kodegudang)='CBT' THEN
  update product set CBT = CBT + new.qty - old.qty where kode = new.kodebrg; 
 end if; 


 update productgudang p,gudang g,product r set p.`qty`=p.`qty`+new.qty-old.qty 
 where r.kode=new.kodebrg and g.kodegudang=new.kodegudang and p.IDproduct=r.IDproduct and p.`IDgudang`=g.IDgudang;

END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `inventory_before_del_tr` BEFORE DELETE ON `inventory`
  FOR EACH ROW
BEGIN
 if upper(old.kodegudang)='SL' THEN
  update product set SL = SL - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='CT' THEN
  update product set CT = CT - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='CB' THEN
  update product set CB = CB - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='SLR' THEN
  update product set SLR = SLR - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='CTR' THEN
  update product set CTR = CTR - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='CBR' THEN
  update product set CBR = CBR - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='SLT' THEN
  update product set SLT = SLT - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='CTT' THEN
  update product set CTT = CTT - old.qty where kode = old.kodebrg; 
 elseif upper(old.kodegudang)='CBT' THEN
  update product set CBT = CBT - old.qty where kode = old.kodebrg; 
 end if; 

 update productgudang p,gudang g,product r set p.`qty`=p.`qty`-old.qty 
 where r.kode=old.kodebrg and g.kodegudang=old.kodegudang and p.IDproduct=r.IDproduct and p.`IDgudang`=g.IDgudang;

END;

CREATE TABLE `inventoryimp` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDproduct` INTEGER(11) DEFAULT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `qty` DOUBLE(15,3) DEFAULT '0.000',
  `hargabelip` DOUBLE(15,3) DEFAULT '0.000',
  `hargajualp` DOUBLE(15,3) DEFAULT '0.000',
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDgolongan` INTEGER(11) DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) DEFAULT '0.000',
  `keterangan` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tglnoneffective` DATE DEFAULT NULL,
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `barcode` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  `reorderqty` DOUBLE(15,3) DEFAULT '0.000',
  `expdate` DATE DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `inventoryimp_before_ins_tr` BEFORE INSERT ON `inventoryimp`
  FOR EACH ROW
BEGIN
 insert ignore into product (kode,nama,merk,seri,satuan,IDgolongan,hargabeli,hargajual,keterangan,tglnoneffective,diskon,diskonrp,barcode,reorderqty,expdate) 
 values (new.kode,new.nama,new.merk,new.seri,new.satuan,new.IDgolongan,new.hargabeli,new.hargajual,new.keterangan,new.tglnoneffective,new.diskon,new.diskonrp,new.barcode,new.reorderqty,new.expdate);
END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `inventoryimp_after_ins_tr` AFTER INSERT ON `inventoryimp`
  FOR EACH ROW
BEGIN
 insert into terimagudangdetform (ipv,IDproduct,kode,nama,satuan,qty,hargabeli,hargajual) 
 values (new.ipv,(select IDproduct from product where kode=new.kode),new.kode,new.nama,new.satuan,new.qty,new.hargabelip,new.hargajualp);
END;

CREATE TABLE `inventorytemp` (
  `IDinventory` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tgltrans` DATE NOT NULL,
  `kodebrg` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci NOT NULL DEFAULT 'TK',
  `qty` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `typetrans` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `idtrans` INTEGER(11) NOT NULL DEFAULT '0',
  `IDuser` INTEGER(11) DEFAULT NULL,
  `username` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `waktu` TIME NOT NULL,
  `keterangan` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`IDinventory`, `tgltrans`, `kodebrg`, `kodegudang`, `typetrans`, `faktur`, `idtrans`, `username`, `waktu`),
  UNIQUE KEY `IDinventory` (`IDinventory`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `jasa` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `komisi` DOUBLE(15,3) DEFAULT '0.000',
  `tglnoneffective` DATE DEFAULT '2100-01-01',
  PRIMARY KEY (`kode`)
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `labelharga` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDproduct` INTEGER(11) DEFAULT NULL,
  `IDproduct2` INTEGER(11) DEFAULT NULL,
  `IDproduct3` INTEGER(11) DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `loginfo` (
  `no` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `username` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `computername` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `keterangan` VARCHAR(250) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`no`)
)ENGINE=InnoDB
AUTO_INCREMENT=604 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `member` (
  `cardno` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `ktpno` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hpno` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `golongan` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tglreg` DATE DEFAULT NULL,
  `keterangan` TEXT COLLATE latin1_swedish_ci,
  `tglnoneffective` DATE DEFAULT NULL,
  `IDuser` INTEGER(11) DEFAULT NULL,
  `username` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `lokasi` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  UNIQUE KEY `cardno` (`cardno`),
  UNIQUE KEY `nama` (`nama`),
  UNIQUE KEY `ktpno` (`ktpno`)
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `memberreward` (
  `faktur` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl` DATETIME NOT NULL,
  `cardno` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `totalreward` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `IDuser` INTEGER(11) NOT NULL,
  `username` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `lokasi` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  UNIQUE KEY `faktur` (`faktur`),
  KEY `cardno` (`cardno`),
  CONSTRAINT `memberreward_fk` FOREIGN KEY (`cardno`) REFERENCES `member` (`cardno`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `memberabsensi` (
  `tgl` DATETIME NOT NULL,
  `cardno` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDselltourgroup` INTEGER(11) UNSIGNED NOT NULL,
  `nogroup` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `namatour` VARCHAR(150) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `jenisbus` TINYINT(4) NOT NULL DEFAULT '0',
  `presentfee` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `faktur` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `rewardmember` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `isprint` TINYINT(1) NOT NULL DEFAULT '0',
  `IDuser` INTEGER(11) NOT NULL,
  `username` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `lokasi` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  KEY `idmember` (`cardno`),
  KEY `IDselltourgroup` (`IDselltourgroup`),
  KEY `idmemberreward` (`faktur`),
  CONSTRAINT `memberabsensi_fk` FOREIGN KEY (`cardno`) REFERENCES `member` (`cardno`) ON UPDATE CASCADE,
  CONSTRAINT `memberabsensi_fk1` FOREIGN KEY (`faktur`) REFERENCES `memberreward` (`faktur`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `menu` (
  `IDmenu` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(200) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`IDmenu`)
)ENGINE=InnoDB
AUTO_INCREMENT=44 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `operasional` (
  `idoperasional` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `idTrans` INTEGER(11) DEFAULT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `kasir` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `keterangan` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `debet` DOUBLE(15,3) DEFAULT '0.000',
  `kredit` DOUBLE(15,3) DEFAULT '0.000',
  `fakturpay` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `saldoawaltagihan` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`idoperasional`)
)ENGINE=InnoDB
AUTO_INCREMENT=3 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `pindahgudang` (
  `IDpindahgudang` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `docno` VARCHAR(30) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `doctgl` DATE NOT NULL,
  `IDgudang` INTEGER(11) NOT NULL,
  `IDgudangto` INTEGER(11) NOT NULL,
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDuserposted` INTEGER(11) DEFAULT NULL,
  `usernameposted` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT '',
  `posted` DATETIME DEFAULT NULL,
  PRIMARY KEY (`IDpindahgudang`),
  UNIQUE KEY `docno` (`docno`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `pindahgudang_before_upd_tr` BEFORE UPDATE ON `pindahgudang`
  FOR EACH ROW
BEGIN
 declare vkodegudang VARCHAR(10);
 declare vkodegudangto VARCHAR(10);

 select kodegudang into vkodegudang from gudang where IDgudang=new.IDgudang;
 select kodegudang into vkodegudangto from gudang where IDgudang=new.IDgudangto;

 if (old.posted is null) and (new.posted is not null) THEN
 begin
  insert into inventory (tgltrans,kodebrg,kodegudang,qty,satuan,hargabeli,hargajual,typetrans,faktur,IDtrans,IDuser,username,waktu,keterangan) 
  select new.doctgl,b.kode,vkodegudang,-1*b.qty,b.satuan,b.hargabeli,b.hargajual,'pindah gudang',new.docno,new.IDpindahgudang,new.IDuserposted,new.usernameposted,time(now()),new.notes from pindahgudangdet b where b.IDpindahgudang=new.IDpindahgudang;

  insert into inventory (tgltrans,kodebrg,kodegudang,qty,satuan,hargabeli,hargajual,typetrans,faktur,IDtrans,IDuser,username,waktu,keterangan) 
  select new.doctgl,b.kode,vkodegudangto,b.qty,b.satuan,b.hargabeli,b.hargajual,'pindah gudang',new.docno,new.IDpindahgudang,new.IDuserposted,new.usernameposted,time(now()),new.notes from pindahgudangdet b where b.IDpindahgudang=new.IDpindahgudang;
 
 end;
 elseif (old.posted is not null) and (new.posted is null) THEN
 begin
  delete from inventory where IDtrans=old.IDpindahgudang and typetrans='pindah gudang';
 end;
 end if;

END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `pindahgudang_before_del_tr` BEFORE DELETE ON `pindahgudang`
  FOR EACH ROW
BEGIN
 delete from inventory where IDtrans=old.IDpindahgudang and typetrans='pindah gudang';
END;

CREATE TABLE `pindahgudangdet` (
  `IDpindahgudang` INTEGER(11) NOT NULL,
  `IDproduct` INTEGER(11) NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  KEY `IDpindahgudang` (`IDpindahgudang`),
  KEY `kode` (`kode`),
  CONSTRAINT `pindahgudangdet_fk` FOREIGN KEY (`IDpindahgudang`) REFERENCES `pindahgudang` (`IDpindahgudang`) ON DELETE CASCADE,
  CONSTRAINT `pindahgudangdet_fk1` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `pindahgudangdetform` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000'
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `prodbuf` (
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `qty` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT 'PCS',
  `hargajual` DOUBLE(15,3) DEFAULT '0.000',
  `gol` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodegol` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000'
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB;';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `prodbuf_before_ins_tr` BEFORE INSERT ON `prodbuf`
  FOR EACH ROW
BEGIN
 declare vkodegol,vkode varchar(20);
 declare vkodeint int(11);
 
 select kode into vkodegol from golongan where nama = new.gol;
 set new.kodegol = vkodegol;
 
 set vkodeint = null;
 select max(right(kode,4)) into vkodeint from prodbuf 
 where kodegol = vkodegol;
 
 if (vkodeint is null) then set vkode = concat(vkodegol,'0001');
 else set vkode = concat(vkodegol,LPAD(vkodeint+1,4,'0')); 
 end if;
 
 set new.kode = vkode;
END;

CREATE TABLE `productgudang` (
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `IDgudang` INTEGER(11) NOT NULL,
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`IDproduct`, `IDgudang`),
  KEY `IDgudang` (`IDgudang`),
  KEY `IDproduct` (`IDproduct`),
  CONSTRAINT `productgudang_fk1` FOREIGN KEY (`IDgudang`) REFERENCES `gudang` (`IDgudang`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `purchaseorderdet` (
  `IDpurchaseorder` INTEGER(11) NOT NULL,
  `IDproduct` INTEGER(11) NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  KEY `IDpurchaseorder` (`IDpurchaseorder`),
  KEY `kode` (`kode`),
  CONSTRAINT `purchaseorderdet_fk` FOREIGN KEY (`IDpurchaseorder`) REFERENCES `purchaseorder` (`IDpurchaseorder`) ON DELETE CASCADE,
  CONSTRAINT `purchaseorderdet_fk1` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `purchaseorderdetform` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000'
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `reportrugilaba` (
  `idrugilaba` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `tanggal` DATE DEFAULT NULL,
  `keterangan` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `labakotor` DOUBLE(15,3) DEFAULT '0.000',
  `operasional` DOUBLE(15,3) DEFAULT '0.000',
  `pajak` DOUBLE(15,3) DEFAULT '0.000',
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`idrugilaba`)
)ENGINE=InnoDB
AUTO_INCREMENT=17 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `returbelidetail` (
  `idReturBeli` INTEGER(11) NOT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `keterangan` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `qtybeli` DOUBLE(15,3) DEFAULT '0.000',
  `qtyretur` DOUBLE(15,3) DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT NULL,
  `diskon_rp` DOUBLE(15,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `fakturbeli` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargajual` DOUBLE(15,3) DEFAULT '0.000',
  KEY `kode` (`kode`),
  CONSTRAINT `returbelidetail_fk` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `returbelimaster` (
  `idReturBeli` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `operator` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `fakturbeli` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `noinvoice` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodesupplier` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `supplier` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat` VARCHAR(250) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `totaltrans` DOUBLE(15,3) DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `ppn` DOUBLE(15,3) DEFAULT '0.000',
  `totalretur` DOUBLE(15,3) DEFAULT '0.000',
  `lunas` TINYINT(1) DEFAULT '0',
  `isposted` TINYINT(1) DEFAULT '0' COMMENT '-1 = batal posting\r\n0 = belum posting\r\n1 = sudah posting',
  `pembayaran` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `checked` TINYINT(1) DEFAULT '0',
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `faktur2` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`idReturBeli`),
  UNIQUE KEY `faktur` (`faktur`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `returjualdetail` (
  `idReturJual` INTEGER(11) NOT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `keterangan` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `qtyjual` DOUBLE(15,3) DEFAULT '0.000',
  `qtyretur` DOUBLE(15,3) DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskon_rp` DOUBLE(15,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `fakturjual` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `fakturjualold` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `fakturjualnew` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  KEY `kode` (`kode`),
  CONSTRAINT `returjualdetail_fk` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `returjualmaster` (
  `idReturJual` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `operator` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodecustomer` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `customer` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat` VARCHAR(250) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `totaltrans` DOUBLE(15,3) DEFAULT '0.000',
  `subtotal` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `ppn` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `totalretur` DOUBLE(15,3) DEFAULT '0.000',
  `lunas` TINYINT(1) DEFAULT '0',
  `fakturjual` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `isposted` TINYINT(1) DEFAULT '0' COMMENT '-1 = batal posting\r\n0 = belum posting\r\n1 = sudah posting',
  `pembayaran` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `checked` TINYINT(1) DEFAULT '0',
  `kodegudang` VARCHAR(10) COLLATE latin1_swedish_ci NOT NULL DEFAULT 'TK',
  `returpajakno` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `faktur2` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`idReturJual`),
  UNIQUE KEY `faktur` (`faktur`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `rusakdetail` (
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `idrusak` INTEGER(11) NOT NULL,
  KEY `faktur` (`faktur`)
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `rusakmaster` (
  `idrusak` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `kasir` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `isposted` TINYINT(1) DEFAULT '0' COMMENT '-1 = batal posting\r\n0 = belum posting\r\n1 = sudah posting',
  PRIMARY KEY (`idrusak`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `sales` (
  `idsales` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `alamat` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tgllahir` DATE DEFAULT NULL,
  `tempatlahir` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tglmasuk` DATE DEFAULT NULL,
  `noktp` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tglnoneffective` DATE DEFAULT NULL,
  PRIMARY KEY (`idsales`),
  UNIQUE KEY `kode` (`kode`),
  UNIQUE KEY `nama` (`nama`)
)ENGINE=InnoDB
AUTO_INCREMENT=2 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `selltourgroup` (
  `IDselltourgroup` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nogroup` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl` DATE NOT NULL,
  `namatour` VARCHAR(150) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `jumlorg` INTEGER(11) NOT NULL DEFAULT '1',
  `leader` VARCHAR(150) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `driver` VARCHAR(150) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `asal` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tujuan` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `keterangan` TEXT COLLATE latin1_swedish_ci,
  `jenisbus` TINYINT(4) NOT NULL DEFAULT '0',
  `presentfee` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `norental` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`IDselltourgroup`)
)ENGINE=InnoDB
AUTO_INCREMENT=25 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `sellmaster` (
  `idsell` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `IDselltourgroup` INTEGER(11) UNSIGNED DEFAULT NULL,
  `IDsales` INTEGER(11) DEFAULT NULL,
  `IDcustomer` INTEGER(11) NOT NULL,
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tanggal` DATE DEFAULT NULL,
  `waktu` TIME DEFAULT NULL,
  `kasir` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `discpct` DOUBLE(15,3) DEFAULT '0.000',
  `discrp` DOUBLE(15,3) DEFAULT '0.000',
  `discbulat` DOUBLE(15,3) DEFAULT '0.000',
  `grandtotal` DOUBLE(15,3) DEFAULT '0.000',
  `bayartunai` DOUBLE(15,3) DEFAULT '0.000',
  `bayarcard` DOUBLE(15,3) DEFAULT '0.000',
  `cardbank` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cardno` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cardname` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kembali` DOUBLE(15,3) DEFAULT '0.000',
  `isposted` TINYINT(1) DEFAULT '0',
  `lunas` TINYINT(1) DEFAULT '0',
  `totalpayment` DOUBLE(15,3) DEFAULT '0.000',
  `bayarskrg` DOUBLE(15,3) DEFAULT '0.000',
  `checked` TINYINT(1) DEFAULT '0',
  `keterangan` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ppn` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `fakturpajakno` VARCHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  `totalretur` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `faktur2` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ic2` TINYINT(1) DEFAULT NULL,
  PRIMARY KEY (`idsell`),
  UNIQUE KEY `faktur` (`faktur`),
  KEY `IDcustomer` (`IDcustomer`),
  KEY `IDselltourgroup` (`IDselltourgroup`),
  CONSTRAINT `sellmaster_fk` FOREIGN KEY (`IDcustomer`) REFERENCES `customer` (`IDcustomer`),
  CONSTRAINT `sellmaster_fk1` FOREIGN KEY (`IDselltourgroup`) REFERENCES `selltourgroup` (`IDselltourgroup`)
)ENGINE=InnoDB
AUTO_INCREMENT=4 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `selldetail` (
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kategori` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `merk` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `seri` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hargajual` DOUBLE(15,3) DEFAULT '0.000',
  `diskon` FLOAT(9,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `diskon_rp` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `quantity` DOUBLE(15,3) DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) DEFAULT '0.000',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `subtotal` DOUBLE(15,3) DEFAULT '0.000',
  `isposted` TINYINT(1) DEFAULT '1',
  `idstts` TINYINT(4) DEFAULT '0' COMMENT '0 = Value\r\n1 = Free\r\n2 = Tukar',
  `idsell` INTEGER(11) NOT NULL,
  `komisisales` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `feebiro` FLOAT(9,3) NOT NULL DEFAULT '0.000',
  `feedrivertl` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `feerent` DOUBLE(15,3) DEFAULT '0.000',
  KEY `faktur` (`faktur`),
  KEY `idsell` (`idsell`),
  KEY `kode` (`kode`),
  CONSTRAINT `selldetail_fk` FOREIGN KEY (`faktur`) REFERENCES `sellmaster` (`faktur`) ON UPDATE CASCADE,
  CONSTRAINT `selldetail_fk1` FOREIGN KEY (`idsell`) REFERENCES `sellmaster` (`idsell`),
  CONSTRAINT `selldetail_fk2` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB; (`faktur`) REFER `sparepart/sellmaster`(`faktur`); (`ids';

CREATE TABLE `sellpayment` (
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `kodecustomer` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `customer` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tanggal` DATE NOT NULL,
  `waktu` TIME NOT NULL,
  `kasir` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `transfer` DOUBLE(15,3) DEFAULT '0.000',
  `tunai` DOUBLE(15,3) DEFAULT '0.000',
  `bg` DOUBLE(15,3) DEFAULT '0.000',
  `totalpiutangfaktur` DOUBLE(15,3) DEFAULT '0.000',
  `totalretur` DOUBLE(15,3) DEFAULT '0.000',
  `diskonrp` DOUBLE(15,3) DEFAULT '0.000',
  `tanggalinput` DATE NOT NULL,
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `isposted` TINYINT(1) DEFAULT '0',
  `saldo_piutang` DOUBLE(15,3) DEFAULT '0.000',
  PRIMARY KEY (`faktur`)
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `sellpaymentbg` (
  `faktur` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl` DATE DEFAULT NULL,
  `transfer` DOUBLE(15,3) DEFAULT '0.000',
  `bg` DOUBLE(15,3) DEFAULT '0.000',
  `bgno` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `bgbank` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `bgtempo` DATE DEFAULT NULL,
  `tobank` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `sqlfromme` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sqlcmd` VARCHAR(500) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `struk` (
  `IDstruk` TINYINT(4) NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cabang` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `phone` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `footer1` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `footer2` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `footer3` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `footer4` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `footer5` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `endfooter1` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `endfooter2` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `endfooter3` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `mintrans` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `presentfeebusrental` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `presentfeebusbesar` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `presentfeebuskecil` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `isaktif` TINYINT(1) NOT NULL DEFAULT '0',
  `mt` TINYINT(4) DEFAULT '8',
  `rewardmember` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `rewardcair` TINYINT(4) UNSIGNED NOT NULL DEFAULT '5',
  PRIMARY KEY (`IDstruk`)
)ENGINE=InnoDB
AUTO_INCREMENT=2 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `supplier` (
  `IDsupplier` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat` VARCHAR(250) COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat2` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kota2` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `kodepos` VARCHAR(10) COLLATE latin1_swedish_ci DEFAULT NULL,
  `telephone` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `telephone2` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `fax` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `rekening` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hp` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `hp2` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tglnoneffective` DATE DEFAULT NULL,
  PRIMARY KEY (`kode`),
  UNIQUE KEY `kode` (`kode`),
  UNIQUE KEY `IDsupplier` (`IDsupplier`)
)ENGINE=InnoDB
AUTO_INCREMENT=406 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `terimagudang` (
  `IDterimagudang` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `docno` VARCHAR(30) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `doctgl` DATE NOT NULL,
  `IDgudangfrom` INTEGER(11) NOT NULL,
  `IDgudang` INTEGER(11) NOT NULL,
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDuserposted` INTEGER(11) DEFAULT NULL,
  `usernameposted` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT '',
  `posted` DATETIME DEFAULT NULL,
  PRIMARY KEY (`IDterimagudang`),
  UNIQUE KEY `docno` (`docno`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `terimagudang_before_upd_tr` BEFORE UPDATE ON `terimagudang`
  FOR EACH ROW
BEGIN
 declare vkodegudang VARCHAR(10);
 declare vkodegudangfrom VARCHAR(10);

 select kodegudang into vkodegudang from gudang where IDgudang=new.IDgudang;

 if (old.posted is null) and (new.posted is not null) THEN
 begin
  insert into inventory (tgltrans,kodebrg,kodegudang,qty,satuan,hargabeli,hargajual,typetrans,faktur,IDtrans,IDuser,username,waktu,keterangan) 
  select new.doctgl,b.kode,vkodegudang,b.qty,b.satuan,b.hargabeli,b.hargajual,'terima gudang',new.docno,new.IDterimagudang,new.IDuserposted,new.usernameposted,time(now()),new.notes from terimagudangdet b where b.IDterimagudang=new.IDterimagudang;

 end;
 elseif (old.posted is not null) and (new.posted is null) THEN
 begin
  delete from inventory where IDtrans=old.IDterimagudang and typetrans='terima gudang';
 end;
 end if;

END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `terimagudang_before_del_tr` BEFORE DELETE ON `terimagudang`
  FOR EACH ROW
BEGIN
 delete from inventory where IDtrans=old.IDterimagudang and typetrans='terima gudang';
END;

CREATE TABLE `terimagudangdet` (
  `IDterimagudang` INTEGER(11) NOT NULL,
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  KEY `IDterimagudang` (`IDterimagudang`),
  KEY `kode` (`kode`),
  KEY `IDproduct` (`IDproduct`),
  CONSTRAINT `terimagudangdet_fk` FOREIGN KEY (`IDterimagudang`) REFERENCES `terimagudang` (`IDterimagudang`) ON DELETE CASCADE,
  CONSTRAINT `terimagudangdet_fk1` FOREIGN KEY (`IDproduct`) REFERENCES `product` (`IDproduct`),
  CONSTRAINT `terimagudangdet_fk2` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `terimagudangdetform` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDproduct` INTEGER(11) NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000'
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `terimapurchase` (
  `IDterimapurchase` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `docno` VARCHAR(30) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `doctgl` DATE NOT NULL,
  `pono` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `invoiceno` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDgudang` INTEGER(11) NOT NULL,
  `totalprice` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDuserposted` INTEGER(11) DEFAULT NULL,
  `usernameposted` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT '',
  `posted` DATETIME DEFAULT NULL,
  PRIMARY KEY (`IDterimapurchase`),
  UNIQUE KEY `docno` (`docno`),
  KEY `pono` (`pono`),
  CONSTRAINT `terimapurchase_fk` FOREIGN KEY (`pono`) REFERENCES `purchaseorder` (`pono`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE DEFINER = 'metabrain'@'%' TRIGGER `terimapurchase_before_upd_tr` BEFORE UPDATE ON `terimapurchase`
  FOR EACH ROW
BEGIN
 declare vkodegudang VARCHAR(10);

 select kodegudang into vkodegudang from gudang where IDgudang=new.IDgudang;

 if (old.posted is null) and (new.posted is not null) THEN
 begin
  insert into inventory (tgltrans,kodebrg,kodegudang,qty,satuan,hargabeli,hargajual,typetrans,faktur,IDtrans,IDuser,username,waktu,keterangan) 
  select new.doctgl,b.kode,vkodegudang,b.qty,b.satuan,b.hargabeli,b.hargajual,'terima purchase',new.docno,new.IDterimapurchase,new.IDuserposted,new.usernameposted,time(now()),new.notes from terimapurchasedet b where b.IDterimapurchase=new.IDterimapurchase;

 end;
 elseif (old.posted is not null) and (new.posted is null) THEN
 begin
  delete from inventory where IDtrans=old.IDterimapurchase and typetrans='terima purchase';
 end;
 end if;

END;

CREATE DEFINER = 'metabrain'@'%' TRIGGER `terimapurchase_before_del_tr` BEFORE DELETE ON `terimapurchase`
  FOR EACH ROW
BEGIN
 delete from inventory where IDtrans=old.IDterimapurchase and typetrans='terima purchase';
END;

CREATE TABLE `terimapurchasedet` (
  `IDterimapurchase` INTEGER(11) NOT NULL,
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  KEY `IDterimapurchase` (`IDterimapurchase`),
  KEY `IDproduct` (`IDproduct`),
  KEY `kode` (`kode`),
  CONSTRAINT `terimapurchasedet_fk` FOREIGN KEY (`IDterimapurchase`) REFERENCES `terimapurchase` (`IDterimapurchase`) ON DELETE CASCADE,
  CONSTRAINT `terimapurchasedet_fk1` FOREIGN KEY (`IDproduct`) REFERENCES `product` (`IDproduct`),
  CONSTRAINT `terimapurchasedet_fk2` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `terimapurchasedetform` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDproduct` INTEGER(11) NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `qty` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000'
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `ttkonsi` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `ttno` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tgl` DATE NOT NULL,
  `idsupplier` INTEGER(11) NOT NULL,
  `ket` VARCHAR(255) COLLATE latin1_swedish_ci DEFAULT NULL,
  `iduser` INTEGER(11) NOT NULL,
  `dibuat` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `diterima` VARCHAR(150) COLLATE latin1_swedish_ci DEFAULT NULL,
  `subtotal` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `ongkir` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `total` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ttno` (`ttno`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `ttkonsidet` (
  `idttkonsi` INTEGER(11) NOT NULL,
  `idbeli` INTEGER(11) DEFAULT NULL,
  `subtotal` DOUBLE(15,3) NOT NULL DEFAULT '0.000'
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `ubahharga` (
  `IDubahharga` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `docno` VARCHAR(30) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `doctgl` DATE NOT NULL,
  `notes` VARCHAR(500) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDuserposted` INTEGER(11) DEFAULT NULL,
  `usernameposted` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `posted` DATETIME DEFAULT NULL,
  PRIMARY KEY (`IDubahharga`),
  UNIQUE KEY `docno` (`docno`),
  UNIQUE KEY `docno_2` (`docno`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `ubahhargadet` (
  `IDubahharga` INTEGER(11) NOT NULL,
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajualbaru` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `tglberlaku` DATE NOT NULL,
  KEY `IDubahharga` (`IDubahharga`),
  KEY `IDproduct` (`IDproduct`),
  KEY `kode` (`kode`),
  CONSTRAINT `ubahhargadet_fk` FOREIGN KEY (`IDubahharga`) REFERENCES `ubahharga` (`IDubahharga`) ON DELETE CASCADE,
  CONSTRAINT `ubahhargadet_fk1` FOREIGN KEY (`IDproduct`) REFERENCES `product` (`IDproduct`),
  CONSTRAINT `ubahhargadet_fk2` FOREIGN KEY (`kode`) REFERENCES `product` (`kode`) ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `ubahhargadetform` (
  `ipv` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `IDproduct` INTEGER(11) UNSIGNED NOT NULL,
  `kode` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `nama` VARCHAR(100) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `satuan` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `hargabeli` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajual` DOUBLE(15,3) NOT NULL DEFAULT '0.000',
  `hargajualbaru` DOUBLE(15,3) DEFAULT '0.000',
  `tglberlaku` DATE DEFAULT NULL,
  KEY `IDproduct` (`IDproduct`),
  CONSTRAINT `ubahhargadetform_fk` FOREIGN KEY (`IDproduct`) REFERENCES `product` (`IDproduct`) ON DELETE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `user` (
  `IDuser` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `password` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT NULL,
  `IDusergroup` INTEGER(11) NOT NULL,
  `usergroup` VARCHAR(80) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `tglnoneffective` DATE DEFAULT NULL,
  UNIQUE KEY `IDuser` (`IDuser`),
  UNIQUE KEY `username` (`username`)
)ENGINE=InnoDB
AUTO_INCREMENT=79 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE TABLE `usergroup` (
  `IDusergroup` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `usergroup` VARCHAR(80) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `isedit` TINYINT(1) DEFAULT '0',
  `isdel` TINYINT(1) DEFAULT '0',
  PRIMARY KEY (`IDusergroup`),
  UNIQUE KEY `usergroup` (`usergroup`)
)ENGINE=InnoDB
AUTO_INCREMENT=9 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `usergroupmenu` (
  `IDusergroup` INTEGER(11) NOT NULL,
  `IDmenu` INTEGER(11) NOT NULL,
  KEY `IDusergroup` (`IDusergroup`),
  KEY `IDmenu` (`IDmenu`),
  CONSTRAINT `usergroupmenu_fk` FOREIGN KEY (`IDusergroup`) REFERENCES `usergroup` (`IDusergroup`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usergroupmenu_fk1` FOREIGN KEY (`IDmenu`) REFERENCES `menu` (`IDmenu`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci';

CREATE TABLE `wilayah` (
  `kodewilayah` VARCHAR(2) COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `namawilayah` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`kodewilayah`)
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT='InnoDB free: 731136 kB';

CREATE DEFINER = 'metabrain'@'%' FUNCTION `f_happy_birthday`()
    RETURNS varchar(500) CHARSET latin1
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  declare vnama VARCHAR(200);  
  declare vhasil VARCHAR(500);  
  
  begin
  declare c_emp cursor for (select nama from customer where month(tgllahir)=month(CURRENT_DATE) and dayofmonth(tgllahir)=dayofmonth(CURRENT_DATE)) union 
                           (select nama from sales where month(tgllahir)=month(CURRENT_DATE) and dayofmonth(tgllahir)=dayofmonth(CURRENT_DATE)) order by nama;
  declare exit handler for not found begin end;
  set vhasil = 'HAPPY BIRTHDAY TO ';
  open c_emp;
  loop
     fetch c_emp into vnama;
     set vhasil = concat(vhasil,' : ',vnama);
  end loop;
  close c_emp;
  end;
   
  if vhasil = 'HAPPY BIRTHDAY TO ' then set vhasil=''; end if;
  
  RETURN vhasil;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `getjumlmembergroup`(vnogroup VARCHAR(20), vdate DATE)
    RETURNS tinyint(4)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  declare juml tinyint(4);

  select count(*) into juml from memberabsensi where nogroup=vnogroup and date(tgl)=vdate;
  RETURN juml;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `getpembelianstock`(vkodebrg VARCHAR(50), vkodegudang VARCHAR(10), vtglstart DATE, vtglend DATE)
    RETURNS double(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  declare qtytot DOUBLE(15,3);
  set qtytot = 0;
  select sum(qty) into qtytot from inventory where kodebrg = vkodebrg and kodegudang = vkodegudang and qty>0 and tgltrans between vtglstart and vtglend;
  if (qtytot is null) then set qtytot = 0; end if;
  RETURN qtytot;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `getpenjualanstock`(
        vkodebrg VARCHAR(50),
        vkodegudang VARCHAR(10),
        vtglstart DATE,
        vtglend DATE
    )
    RETURNS double(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  declare qtytot DOUBLE(15,3);
  set qtytot = 0;

  select coalesce(sum(-1*qty),0) into qtytot from inventory where kodebrg = vkodebrg and kodegudang = vkodegudang and qty<0 and tgltrans between vtglstart and vtglend;
  if (qtytot is null) then set qtytot = 0; end if;

  RETURN qtytot;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `getQtysisaReturBeli`(
        fakturno VARCHAR(50),
        kodebrg VARCHAR(20)
    )
    RETURNS double(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 declare qtypcsbelitot,qtypcsreturtot,qtyresult double(15,3);
 
 select SUM(quantity) into qtypcsbelitot from buydetail where faktur=fakturno and kode=kodebrg;
 select SUM(d.qtyretur) into qtypcsreturtot from returbelidetail d 
 left join returbelimaster m on d.faktur=m.faktur  
 where m.fakturbeli=fakturno and d.kode=kodebrg and m.isposted=1;
 
 if (qtypcsbelitot is null) then set qtypcsbelitot=0; end if; 
 if (qtypcsreturtot is null) then set qtypcsreturtot=0; end if; 
 
 set qtyresult = qtypcsbelitot - qtypcsreturtot;
  
 return qtyresult;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `getQtysisaReturJual`(
        fakturno VARCHAR(50),
        kodebrg VARCHAR(20)
    )
    RETURNS double(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 declare qtypcsjualtot,qtypcsreturtot,qtyresult double(15,3);
 
 select SUM(quantity) into qtypcsjualtot from selldetail where faktur=fakturno and kode=kodebrg;
 select SUM(d.qtyretur) into qtypcsreturtot from returjualdetail d 
 left join returjualmaster m on d.faktur=m.faktur  
 where m.fakturjual=fakturno and d.kode=kodebrg and m.isposted=1;
 
 if (qtypcsjualtot is null) then set qtypcsjualtot=0; end if; 
 if (qtypcsreturtot is null) then set qtypcsreturtot=0; end if; 
 
 set qtyresult = qtypcsjualtot - qtypcsreturtot;
  
 return qtyresult;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `getQtyStock`(vkodebrg VARCHAR(50), vkodegudang VARCHAR(10))
    RETURNS double(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  declare qtytot double(15,3);
  set qtytot = 0;
  select sum(qty) into qtytot from inventory where kodebrg = vkodebrg and kodegudang = vkodegudang;
  if (qtytot is null) then set qtytot = 0; end if;
  RETURN qtytot;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `getsaldostock`(vkodebrg VARCHAR(50), vkodegudang VARCHAR(10), vtgl DATE)
    RETURNS double(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  declare qtytot DOUBLE(15,3);
  set qtytot = 0;
  select sum(qty) into qtytot from inventory where kodebrg = vkodebrg and kodegudang = vkodegudang and tgltrans<=vtgl;
  if (qtytot is null) then set qtytot = 0; end if;
  RETURN qtytot;
END;

CREATE DEFINER = 'metabrain'@'%' FUNCTION `TextTo128C`(
        inpstring VARCHAR(100)
    )
    RETURNS varchar(100) CHARSET latin1
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 declare l,i,j,asciino,wm integer(11);   
 declare bufstr varchar(2);
 declare rstring VARCHAR(100);
 
 set rstring='';
 
 set l=LENGTH(inpstring);
 
 if (l>0) then
 begin 

 set rstring=char('205' using latin1);
 
 if (l%2)<>0 then 
 begin 
  set inpstring=concat('0',inpstring);
  set l=l+1;
 end;
 end if; 
 
 set wm = 105;
 set asciino=0;
 set i=1;
 set j=1;
 while (i <= (l-1)) do
 begin
  set bufstr = SUBSTRING(inpstring,i,2);
  
  if (bufstr='00') then set asciino=194;
  else
  begin
   set asciino=cast(bufstr as signed)+32; 
  end;
  end if;
  
  set rstring=CONCAT(rstring,char(asciino using latin1));
  
  set wm = wm + (cast(bufstr as signed) * j);  
    
  set i=i+2;
  set j=j+1;
 end;
 end while;

 set wm = (wm % 103)+32;
 set rstring=CONCAT(rstring,char(wm using latin1));
 
 set rstring=CONCAT(rstring,char('206' using latin1));
 
 end; 
 end if;
 
 
 RETURN rstring;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `cleardata`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
SET FOREIGN_KEY_CHECKS=0;

 truncate adjustdetail;
 truncate adjustmaster;
 truncate buydetail;
 truncate buymaster;

 truncate buypayment;
 truncate buypaymentbg;

 truncate diskondetform;
 truncate formadjust;
 truncate formbg;
 truncate formbuy;
 truncate `formkeuangan`;
 truncate formretur;
 truncate formsell;
 truncate `formsell2`;
 

 truncate inventory;
 truncate inventoryimp;
 
 truncate productgudang;
 truncate product;
 truncate prodbuf;
 
 truncate jasa;
 truncate loginfo;
 truncate operasional;
 truncate `pindahgudangdetform`;
 truncate pindahgudangdet;
 truncate pindahgudang;
 truncate selltourgroup; 
 
 truncate  returbelidetail;
 truncate  returbelimaster;
 truncate  returjualdetail;
 truncate  returjualmaster;
 truncate  rusakdetail;
 truncate rusakmaster;
 truncate selldetail;
 truncate sellmaster;
 truncate sellpaymentbg; 
 truncate sellpayment;

END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_canceladjust`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.operasional where faktur=vfaktur and upper(kategori)='ADJUSTMENT';
 delete from sparepart.inventory where faktur=vfaktur and upper(typetrans)='ADJUSTMENT';
 delete from sparepart.adjustdetail where faktur=vfaktur;
 delete from sparepart.adjustmaster where faktur=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelbuy`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.operasional where faktur=vfaktur and upper(kategori)='PEMBELIAN';
 delete from sparepart.inventory where faktur=vfaktur and upper(typetrans)='PEMBELIAN';
 delete from sparepart.buydetail where faktur=vfaktur;
 delete from sparepart.buymaster where faktur=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelfaktur`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.operasional where faktur=vfaktur and upper(kategori)='PENJUALAN';
 delete from sparepart.inventory where faktur=vfaktur and upper(typetrans)='PENJUALAN';
 delete from sparepart.selldetail where faktur=vfaktur;
 delete from sparepart.sellmaster where faktur=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelpindahgudang`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.inventory where faktur=vfaktur and upper(typetrans)='PINDAH GUDANG';
 delete from sparepart.pindahgudangdet where IDpindahgudang=(select IDpindahgudang from pindahgudang where docno = vfaktur);
 delete from sparepart.pindahgudang where docno=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelpo`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.purchaseorderdet where IDpurchaseorder=(select IDpurchaseorder from purchaseorder where pono = vfaktur);
 delete from sparepart.purchaseorder where pono=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelpromodiskon`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.diskondet where IDdiskon=(select IDdiskon from diskon where docno = vfaktur);
 delete from sparepart.diskon where docno=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelretur`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.operasional where faktur=vfaktur and upper(kategori)='RETUR PENJUALAN TUNAI';
 delete from sparepart.inventory where faktur=vfaktur and trim(typetrans)='retur penjualan';
 delete from sparepart.returjualdetail where faktur=vfaktur;
 delete from sparepart.returjualmaster where faktur=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelreturbeli`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.operasional where faktur=vfaktur and upper(kategori)='RETUR PEMBELIAN TUNAI';
 delete from sparepart.inventory where faktur=vfaktur and trim(typetrans)='retur pembelian';
 delete from sparepart.returbelidetail where faktur=vfaktur;
 delete from sparepart.returbelimaster where faktur=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelterimagudang`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.inventory where faktur=vfaktur and upper(typetrans)='TERIMA GUDANG';
 delete from sparepart.terimagudangdet where IDterimagudang=(select IDterimagudang from terimagudang where docno = vfaktur);
 delete from sparepart.terimagudang where docno=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `p_cancelubahharga`(IN vfaktur VARCHAR(50))
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 delete from sparepart.ubahhargadet where IDubahharga=(select IDubahharga from ubahharga where docno = vfaktur);
 delete from sparepart.ubahharga where docno=vfaktur;
END;

CREATE DEFINER = 'metabrain'@'%' PROCEDURE `setic2`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
 declare vic2 TINYINT(1);

 select coalesce(ic2,0) into vic2 from sellmaster where (ic2 is not null) and (bayartunai>0) and (isposted>-1) order by idsell desc limit 1;
 
 if (vic2 is null) then set @ic2 = 0;
 elseif (vic2=3) then set @ic2 = 0;
 else set @ic2 = vic2;
 end if;
 
 update sellmaster set ic2 = if((@ic2:=@ic2+1)>3,@ic2:=1,@ic2) where (bayartunai>0) and (isposted>-1) and (ic2 is null) order by idsell;
END;

CREATE ALGORITHM=UNDEFINED DEFINER=`metabrain`@`%` SQL SECURITY DEFINER VIEW v_buy AS 
  select 
    `a`.`tanggal` AS `tanggal`,
    `b`.`faktur` AS `faktur`,
    `b`.`kode` AS `kode`,
    `b`.`nama` AS `nama`,
    `b`.`kategori` AS `kategori`,
    `b`.`merk` AS `merk`,
    `b`.`seri` AS `seri`,
    `b`.`harganondiskon` AS `harganondiskon`,
    `b`.`diskon` AS `diskon`,
    `b`.`hargabeli` AS `hargabeli`,
    `b`.`quantity` AS `quantity`,
    `b`.`satuan` AS `satuan` 
  from 
    (`buydetail` `b` left join `buymaster` `a` on((`b`.`faktur` = `a`.`faktur`)));

INSERT INTO `conf` (`pathsource`, `ipremotemysql`, `dbremotemysql`, `unremotemysql`, `pwremotemysql`) VALUES 
  (NULL,'128.199.189.176','davenzju_sparepart','davenzju_meta','Meta289976');
COMMIT;

INSERT INTO `gudang` (`IDgudang`, `kodegudang`, `namagudang`, `alamat1`, `alamat2`, `telp`, `fax`, `kota`, `wilayah`, `type`, `isbadstock`, `lokasi`) VALUES 
  (1,'SL','GUDANG MADUKORO',NULL,NULL,NULL,NULL,'SEMARANG',NULL,NULL,0,'MADUKORO'),
  (4,'SLT','TOKO MADUKORO',NULL,NULL,NULL,NULL,'SEMARANG',NULL,NULL,0,'MADUKORO'),
  (7,'SLR','RUSAK MADUKORO',NULL,NULL,NULL,NULL,'SEMARANG',NULL,NULL,1,'MADUKORO');
COMMIT;

INSERT INTO `menu` (`IDmenu`, `nama`) VALUES 
  (1,'MASTER ITEM'),
  (2,'MASTER GOLONGAN'),
  (3,'MASTER CUSTOMER'),
  (4,'MASTER SALES'),
  (5,'MASTER SUPPLIER'),
  (6,'SETTING STRUK'),
  (7,'INPUT PENJUALAN'),
  (8,'INPUT RETUR PENJUALAN'),
  (9,'INPUT BIRO/ROMBONGAN'),
  (10,'INPUT PEMBELIAN'),
  (11,'INPUT RETUR PEMBELIAN'),
  (12,'PEMBAYARAN HUTANG'),
  (13,'INPUT STOCK ADJUSTMENT'),
  (14,'INPUT PENGELUARAN GUDANG'),
  (16,'INPUT PROMO DISKON'),
  (17,'INPUT ORDER PEMBELIAN'),
  (18,'INPUT UBAH HARGA'),
  (19,'OPERASIONAL'),
  (20,'DAFTAR PENJUALAN'),
  (21,'DAFTAR RETUR PENJUALAN'),
  (22,'DAFTAR PEMBELIAN'),
  (23,'DAFTAR RETUR PEMBELIAN'),
  (24,'DAFTAR PENGELUARAN GUDANG'),
  (26,'DAFTAR STOK'),
  (27,'DAFTAR PROMO DISKON'),
  (28,'DAFTAR ORDER PEMBELIAN'),
  (29,'DAFTAR UBAH HARGA'),
  (30,'BACKUP DATA'),
  (31,'GROUP USER'),
  (32,'REGISTER USER'),
  (33,'UBAH PASSWORD'),
  (34,'DAFTAR STOCK ADJUSTMENT'),
  (35,'INPUT BIRO/ROMBONGAN RENTAL'),
  (36,'VIEW TOUR GROUP BUS'),
  (37,'INPUT TT KONSINYASI'),
  (38,'USER ACCESS REPORT'),
  (39,'MASTER MEMBER'),
  (40,'MASTER ABSENSI MEMBER'),
  (41,'DAFTAR ABSENSI MEMBER'),
  (42,'INPUT PRINT REWARD MEMBER'),
  (43,'DAFTAR PRINT REWARD MEMBER');
COMMIT;

INSERT INTO `sales` (`idsales`, `kode`, `nama`, `alamat`, `kota`, `tgllahir`, `tempatlahir`, `tglmasuk`, `noktp`, `tglnoneffective`) VALUES 
  (1,'SL','SALES','Jl.GEDAWANG RT.02/03','SEMARANG','1984-09-24','SEMARANG','2013-06-17','3374112609840000\r',NULL);
COMMIT;

INSERT INTO `struk` (`IDstruk`, `company`, `alamat`, `kota`, `cabang`, `phone`, `footer1`, `footer2`, `footer3`, `footer4`, `footer5`, `endfooter1`, `endfooter2`, `endfooter3`, `mintrans`, `presentfeebusrental`, `presentfeebusbesar`, `presentfeebuskecil`, `isaktif`, `mt`, `rewardmember`, `rewardcair`) VALUES 
  (1,'PUSAT OLEH-OLEH 52','JL. MADUKORO RAYA NO. 3A','SEMARANG','SEMARANG','TELP.024-7602094 HP.087882399553','TERIMA KASIH ATAS KUNJUNGAN ANDA','BARANG YANG SUDAH DIBELI TIDAK DAPAT','DITUKAR DAN/ATAU DIKEMBALIKAN','','','','','',0.000,0.000,100000.000,20000.000,1,8,100000.000,5);
COMMIT;

INSERT INTO `user` (`IDuser`, `username`, `password`, `IDusergroup`, `usergroup`, `tglnoneffective`) VALUES 
  (1,'OWNER','cyw',1,'OWNER',NULL),
  (4,'GREETER1','G1',7,'GREETER',NULL),
  (5,'KASIR A','KA',6,'KASIR','2020-01-24'),
  (6,'GUDANG1','G1',4,'ADM GUDANG','2020-01-24'),
  (7,'KAPTEM1','K1',5,'KAPTEN / LEADER / SPV','2020-01-24'),
  (8,'ADMINKEU1','ak1',3,'ADMIN KEUANGAN','2020-01-24'),
  (9,'MANAGER1','ds',2,'MANAGER',NULL),
  (11,'LINA','212721',7,'GREETER','2018-10-09'),
  (13,'RINA','SIDEPUAN',6,'KASIR','2019-01-10'),
  (14,'FITRI','fitri cipr',6,'KASIR','2019-12-17'),
  (15,'IFTA','RAFAEL',6,'KASIR','2019-01-10'),
  (17,'ITOK S','270617',4,'ADM GUDANG',NULL),
  (18,'AGSARI','204',3,'ADMIN KEUANGAN','2019-05-04'),
  (21,'FITRI1','17021996',6,'KASIR','2019-12-17'),
  (23,'FITRI2','08102016',6,'KASIR','2019-12-17'),
  (24,'IFTA1','I1',6,'KASIR','2019-01-10'),
  (25,'KSYOHANES','YH',6,'KASIR','2020-01-24'),
  (27,'TATIK1','123',6,'KASIR','2020-01-24'),
  (28,'MAYA','111',6,'KASIR','2019-12-17'),
  (29,'TALITHA','222',6,'KASIR','2018-11-29'),
  (30,'ARINA','2424',6,'KASIR','2019-12-17'),
  (31,'ARINA1','2424',6,'KASIR','2019-12-17'),
  (32,'BAGUS','bismillah52',7,'GREETER','2022-08-06'),
  (35,'OVELIA','EKO',6,'KASIR','2019-12-17'),
  (36,'sekar','123',3,'ADMIN KEUANGAN','2019-12-17'),
  (37,'NOVIA','nona16',6,'KASIR','2020-01-24'),
  (38,'NOVIA1','nona16',6,'KASIR','2020-01-24'),
  (39,'OVELIA1','kodok',6,'KASIR','2019-12-17'),
  (40,'KITRI','KITRI',3,'ADMIN KEUANGAN','2019-12-17'),
  (41,'DIAH','indahnya',3,'ADMIN KEUANGAN','2019-12-17'),
  (42,'efa','260818',6,'KASIR','2019-12-17'),
  (44,'AVI','681610',6,'KASIR',NULL),
  (45,'AVI1','608211',6,'KASIR','2020-01-24'),
  (46,'lusi','limadua',3,'ADMIN KEUANGAN','2019-12-17'),
  (47,'ika','patunited123',3,'ADMIN KEUANGAN','2022-07-04'),
  (48,'MUTI','510510',6,'KASIR','2019-12-17'),
  (49,'AISA','051089',6,'KASIR','2019-12-17'),
  (50,'irawan','MADUKORO52',7,'GREETER',NULL),
  (51,'AJI','AJIKAJIK',6,'KASIR','2019-12-17'),
  (53,'TITIN','895623',6,'KASIR','2019-12-17'),
  (58,'LUKAS','LUKAS',4,'ADM GUDANG','2020-02-24'),
  (59,'ARISKA','525252',3,'ADMIN KEUANGAN',NULL),
  (60,'ARISKA2','123',6,'KASIR',NULL),
  (61,'DIAN','123',6,'KASIR',NULL),
  (62,'TITHA','5252',6,'KASIR','2022-06-11'),
  (63,'RIZKI','2906',6,'KASIR',NULL),
  (64,'ARISKA3','123',6,'KASIR',NULL),
  (65,'RESTU','262028',3,'ADMIN KEUANGAN',NULL),
  (66,'po','123456',8,'GREETER VIEW',NULL),
  (67,'RIZKI1','2103',6,'KASIR',NULL),
  (68,'Vera','scorpio',4,'ADM GUDANG','2022-07-04'),
  (69,'kasir5','12345',6,'KASIR','2022-01-22'),
  (70,'kasir7','12345',6,'KASIR','2022-01-22'),
  (71,'kasir6','123456',6,'KASIR','2022-01-22'),
  (72,'FEBRY','TRI93',6,'KASIR','2022-06-11'),
  (73,'WIDYA','12345',6,'KASIR',NULL),
  (74,'hesti','hestimadua',3,'ADMIN KEUANGAN',NULL),
  (75,'SALSA','010120',6,'KASIR',NULL),
  (76,'AVRIEL','262726',6,'KASIR',NULL),
  (77,'PUTRI R','RAHMADHANI12',6,'KASIR',NULL),
  (78,'VITA','25061997',6,'KASIR',NULL);
COMMIT;

INSERT INTO `usergroup` (`IDusergroup`, `usergroup`, `isedit`, `isdel`) VALUES 
  (1,'OWNER',1,1),
  (2,'MANAGER',1,1),
  (3,'ADMIN KEUANGAN',1,0),
  (4,'ADM GUDANG',1,0),
  (5,'KAPTEN / LEADER / SPV',1,0),
  (6,'KASIR',0,0),
  (7,'GREETER',1,0),
  (8,'GREETER VIEW',0,0);
COMMIT;

INSERT INTO `usergroupmenu` (`IDusergroup`, `IDmenu`) VALUES 
  (6,3),
  (6,7),
  (6,19),
  (6,27),
  (6,29),
  (6,33),
  (5,8),
  (5,9),
  (5,19),
  (5,24),
  (5,27),
  (5,29),
  (7,3),
  (7,9),
  (7,33),
  (7,35),
  (1,1),
  (1,2),
  (1,3),
  (1,4),
  (1,5),
  (1,6),
  (1,7),
  (1,8),
  (1,9),
  (1,10),
  (1,11),
  (1,12),
  (1,13),
  (1,14),
  (1,16),
  (1,17),
  (1,18),
  (1,19),
  (1,20),
  (1,21),
  (1,22),
  (1,23),
  (1,24),
  (1,26),
  (1,27),
  (1,28),
  (1,29),
  (1,30),
  (1,31),
  (1,32),
  (1,33),
  (1,34),
  (1,35),
  (2,1),
  (2,2),
  (2,3),
  (2,4),
  (2,5),
  (2,6),
  (2,7),
  (2,8),
  (2,9),
  (2,10),
  (2,11),
  (2,12),
  (2,13),
  (2,14),
  (2,16),
  (2,17),
  (2,18),
  (2,19),
  (2,20),
  (2,21),
  (2,22),
  (2,23),
  (2,24),
  (2,26),
  (2,27),
  (2,28),
  (2,29),
  (2,30),
  (2,31),
  (2,32),
  (2,33),
  (2,34),
  (2,35),
  (4,1),
  (4,5),
  (4,14),
  (4,24),
  (4,26),
  (4,33),
  (3,1),
  (3,2),
  (3,3),
  (3,4),
  (3,5),
  (3,8),
  (3,9),
  (3,10),
  (3,11),
  (3,12),
  (3,13),
  (3,14),
  (3,16),
  (3,17),
  (3,18),
  (3,19),
  (3,20),
  (3,21),
  (3,22),
  (3,23),
  (3,24),
  (3,26),
  (3,27),
  (3,28),
  (3,29),
  (3,30),
  (3,32),
  (3,33),
  (3,35),
  (7,36),
  (1,36),
  (2,36),
  (8,33),
  (8,36),
  (1,37),
  (1,38),
  (1,39),
  (1,40),
  (1,41),
  (1,42),
  (1,43);
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;