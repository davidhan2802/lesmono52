object frmSales: TfrmSales
  Left = 172
  Top = 169
  BorderStyle = bsNone
  Caption = 'frmSales'
  ClientHeight = 413
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Georgia'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object Panelsales: TRzPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 413
    Align = alClient
    BorderOuter = fsFlatBold
    Color = 9619913
    TabOrder = 0
    object RzLabel1: TRzLabel
      Left = 15
      Top = 118
      Width = 53
      Height = 16
      Caption = 'Alamat'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzLabel2: TRzLabel
      Left = 15
      Top = 64
      Width = 52
      Height = 16
      Caption = 'Kode *)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzLabel3: TRzLabel
      Left = 15
      Top = 92
      Width = 58
      Height = 16
      Caption = 'Nama *)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object JasaLblNonEfektif: TRzLabel
      Left = 287
      Top = 278
      Width = 106
      Height = 16
      Caption = 'Tgl Non efektif'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzLabel4: TRzLabel
      Left = 15
      Top = 214
      Width = 33
      Height = 16
      Caption = 'Kota'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzLabel15: TRzLabel
      Left = 423
      Top = 64
      Width = 91
      Height = 16
      Caption = 'Tgl Masuk *)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzLabel5: TRzLabel
      Left = 15
      Top = 244
      Width = 130
      Height = 16
      Caption = 'Tempat/Tgl Lahir'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzLabel6: TRzLabel
      Left = 399
      Top = 244
      Width = 6
      Height = 16
      Caption = '/'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzLabel7: TRzLabel
      Left = 423
      Top = 94
      Width = 57
      Height = 16
      Caption = 'KTP No.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Georgia'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      BlinkIntervalOff = 2000
      BlinkIntervalOn = 1000
    end
    object RzPanel2: TRzPanel
      Left = 13
      Top = 8
      Width = 172
      Height = 41
      BorderInner = fsFlatRounded
      BorderOuter = fsFlatRounded
      Color = 52479
      GradientColorStyle = gcsCustom
      GradientColorStart = clYellow
      GradientColorStop = clSkyBlue
      GradientDirection = gdDiagonalUp
      TabOrder = 3
      object LblCaption: TRzLabel
        Left = 14
        Top = 11
        Width = 139
        Height = 18
        Alignment = taCenter
        AutoSize = False
        Caption = 'Tambah Sales'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Georgia'
        Font.Style = [fsBold]
        ParentFont = False
        BlinkIntervalOff = 2000
        BlinkIntervalOn = 1000
      end
    end
    object RzPanel3: TRzPanel
      Left = 16
      Top = 312
      Width = 137
      Height = 89
      BorderInner = fsFlatRounded
      BorderOuter = fsFlatRounded
      Color = clGray
      TabOrder = 4
      object RzLabel12: TRzLabel
        Left = 9
        Top = 64
        Width = 55
        Height = 16
        Caption = 'Simpan'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Georgia'
        Font.Style = [fsBold]
        ParentFont = False
        BlinkIntervalOff = 2000
        BlinkIntervalOn = 1000
      end
      object RzLabel14: TRzLabel
        Left = 73
        Top = 64
        Width = 56
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Batal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Georgia'
        Font.Style = [fsBold]
        ParentFont = False
        BlinkIntervalOff = 2000
        BlinkIntervalOn = 1000
      end
      object BtnAdd: TAdvSmoothButton
        Left = 8
        Top = 8
        Width = 57
        Height = 57
        Cursor = crHandPoint
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.BorderColor = clNone
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWindowText
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Tahoma'
        Status.Appearance.Font.Style = []
        Color = clGreen
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
          87000009ED694343504943432050726F66696C650000789CADD6675453D91607
          F0FFBD29840442EF2D20DD50A44A6F8A0D184414B0022134291182287650B0A1
          6057B02B76059551C78A0A228CA23411512C2038221D0B82791F8265D69B59EF
          CBDB9FF6D96BDDB3CEF9ED7DD73A8094629840104702884F1026054CF0E40487
          CCE448D4810A354803B00FE3250B3CFCFD7DF0AFF1B11E0400D4988509047189
          47A3AB119797A992E3C2E99FABFBF8DFBF0300B0938243660204178062943877
          07A0182ECE030128A60A0542808806A0C88B0E8B0088A500B84981015E00711C
          003B4A9C5F06C00E17E7E500D80B79514280680028F20911310900B503A0BB46
          F09379008B0B605E44322F1E606D0460191F9F1801B0AE0130E609928400AB05
          805970C84C8EF8C8E191807508401EFF599B2F051469028A353F6B2611804601
          70F5C4CF5A5F00080084725572A4B515008090F204682F44A23E4340620B309C
          2B127D3D24120D1F06284DC0AD385E4AD2C2112F827800FCAFB5F8CE23412100
          022495CE906449B165E4E415949455D53434B575387AA3F40D8D8C4D4773CD2D
          2CC758DBD8DAD98F75747276717573F7F0F41A37DE7BC2C44993A7F8F8FAFDE6
          3F352070FA8CA0E09099B3E6CC9D171A16CE8B888C8A8E899D1F179F20589094
          2C4C5998BA286DC9D265CB57AC5C959EB126336BEDBAF51B36666FCAC9DDB275
          DBF61D3B77EDDE9397BF77FF8183870E1F395A70ECF88993A74E9F397BAEB0A8
          E8FC858BC5BF5FBA7CE58FABD7AE5FBF71F356C9ED3B77EF9696DD2BBF5F5151
          F9E7838755558F1E57D7D4D4D6D5D53F696878DAD8F8ACA9E9F98B17CD2F5FBE
          7AFDFA4D4B4BEBDBB6B6F677EFFE7AFFBEE34367675777774F6F5F5FFFC0C0C7
          4F9F3F7F191CFC3A3434FCED9B0824952E21C99492969195575054565153D7D4
          D2E6E8EAE91B181A9B9872CDCC2D2CADAC6D6CEDC63AFC1BC0B41180D92300FC
          EF00893F0016FF0058BD26336BEDFA0D1BB3376DFE45207FEFBE7F101801100B
          8801EEFC0DE0D1E3C7D535B5B575F5FF08D0FA03A0430CD0D3D3DBD7DF3FF0F1
          E3A7CF5FBEFCBC3F854667483259D26C195979054525155535750D4D6D1D8EAE
          DE287D03236313D3D15C33730BCB3156D63636B676F6631D1C9D9C47247EA510
          0FC3778C59B3E7CC9D171A1A16CE8BF8E191F00B48DADF45D6FD42F27D26BE93
          FC9389986464284ACBEE9597DFFF95A4AEFE89D8E3F98BE697AF5EBF69697DDB
          D6FEEEAFF71D1F3ABBBA7B7AFBFA073E7EFE32F87568F89B0810FFFB0040B703
          0E2700339840E021607B3160E404A87401FED240A003C8646B909191205598A0
          10000980000574484206CAD08129EC300E81E02315EBB10F175189167C23D409
          7B623A914C6C258A89A7C437D280F4251792FBC94AF20BC5841242D940B949E9
          A772A911D4BDD4A734555A106D37AD89AE478FA65FA08B247C24F64874303C18
          BB18BD927E9267986CE6026603CB8B5528A52DB5499A944E931E6027B3FB6452
          65866533E5E4E40ECADBC85728842B7C53DCADA4AF744AD94AF99ACA04951AD5
          70D57EB575EA5AEA17357C345A359769A968156BFB6B77EAE4706C388DBA197A
          A3F5AA472DD5B7D06F32D868E862D86974D038C8846D526A9A3EDA6BF430F7BA
          D90A730F0B9A45A5E5B63173AC8CAC7AAD6FDAE4D886DBD9DAB3EC5F8FBDE2B0
          D991EFE4E2ACE5FCCDA5D9F586DB01F70C8F48CF295ED6E338E365C70F79774F
          A89F786FD2EDC925536EFB94F956FA3DFAADCEBF69EABB80AF8172D38D663807
          05060B42B2679E9955335B34D762DEBCD09CB0321E19E1C65F1279359A12E31F
          BB777E77FCE4843C0116F092CA849629FB53E516AD4D632C59BE7470F9CA95CC
          555B3374565FCAF4C96A5EB76483D6C6924DC19B45B9A7B7CEDA2EB1E3CCAE5D
          7B8AF25FEF973DE87C5870F4D8B1FA9392A7279DCD2E2C3D2F2AF6BA947EA5F2
          9AEC8DA05B476EF7977ADCCBBDFFF24F87871B1EBDA9B1ADDBF2A4B731A0E972
          B3DAABB4372FDEFAB797BCB7FE50D06DD49B37A0F469D7A0EED05391E847FF99
          90810A74C18503262204B1588A1C14E01AEAD045300963C29B88205613054405
          D1452A93AE6434B985BC4176503429BE9415940B94762A871A4CDD427D4863D3
          FC689B69B5740D7A38FD34FDB384B7C43689368633631BA353728AE409268B99
          C0AC6779B0CE4A6949654B13D28BA5FBD9C9EC3E99853243B26BE4E4E40EFCCF
          EEFB6AB46A2ED752D12AD69EAADDADB38563C779AE9BA967A1F76454BABE9D7E
          ABC10EC389865F8DCE19479AE898349AEE1E1DC255E23E333B68CEB7E05A7CB4
          BC3D26C76AAEB5990D6C9ED89EB4CBB40F1FEBEAA0EEF0D1B1D6E977E77C970C
          D758B70077270F234F792F78F58EEB19FFCABB69C283897727954C2E9952E273
          C7B7DCAFF2B72AFFDAA9CD019D81C47485190641F6C1FE21D133D3671D985D3A
          A76B9E46A87B5874F82E5E3D9F15E91295167D3D16F3C7C7E5C4BF483417A42F
          6848B612E6A6F4A7862CBA9566BA64FF3285E5D92B99ABB23228AB5765B2B2F2
          D619AFBFBCD12FFBFDE60DB9465B4AB6F17628EE7CBEFB493E7D9FCD01FEA1DD
          471E1CA39C703C157FE6F4B9B6F3DC8B29BF175FFE72D5F9FAEA9B8F6E6BDD0D
          2B2B2A1FAAF47B905FF5A1DAB37667FDDBA7F6CF729EB7BE747BBDA3E5439BEF
          BBFDEFBF74CEE8BEDEA737B0F653D7E09CA1EE91FE93604116CAE0C01C2EF043
          3852B1090528C10B0C13DA843B1141AC238A88269241DA9151E44EB29242529C
          282994224A37D58A2AA4FE41A3D0FC6879B4F77457FA367A87C40489A30C3A23
          96512DE92A7986A9C3DCC19265654B494B6D9656923EC4B66697C9CC91F92CBB
          5DCE4EAE493E4BC14EA15D315FC94BA95979AD8AB94A83EA1A353BB576F57C8D
          699A4CCD5B5A8BB56DB4BB750A39C9BA8E7A14BD7BA372F5430DCC0D860D2B8D
          F28C134C3C4D554D7B4657720BCC32CC432DDC2C3963A863DAAC2AAC0B6DF6D8
          A6DBC5DBCF1E3BD9C1DE51CF49C699E23CE8D2EDDAE2D6E05EE351EE59E2756B
          5CE9F852EFB2097726DE9D5439B9664A934FBB6FBF9FC89F395525C0649A5B60
          D0F484196B82F6065F09699C393C5B678EDBDCB07959A185614D3C46842D9F1F
          B92BAA2A86113B7E7E465C49BC28D15590BEE07EB2823034A528955C14B8F8E4
          127269C8B28B2BD456A6AD6AC8F05C7D2E53236BF5DAEEF5BC0DD5D9DE9B6EE6
          38E65ED9EAB0EDEA0ED79DA5BB67ECE9C9DFBACF74FF83838987E58F5C2D883C
          CE3A51782AE18CCED98785CBCF5B5FE82A3E7D29E68AE91F8DD7F26E04DD522C
          A9BDB3BD74FA3DA5F29A8A4D7F4E79C8AC2A7BBCA8C6AAB6BDFE60437023FBD9
          8DE7F39BD55F56BC16B6A8B6DE688B7DC7F8EB5087F787975D4B7A947A4FF43B
          0C547C9AF5B96370ED90EA70A3480488DF8B00005A8C6F180FFFE7888F4BF9BE
          2709408A9F307D1A0006006381D03FF07B8E18F8220C3CF13B1500E8B240BE11
          005CF64DFAAF7D85FC454200F04A142C4E8A898A16723C0482383EC72B315E90
          22E4277139931278E65C8E95A5A52D00FC078F08914C38CF9BB0000009964944
          41546881CD9A6D8C54D519C77FE79E7B6767975D5E765D410452C45AD1D848A2
          C688A2ADB1898AD1486C6325D525A6449798BAD8A654B044252DD58AA1604853
          DAFAA1522C2FBEB4919712ED075E424122DD2E28A22CB802EECEB2B3333B3B73
          EF3DE7E9873B3B0ECB2ECCC2ACF69F9CCCCDCCB9E7FCFFCF73CEF33CE7DE5122
          C2704229A5243F49F175B9E09473B06228A5148088C89D77DE79FDC68D1BE701
          4EDFF765838894BD012AFF3962D9B2650B44A45B44E4B9E79E7B2AFFBD53B6B9
          86438088306BD6AC5B5A5B5B77CBE9081A1B1B7F9817A1FFAF04F4597DFCF8F1
          75AFBDF6DA6F44242B03209D4E27A64F9F7E73B93C5136E222C2ECD9B3EF3971
          E244CB40C48B71E4C891E62953A65C0EA8E2FBBF72017D934F993265E2E6CD9B
          FF2822E65CE4FBB073E7CE4D401DA02F44C40511079CA6A6A687BABBBB8F964A
          BC186BD6AC5905C42E643F9CB7F5AFBDF6DA6FEED8B163DDF9102F4653535393
          C8F96FEAF3B17A6CC992258D994CA6FD42C98B8818637A1F7CF0C1FBF2630F79
          530F6993DE7EFBEDD30E1C38F0CF72102F463299FC6CDAB469D79D8F8852AD5E
          BD6AD5AA85611876979B7C1F5A5A5AFE5D5B5B7BA9F433DA0509101166CE9C79
          6B6B6BEB9EE1225E8C37DE78632D5039142F0C6AF5091326D46ED8B0E14511C9
          7D15E4FBB07CF9F2E7F3F9A12411037EF9E8A38FCEECE8E838F055122F827DEC
          B1C77E2425EE87D3AC3E69D2A44B366FDEBC5A8690908603994C2671C71D774C
          2FE636582B5C3CFCF0C33766B3D9E35F17E9FE686D6DFD60ECD8B193CF556E14
          CE03CDCDCDEDE9743A75C1F579993069D2A46FAF5BB76E39504324626048DE4D
          8073D34D377D2F9D4E9FFA1A0D7F0656AC58B194A85E1A703F140BA8006A1A1A
          1A7E2222F66BE4DC1F76D6AC59F7CA20FBA1387C3A4431B87EE9D2A5BFEB3FCA
          C7EDFBE5CDE63FC8A6837F912D1FFE55B61C5C236D5D87878FB5B51204A18888
          6CDFBEFD3DA07A202FF4655A0094520E1007C6AE5FBF7EC5FDF7DF7F57DF6F0B
          D63D4DAFB79B9AF8183C2786607132D7B0E8DE05E55AF605586B098290203018
          6370DD98BDEFBEBBBFB775EBD66DFDFB9E76A817110BF840C79C397316EDDDBB
          777FA1A3A3A888C588C52AF0BC189E174339E57F2660ADC5F74372B9805CCEA7
          A7A7975CCE77A64DBBFE3BF0E5C3820105E445844036994C1E7AE49147162412
          890E806C18702C95E0782AC1F19E4E8EA73AF1C3B0ACE445842008F1FD805C2E
          209DEEA1B3F314274E9CE4E69B675CAD9472FB8B18CC8421E0373737EF9C3367
          CE2220500E581D60DD10EB84181D22CA9655803196203004812193E9A5B3B38B
          53A792D4D5D5525D5D151F88EF800224DA1801907DEBADB7363CBBF0F997BC0A
          0F2726E0DAA86903AA7CCFA8442201C6587C3FA0BB3B85E3384C9D7A3963C78E
          2193C90D38D9A08B58A250DA0B9CFAE592452FB51D7CFFEDAA9A38A24DA19513
          2282B5166B2DB99C4F7D7D2DD75CF32DC68C198D31608C193099B97D174A29F5
          C0EBF523EAA9877A686F87FFFEAD9D4BAEA88EA75269FB49D77F0E5DE94E4030
          880AB162310400E44C261A03074769AC1842EB53E9D5A0CE9244FB49C88B10C2
          30240C158EA3C8E5021CC72395EACE016778A120E081D7EB47D48FBC688F7218
          A342154E1CE772C5CFA6A089E111972F7A52233BB359E29EC2E2A0B5A66EE2E7
          ACF9682188462B0F6B0D293FC189D46144143FBD710D956ECD10BC1009D1DAA1
          ADED244A29EAEB2F4204DADADA12447B73600135B15AE5797ABCE3E81A472B1C
          A530BE45BB827641BB0EA11F60C4C5510EE0E04B861ED3412ECC92F2132473ED
          64FC6E82D0A7DAABA338C79C1B8A28B828B476F13C8FC3875B89C52A18356A34
          478E7CD2292292CF5585810B023A3A3A48FA95A25D07472B945638DA21E6C688
          C72AC91A8360B1362450606C2F9F7477F3697740C64F118601621518451004D4
          B8F12109502A5A325A3B789E4B555515994C2F478F7ECED4A9A309027B62A0FB
          0A023E4C24A8EC8DA1630EDA55280F1C57E17A9A0A2F86A73DB476498786C0F8
          04A14F6002AC11C428C4286C209840087201A33C83B1438B525A3B68AD705D4D
          65659CD1A347914AF5D0D5952491683F968FFF2245962908A8A38EF1232E271E
          AF4069220FB8A034B85A93306DB4E78EA21D0741210813E35752CD188CB1580B
          120AD680090CCA3A4489BD54088EE3E0BA2E5A5B62318FEAEA1168EDD2D5D5E5
          EFDBB7FB181442FC991ED8B13D415D551A37E6A03D85E31135AD500A467D4351
          7B998BB5F9DA5B2B0E1E3A4CF7678252608D6043B08190CB058C89D721B34A8B
          405151192D23D7D5C4626E417C3C5EC9C9935FB4A652A96303DD5B10808F0A2B
          7D25A2B0A87C010E3AF21AD67A40AC2F544413EB00A934582BA49321810F1242
          2E0B5AE54A337C34525E88A094C2F35CAC152A2A2A514AF1F2CBAFAEEFECECFC
          82286F9D9680BE1450435669B540B9C4B52B56BB0E8E0B8E032895F5AAD45D62
          6566613E17FCE3B2B1637BB0FDD271E3A63E33EFE7B395A32B42DF608CA54257
          5219AB3A37F5823DA4E009C7D18C1CE971E0C0A123F3E7372D79E79DBF6FC877
          3A734DF6AFAF076B33D68D987FEB861AB97563D4BEBBA946AABF3FF6CFF92559
          BBE4D95F2D3BDFBADF182B6168C4F7A3FA3F08C260C58A575E1D356AD4346004
          D1616BC01359C9F5B01571A5CF4422107DF42D72FFE967162C5FBB76ED9BA58E
          D767FDBE4355B474342D2D073FBAFBEE7B7E3C6FDEE34F2593C98F88CA7B5F06
          8908250B3061883121A18D5A900B88D516124A16E8983B77EEE2DDBB77EF1B82
          04200A9F4110F82FBCF0DBD537DC70DD035BB6BCB31E48E7C70DFB479E62B883
          FDD01F17C727A03D1795976C8D30F2E228B38B48A894CA2693C94F1B1A1A7EB1
          6DDBB63F8D1B376EDC59A9E7ADAE14BCFFFEBEE6C6C6C77FBD6BD7AEAD400F91
          D5CF4ABC0F257BA0F7E3319823F5D84F2F8EDA917AFCAE58719710C8B5B4B4EC
          6E686858E8FB7EF66CE329A5C8647A7B172F7E76E58C19B73CB46BD7AE7F0029
          4AB07A314AF6C0D1C487B89E8376A2656F8C90CD5517027DBE4EF101B569D3A6
          B79F7CF2C9292B57AE1CF4C0BC73E7CEBD4F3CF1C40B7BF6EC790FC800B93CF1
          219D924A165077515536E629E338AA1BC058A9EE48EAA0B88F88D8BC88CC2BAF
          BCB2FAAAABAEBAACB1B1F107C57D52A9747AC992E77FBF74E9D2D5C071228BFB
          802DD5EAC550A5DE73F562555D5F5B3B3A70A273A4F545656C67D7074F49CF19
          832AA5811ACFF3266ED9B265E56DB7DD760BC0BBEFBEBB73EEDCC75F3C74E8E0
          0E22AB6789969E9C0F7960F8DED413BDBC1B3979F2E4EBF7EFDFFFAFF9F3E72F
          06AE006A812A2EF0ED645F2BD9034345BE7274F3442B88CED88A21449892E619
          2E018509F2FF5029FEF34759C71F6E01C38DFF01424B6EBBFE9A84DD00000000
          49454E44AE426082}
        TabOrder = 0
        Version = '1.7.1.0'
        OnClick = BtnAddClick
      end
      object BtnDel: TAdvSmoothButton
        Left = 72
        Top = 8
        Width = 57
        Height = 57
        Cursor = crHandPoint
        Status.Appearance.Fill.ColorMirror = clNone
        Status.Appearance.Fill.ColorMirrorTo = clNone
        Status.Appearance.Fill.BorderColor = clNone
        Status.Appearance.Fill.Rounding = 0
        Status.Appearance.Fill.ShadowOffset = 0
        Status.Appearance.Fill.Glow = gmNone
        Status.Appearance.Font.Charset = DEFAULT_CHARSET
        Status.Appearance.Font.Color = clWindowText
        Status.Appearance.Font.Height = -11
        Status.Appearance.Font.Name = 'Tahoma'
        Status.Appearance.Font.Style = []
        Color = clRed
        Picture.Data = {
          89504E470D0A1A0A0000000D49484452000000300000003008060000005702F9
          87000009ED694343504943432050726F66696C650000789CADD6675453D91607
          F0FFBD29840442EF2D20DD50A44A6F8A0D184414B0022134291182287650B0A1
          6057B02B76059551C78A0A228CA23411512C2038221D0B82791F8265D69B59EF
          CBDB9FF6D96BDDB3CEF9ED7DD73A8094629840104702884F1026054CF0E40487
          CCE448D4810A354803B00FE3250B3CFCFD7DF0AFF1B11E0400D4988509047189
          47A3AB119797A992E3C2E99FABFBF8DFBF0300B0938243660204178062943877
          07A0182ECE030128A60A0542808806A0C88B0E8B0088A500B84981015E00711C
          003B4A9C5F06C00E17E7E500D80B79514280680028F20911310900B503A0BB46
          F09379008B0B605E44322F1E606D0460191F9F1801B0AE0130E609928400AB05
          805970C84C8EF8C8E191807508401EFF599B2F051469028A353F6B2611804601
          70F5C4CF5A5F00080084725572A4B515008090F204682F44A23E4340620B309C
          2B127D3D24120D1F06284DC0AD385E4AD2C2112F827800FCAFB5F8CE23412100
          022495CE906449B165E4E415949455D53434B575387AA3F40D8D8C4D4773CD2D
          2CC758DBD8DAD98F75747276717573F7F0F41A37DE7BC2C44993A7F8F8FAFDE6
          3F352070FA8CA0E09099B3E6CC9D171A16CE8B888C8A8E899D1F179F20589094
          2C4C5998BA286DC9D265CB57AC5C959EB126336BEDBAF51B36666FCAC9DDB275
          DBF61D3B77EDDE9397BF77FF8183870E1F395A70ECF88993A74E9F397BAEB0A8
          E8FC858BC5BF5FBA7CE58FABD7AE5FBF71F356C9ED3B77EF9696DD2BBF5F5151
          F9E7838755558F1E57D7D4D4D6D5D53F696878DAD8F8ACA9E9F98B17CD2F5FBE
          7AFDFA4D4B4BEBDBB6B6F677EFFE7AFFBEE34367675777774F6F5F5FFFC0C0C7
          4F9F3F7F191CFC3A3434FCED9B0824952E21C99492969195575054565153D7D4
          D2E6E8EAE91B181A9B9872CDCC2D2CADAC6D6CEDC63AFC1BC0B41180D92300FC
          EF00893F0016FF0058BD26336BEDFA0D1BB3376DFE45207FEFBE7F101801100B
          8801EEFC0DE0D1E3C7D535B5B575F5FF08D0FA03A0430CD0D3D3DBD7DF3FF0F1
          E3A7CF5FBEFCBC3F854667483259D26C195979054525155535750D4D6D1D8EAE
          DE287D03236313D3D15C33730BCB3156D63636B676F6631D1C9D9C47247EA510
          0FC3778C59B3E7CC9D171A1A16CE8BF8E191F00B48DADF45D6FD42F27D26BE93
          FC9389986464284ACBEE9597DFFF95A4AEFE89D8E3F98BE697AF5EBF69697DDB
          D6FEEEAFF71D1F3ABBBA7B7AFBFA073E7EFE32F87568F89B0810FFFB0040B703
          0E2700339840E021607B3160E404A87401FED240A003C8646B909191205598A0
          10000980000574484206CAD08129EC300E81E02315EBB10F175189167C23D409
          7B623A914C6C258A89A7C437D280F4251792FBC94AF20BC5841242D940B949E9
          A772A911D4BDD4A734555A106D37AD89AE478FA65FA08B247C24F64874303C18
          BB18BD927E9267986CE6026603CB8B5528A52DB5499A944E931E6027B3FB6452
          65866533E5E4E40ECADBC85728842B7C53DCADA4AF744AD94AF99ACA04951AD5
          70D57EB575EA5AEA17357C345A359769A968156BFB6B77EAE4706C388DBA197A
          A3F5AA472DD5B7D06F32D868E862D86974D038C8846D526A9A3EDA6BF430F7BA
          D90A730F0B9A45A5E5B63173AC8CAC7AAD6FDAE4D886DBD9DAB3EC5F8FBDE2B0
          D991EFE4E2ACE5FCCDA5D9F586DB01F70C8F48CF295ED6E338E365C70F79774F
          A89F786FD2EDC925536EFB94F956FA3DFAADCEBF69EABB80AF8172D38D663807
          05060B42B2679E9955335B34D762DEBCD09CB0321E19E1C65F1279359A12E31F
          BB777E77FCE4843C0116F092CA849629FB53E516AD4D632C59BE7470F9CA95CC
          555B3374565FCAF4C96A5EB76483D6C6924DC19B45B9A7B7CEDA2EB1E3CCAE5D
          7B8AF25FEF973DE87C5870F4D8B1FA9392A7279DCD2E2C3D2F2AF6BA947EA5F2
          9AEC8DA05B476EF7977ADCCBBDFFF24F87871B1EBDA9B1ADDBF2A4B731A0E972
          B3DAABB4372FDEFAB797BCB7FE50D06DD49B37A0F469D7A0EED05391E847FF99
          90810A74C18503262204B1588A1C14E01AEAD045300963C29B88205613054405
          D1452A93AE6434B985BC4176503429BE9415940B94762A871A4CDD427D4863D3
          FC689B69B5740D7A38FD34FDB384B7C43689368633631BA353728AE409268B99
          C0AC6779B0CE4A6949654B13D28BA5FBD9C9EC3E99853243B26BE4E4E40EFCCF
          EEFB6AB46A2ED752D12AD69EAADDADB38563C779AE9BA967A1F76454BABE9D7E
          ABC10EC389865F8DCE19479AE898349AEE1E1DC255E23E333B68CEB7E05A7CB4
          BC3D26C76AAEB5990D6C9ED89EB4CBB40F1FEBEAA0EEF0D1B1D6E977E77C970C
          D758B70077270F234F792F78F58EEB19FFCABB69C283897727954C2E9952E273
          C7B7DCAFF2B72AFFDAA9CD019D81C47485190641F6C1FE21D133D3671D985D3A
          A76B9E46A87B5874F82E5E3D9F15E91295167D3D16F3C7C7E5C4BF483417A42F
          6848B612E6A6F4A7862CBA9566BA64FF3285E5D92B99ABB23228AB5765B2B2F2
          D619AFBFBCD12FFBFDE60DB9465B4AB6F17628EE7CBEFB493E7D9FCD01FEA1DD
          471E1CA39C703C157FE6F4B9B6F3DC8B29BF175FFE72D5F9FAEA9B8F6E6BDD0D
          2B2B2A1FAAF47B905FF5A1DAB37667FDDBA7F6CF729EB7BE747BBDA3E5439BEF
          BBFDEFBF74CEE8BEDEA737B0F653D7E09CA1EE91FE93604116CAE0C01C2EF043
          3852B1090528C10B0C13DA843B1141AC238A88269241DA9151E44EB29242529C
          282994224A37D58A2AA4FE41A3D0FC6879B4F77457FA367A87C40489A30C3A23
          96512DE92A7986A9C3DCC19265654B494B6D9656923EC4B66697C9CC91F92CBB
          5DCE4EAE493E4BC14EA15D315FC94BA95979AD8AB94A83EA1A353BB576F57C8D
          699A4CCD5B5A8BB56DB4BB750A39C9BA8E7A14BD7BA372F5430DCC0D860D2B8D
          F28C134C3C4D554D7B4657720BCC32CC432DDC2C3963A863DAAC2AAC0B6DF6D8
          A6DBC5DBCF1E3BD9C1DE51CF49C699E23CE8D2EDDAE2D6E05EE351EE59E2756B
          5CE9F852EFB2097726DE9D5439B9664A934FBB6FBF9FC89F395525C0649A5B60
          D0F484196B82F6065F09699C393C5B678EDBDCB07959A185614D3C46842D9F1F
          B92BAA2A86113B7E7E465C49BC28D15590BEE07EB2823034A528955C14B8F8E4
          127269C8B28B2BD456A6AD6AC8F05C7D2E53236BF5DAEEF5BC0DD5D9DE9B6EE6
          38E65ED9EAB0EDEA0ED79DA5BB67ECE9C9DFBACF74FF83838987E58F5C2D883C
          CE3A51782AE18CCED98785CBCF5B5FE82A3E7D29E68AE91F8DD7F26E04DD522C
          A9BDB3BD74FA3DA5F29A8A4D7F4E79C8AC2A7BBCA8C6AAB6BDFE60437023FBD9
          8DE7F39BD55F56BC16B6A8B6DE688B7DC7F8EB5087F787975D4B7A947A4FF43B
          0C547C9AF5B96370ED90EA70A3480488DF8B00005A8C6F180FFFE7888F4BF9BE
          2709408A9F307D1A0006006381D03FF07B8E18F8220C3CF13B1500E8B240BE11
          005CF64DFAAF7D85FC454200F04A142C4E8A898A16723C0482383EC72B315E90
          22E4277139931278E65C8E95A5A52D00FC078F08914C38CF9BB0000007BF4944
          41546881D59A6F6C14C719879FD9BDDD3BDFE1738C0BB8C418150A2A10858A48
          4DD312144195424B252895A048AE8450D30FA9402A2E84AAFD12A4A42A427C80
          9604AAA882242851822A441A44858B88104D552902940A5780EBF8303136E0B3
          CFF6DDEDCCBCFDB067628CFF9CE10EB73F6974F6DECDCDEF79E79DD9D9995322
          C2FFB39C7237A0945200353535C975EBD6CD1B7AAD241291B214400DFEBD72E5
          CA6FA652A9BF8B48E7F2E5CB9714DE774AD24E39CD2793C9A9870F1FFE9D880C
          4841D7AF5FFFB4BEBEFE2BC321FF2700861ADABC79F3F7DADADA2EC9083A7DFA
          F449A09A30851F0AA2E4E6EBEBEBBF7CE2C4898322A247323FA8A3478F1E00A2
          80FB301025330E385BB66CD9D8DDDDDD3296F1A1DAB163C72F01F530E3A124E6
          172D5A34B7A9A9E9DD628D0F516EC3860D3F1A0CC0640078BB76EDFA592E97EB
          7800F32222924EA76F2C59B2E4A907857860F34B972E7DF2E2C58B271FD4F850
          353737FFB3AEAEEEF1423A4D683C3C48AEC7F7EDDBB7330882EE52981FD4C993
          27DF072A27DA0B451B1711D6AC59B3B4B5B5F5E3521A1FAAFDFBF7EF06BC8940
          14653E994C4E7DEBADB7768B48B65CE607B575EBD69FCA04C6C3B851DFB469D3
          AA8E8E8E4FCB6D7C50D96CB67BD5AA55CB8B8518D5FCC2850B6B4F9C38F1BA8C
          73432A87DADBDB9BE7CC99334F64FCE5C68817B76DDBB62193C9FCE7511B1FAA
          73E7CEFDB5AAAAAA7A42003367CEACB970E1C2FB93657AB80E1D3AF4FBF106F5
          7D00EDEDED9F4C9AE311D4D8D8F8A28C311EEECBFDC58B177FA3ABABEBC6A439
          1E26AD7566C58A15DF915120EE010022407CEDDAB59B8C31B949F47D8FDADADA
          FE35DA9DFABE19088801D5DBB76FDF3599A64544ACB51204E124B87BF79E9765
          845969C46914A800661E3C78F0E8247917638C64B339E9EDED934C262BCDCD57
          FF1D8FC76BC7052840B840C2F7FD0567CF9E3DFFA8CD6B6DA4BF3F2BE974463A
          3BBBE5FAF54E696FBF25CF3EFBDC7765582F8CB82B212206C8E7F3F9B6868686
          9DA954EAB3D136054A2D6B8520D00481269BCD93C964E8EABA452E9767C992A7
          9E2CF8BBBB1734EAB68A880440AEB5B5F5938686865FF5F7F7671E817F8C3104
          81269FD7F4F5F5D3D57587DEDE0CD3A7D7E079DE8CE19F1F6F5F4803B93367CE
          7CD8D8D8F84A792C7F2111C1188331966C36473ADD4B34EAB170E13CE2718F5C
          2E7F5F9D31010A29990532070E1C78FD953D7BFE502EF385F6B03684C8E7F3D4
          D5CDE08927E6535939056B2197CB6687D7890CFD4729A5DE85641C9C2A205D05
          6FA7613EB80AFC377636BEB16C4EFDD7977EFF07DF320303A0D490E2000AE5BA
          28DFC76673581DE0259313001884B068AD514AA194220834AEEB1004FABE34BE
          07E05D487A4A354522CCD23182E951F8753D383E381E6445C4BEFC938AB643D3
          106B211283CAA990988AAAAC812953314418487D4EE7B97F109DF7359EFEE083
          A20106210AF72BAE5E6DC5751D62B1385A5BFAFBFBD36302006E3C426D45424D
          8BC5215A012A067E143C1F929EC25139A4B70D04C47541F5626D06DB7383DC9D
          347D9F7D4E5F478E200DD19A69A1A3096C850E46DDF322884073730B0B16CCC7
          1845676757D798000188F6417BA0DD306F5C400B280B62C075148EA340042B20
          993E82DB3DE43339F203423E009B009B071B53088A62ED2B157EB7E338789E47
          2291E0D6ADDBDCB8D1492231C55EBB76F9E6783D8071040B180BC680CE17F6FF
          0CE082B82A0CA828C41AACE923D0A04D086A6CF8AA01EB50B4F94100D77570DD
          B0071289385A6B7A7BFB00E796D6FAB6524A0DBD0FDC0390062AE6CE47AA2A11
          C7862B712F34AE2240C4415C07719C302D4450C6E069133AD6201A6C003A93C5
          56D720D6A05CB74804C1715C2291089188251AF549262B31065A5AAEDD4CA552
          3709633232C025E0CAA56B54390E950AA67890F00BC58398A7707D0FA21E0C9A
          3206F2013617900D844C00FD79E84EE7A98E548353DC114438038571F1BC08C6
          58AC1544201E9FC2F9F3E72E037786D7BB07200F2A6934BE01DF81A882980B15
          1612163C2702BE0F5117BC0815AE43446BC4318831A47B34413FE4F3E05A7002
          5D64E4191A541C47E1FBA1B56432C9CD9B9DE977DE79F36DC08C09D00399E9F0
          A2030917ACA7C20FF80A3C075C4F811F81A8871BF3F9A86B806BDD03916C7F5F
          D4AB9EFED5C6D77EFBF3F9D1786220A7C9071AFF4B3328E630265C987DB1B0B4
          56F07D9F58CCE7F8F1BFFC6DFBF65FEC6A6E6EFE987038EA112A3F7C011EDBB2
          FDA5093F43581BAEFB8DB112044682C0888848474767E7E6CD2FFC06980DC401
          9FB19EC81ED2BC03248059FBF7EF3F32510063AC686DEE5E7BEFBD631FCE9E3D
          FB39E031C2679351CF104AD9032E30C5F7FD054D4D4D1F150B608C156BAD8888
          A452ED37366E6CD806D41502E28F66BCE40005880890ACADAD5D76E5CA956BE3
          47DF1620C41E3972E4CF757575CB0A518F8F15F5720228C263A3EA679E79E6C7
          3D3D3D3DE341B4B4B4A4D6ACF9E1566016902CD42FCDE6EE034238841B03D3D6
          AF5FFFD268C68D31E6D0A13FBE535D5DFD6D606A216522C544BDAC0043201240
          DDABAFBEFADA70F3972F375F79FEF9E75F001E2F447DC41966D2000A102EE181
          C5DC63C78E1D1711D15A67F7EEDDFBA7CACACAA7098F598BCEF5470E5080F080
          447D7DFDC253A74EBDB97AF5EA8D402D5035D15C1FAD0C1E1B954585DF44B885
          9492C2AB0202C04A091A2F2BC0DD4686AD274A61FCEE773F0A8072EABF1CE628
          CB6260B7D60000000049454E44AE426082}
        TabOrder = 1
        Version = '1.7.1.0'
        OnClick = BtnDelClick
      end
    end
    object SalesTxtNama: TRzEdit
      Left = 160
      Top = 88
      Width = 233
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object SalesTxtNonEfektif: TRzDateTimeEdit
      Left = 408
      Top = 272
      Width = 153
      Height = 24
      EditType = etDate
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object SalesTxtKode: TRzEdit
      Left = 160
      Top = 60
      Width = 121
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object SalesTxtAlamat: TRzMemo
      Left = 160
      Top = 116
      Width = 233
      Height = 89
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object SalesTxtKota: TRzEdit
      Left = 160
      Top = 210
      Width = 233
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object SalesTxttglmasuk: TRzDateTimeEdit
      Left = 528
      Top = 60
      Width = 153
      Height = 24
      EditType = etDate
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object SalesTxtTgllahir: TRzDateTimeEdit
      Left = 408
      Top = 240
      Width = 153
      Height = 24
      EditType = etDate
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object SalesTxttempatlahir: TRzEdit
      Left = 160
      Top = 239
      Width = 233
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object SalesTxtnoktp: TRzEdit
      Left = 528
      Top = 88
      Width = 249
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
  end
end
