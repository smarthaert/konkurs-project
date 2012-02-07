unit UnOrgRM;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Tabnotbk, Dll2, Main, Spin, CheckLst;
Type
  TFormOrg = class(TForm)
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Panel1: TPanel;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label93: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label186: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    Label189: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    Label195: TLabel;
    Label196: TLabel;
    Label263: TLabel;
    Label266: TLabel;
    Edit3: TEdit;
    Edit7: TEdit;
    Panel6: TPanel;
    Label8: TLabel;
    Label17: TLabel;
    Label25: TLabel;
    Label63: TLabel;
    Label70: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label112: TLabel;
    Label158: TLabel;
    Label166: TLabel;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label175: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    Label241: TLabel;
    Label244: TLabel;
    Label245: TLabel;
    Label246: TLabel;
    Label259: TLabel;
    Label260: TLabel;
    Label261: TLabel;
    Label262: TLabel;
    Label268: TLabel;
    Label269: TLabel;
    Label270: TLabel;
    Label271: TLabel;
    Label272: TLabel;
    Label273: TLabel;
    Label274: TLabel;
    Label275: TLabel;
    Label276: TLabel;
    Label277: TLabel;
    Label278: TLabel;
    Label281: TLabel;
    Label282: TLabel;
    Label284: TLabel;
    Label285: TLabel;
    Label286: TLabel;
    Label287: TLabel;
    Label288: TLabel;
    Label289: TLabel;
    Label111: TLabel;
    Label291: TLabel;
    Label292: TLabel;
    Label293: TLabel;
    Panel3: TPanel;
    Label18: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    Bevel3: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel6: TBevel;
    Label6: TLabel;
    Bevel7: TBevel;
    Label9: TLabel;
    Bevel8: TBevel;
    Label10: TLabel;
    Bevel9: TBevel;
    Label11: TLabel;
    Bevel10: TBevel;
    Label19: TLabel;
    Bevel11: TBevel;
    Label20: TLabel;
    Bevel12: TBevel;
    Label21: TLabel;
    Label22: TLabel;
    Bevel13: TBevel;
    Bevel14: TBevel;
    Label23: TLabel;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    Timer1: TTimer;
    ProgressBar21: TProgressBar;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    ProgressBar4: TProgressBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Otobr_Panel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    num: word;
    { Public declarations }
  end;

var
  FormOrg: TFormOrg;
implementation

{$R *.DFM}

procedure TFormOrg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: Close;
    VK_F1:begin
      if num=1 then exit;
      Kommand[1]:=ZADACHA;
      Kommand[2]:=ZAD_PROSMOTR_ORG_UPR_OTKL;
      Form1.Trans_kom(num);
      Form1.Trans_kom(num+3);
      Form1.Trans_kom(num+6);
      num:=1;
      Kommand[1]:=ZADACHA;
      Kommand[2]:=ZAD_PROSMOTR_ORG_UPR;
      Form1.Trans_kom(num);
      Form1.Trans_kom(num+3);
      Form1.Trans_kom(num+6);
    end;
    VK_F2:begin
      if num=2 then exit;
      Kommand[1]:=ZADACHA;
      Kommand[2]:=ZAD_PROSMOTR_ORG_UPR_OTKL;
      Form1.Trans_kom(num);
      Form1.Trans_kom(num+3);
      Form1.Trans_kom(num+6);
      num:=2;
      Kommand[1]:=ZADACHA;
      Kommand[2]:=ZAD_PROSMOTR_ORG_UPR;
      Form1.Trans_kom(num);
      Form1.Trans_kom(num+3);
      Form1.Trans_kom(num+6);
    end;
    VK_F3:begin
      if num=3 then exit;
      Kommand[1]:=ZADACHA;
      Kommand[2]:=ZAD_PROSMOTR_ORG_UPR_OTKL;
      Form1.Trans_kom(num);
      Form1.Trans_kom(num+3);
      Form1.Trans_kom(num+6);
      num:=3;
      Kommand[1]:=ZADACHA;
      Kommand[2]:=ZAD_PROSMOTR_ORG_UPR;
      Form1.Trans_kom(num);
      Form1.Trans_kom(num+3);
      Form1.Trans_kom(num+6);
    end;
  end;
  StaticText1.Caption:='Экипаж '+ inttostr(num);
end;
procedure TFormOrg.FormCreate(Sender: TObject);
begin
  num:=Num_BMP;
  StaticText1.Caption:='Экипаж '+ inttostr(num);
end;

procedure TFormOrg.Otobr_Panel;
var r:real;
begin
    // Командир
    if Org_Upr_Rm[num].kom_imp[0][0] and $02 = $02 then label18.color:=$00FFFFB0
                                    else label18.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[0][0] and $08 = $08 then label113.color:=$00FFFFB0
                                    else label113.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[0][0] and $10 = $10 then label114.color:=$00FFFFB0
                                    else label114.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[0][0] and $20 = $20 then label115.color:=$00FFFFB0
                                    else label115.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[0][0] and $40 = $40 then label116.color:=$00FFFFB0
                                    else label116.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[0][0] and $80 = $80 then label117.color:=$00FFFFB0
                                    else label117.color:=$00CFC6FF;

           //1
    if Org_Upr_Rm[num].kom_imp[1][0] and $01 = $01 then label118.color:=$00FFFFB0
                                    else label118.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[1][0] and $40 = $40 then label124.color:=$00FFFFB0
                                    else label124.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[1][0] and $80 = $80 then label125.color:=$00FFFFB0
                                    else label125.color:=$00CFC6FF;
    //2
    if Org_Upr_Rm[num].kom_imp[2][0] and $01 = $01 then label126.color:=$00FFFFB0
                                    else label126.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[2][0] and $40 = $40 then label132.color:=$00FFFFB0
                                    else label132.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[2][0] and $80 = $80 then label133.color:=$00FFFFB0
                                    else label133.color:=$00CFC6FF;
    //3
    if Org_Upr_Rm[num].kom_imp[3][0] and $01 = $01 then label134.color:=$00FFFFB0
                                    else label134.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[3][0] and $02 = $02 then label135.color:=$00FFFFB0
                                    else label135.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[3][0] and $04 = $04 then label136.color:=$00FFFFB0
                                    else label136.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[3][0] and $08 = $08 then label137.color:=$00FFFFB0
                                    else label137.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[3][0] and $10 = $10 then label138.color:=$00FFFFB0
                                    else label138.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[3][0] and $20 = $20 then label139.color:=$00FFFFB0
                                    else label139.color:=$00CFC6FF;
    //4
    if Org_Upr_Rm[num].kom_imp[4][0] and $01 = $01 then label142.color:=$00FFFFB0
                                    else label142.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[4][0] and $02 = $02 then label143.color:=$00FFFFB0
                                    else label143.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[4][0] and $01 = $01 then label144.color:=$00FFFFB0
                                    else label144.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[4][0] and $02 = $02 then label145.color:=$00FFFFB0
                                    else label145.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[4][0] and $20 = $20 then label147.color:=$00FFFFB0
                                    else label147.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[4][0] and $40 = $40 then label148.color:=$00FFFFB0
                                    else label148.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[4][0] and $80 = $80 then label149.color:=$00FFFFB0
                                    else label149.color:=$00CFC6FF;
    //5
    if Org_Upr_Rm[num].kom_imp[5][0] and $0002 = $0002 then label159.color:=$00FFFFB0
                                    else label159.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[5][0] and $0004 = $0004 then label160.color:=$00FFFFB0
                                    else label160.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[5][0] and $0008 = $0008 then label161.color:=$00FFFFB0
                                    else label161.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[5][0] and $0020 = $0020 then label163.color:=$00FFFFB0
                                    else label163.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[5][0] and $0040 = $0040 then label164.color:=$00FFFFB0
                                    else label164.color:=$00CFC6FF;
    if Org_Upr_Rm[num].kom_imp[5][0] and $0080 = $0080 then label165.color:=$00FFFFB0
                                    else label165.color:=$00CFC6FF;
    //6
    // Аналог
//    edit5.Text:=inttostr(Org_Upr_Rm[num].kom_anal[0] div 100);
//    edit8.Text:=inttostr(Org_Upr_Rm[num].kom_anal[1] div 10);
    // Наводчик
    //0
    if Org_Upr_Rm[num].nav_imp[0][0] and $0040 = $0040 then label7.color:=$00FFFFB0
                                    else label7.color:=$00CFC6FF;

    if Org_Upr_Rm[num].nav_imp[0][1] and $01 = $01 then label49.color:=$00FFFFB0
                                    else label49.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[0][1] and $02 = $02 then label50.color:=$00FFFFB0
                                    else label50.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[0][1] and $04 = $04 then label51.color:=$00FFFFB0
                                    else label51.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[0][1] and $08 = $08 then label52.color:=$00FFFFB0
                                    else label52.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[0][1] and $10 = $10 then label53.color:=$00FFFFB0
                                    else label53.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[0][1] and $20 = $20 then label54.color:=$00FFFFB0
                                    else label54.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[0][1] and $40 = $40 then label55.color:=$00FFFFB0
                                    else label55.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[0][1] and $80 = $80 then label56.color:=$00FFFFB0
                                    else label56.color:=$00CFC6FF;
    //1
    if Org_Upr_Rm[num].nav_imp[1][0] and $0008 = $0008 then label12.color:=$00FFFFB0
                                    else label12.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][0] and $0010 = $0010 then label13.color:=$00FFFFB0
                                    else label13.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][0] and $0020 = $0020 then label14.color:=$00FFFFB0
                                    else label14.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][0] and $0040 = $0040 then label15.color:=$00FFFFB0
                                    else label15.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][0] and $0080 = $0080 then label16.color:=$00FFFFB0
                                    else label16.color:=$00CFC6FF;

    if Org_Upr_Rm[num].nav_imp[1][1] and $01 = $01 then label57.color:=$00FFFFB0
                                    else label57.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][1] and $02 = $02 then label58.color:=$00FFFFB0
                                    else label58.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][1] and $04 = $04 then label59.color:=$00FFFFB0
                                    else label59.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][1] and $08 = $08 then label60.color:=$00FFFFB0
                                    else label60.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][1] and $10 = $10 then label61.color:=$00FFFFB0
                                    else label61.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][1] and $20 = $20 then label62.color:=$00FFFFB0
                                    else label62.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[1][1] and $80 = $80 then label64.color:=$00FFFFB0
                                    else label64.color:=$00CFC6FF;
     //2
    if Org_Upr_Rm[num].nav_imp[2][0] and $0002 = $0002 then label26.color:=$00FFFFB0
                                    else label26.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][0] and $0004 = $0004 then label27.color:=$00FFFFB0
                                    else label27.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][0] and $0008 = $0008 then label28.color:=$00FFFFB0
                                    else label28.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][0] and $0010 = $0010 then label29.color:=$00FFFFB0
                                    else label29.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][0] and $0020 = $0020 then label30.color:=$00FFFFB0
                                    else label30.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][0] and $0040 = $0040 then label31.color:=$00FFFFB0
                                    else label31.color:=$00CFC6FF;

    if Org_Upr_Rm[num].nav_imp[2][1] and $01 = $01 then label65.color:=$00FFFFB0
                                    else label65.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][1] and $02 = $02 then label66.color:=$00FFFFB0
                                    else label66.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][1] and $04 = $04 then label67.color:=$00FFFFB0
                                    else label67.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][1] and $08 = $08 then label68.color:=$00FFFFB0
                                    else label68.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][1] and $10 = $10 then label69.color:=$00FFFFB0
                                    else label69.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][1] and $40 = $40 then label71.color:=$00FFFFB0
                                    else label71.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[2][1] and $80 = $80 then label72.color:=$00FFFFB0
                                    else label72.color:=$00CFC6FF;
    //3
    if Org_Upr_Rm[num].nav_imp[3][0] and $0040 = $0040 then label39.color:=$00FFFFB0
                                    else label39.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[3][0] and $0080 = $0080 then label40.color:=$00FFFFB0
                                    else label40.color:=$00CFC6FF;


    if Org_Upr_Rm[num].nav_imp[3][1] and $01 = $01 then label95.color:=$00FFFFB0
                                    else label95.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[3][1] and $02 = $02 then label96.color:=$00FFFFB0
                                    else label96.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[3][1] and $04 = $04 then label97.color:=$00FFFFB0
                                    else label97.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[3][1] and $08 = $08 then label98.color:=$00FFFFB0
                                    else label98.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[3][1] and $10 = $10 then label99.color:=$00FFFFB0
                                    else label99.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[3][1] and $20 = $20 then label100.color:=$00FFFFB0
                                    else label100.color:=$00CFC6FF;
    //4
    if Org_Upr_Rm[num].nav_imp[4][0] and $0001 = $0001 then label41.color:=$00FFFFB0
                                    else label41.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][0] and $0002 = $0002 then label42.color:=$00FFFFB0
                                    else label42.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][0] and $0004 = $0004 then label43.color:=$00FFFFB0
                                    else label43.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][0] and $0008 = $0008 then label44.color:=$00FFFFB0
                                    else label44.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][0] and $0020 = $0020 then label46.color:=$00FFFFB0
                                    else label46.color:=$00CFC6FF;

    if Org_Upr_Rm[num].nav_imp[4][1] and $02 = $02 then label104.color:=$00FFFFB0
                                    else label104.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][1] and $04 = $04 then label105.color:=$00FFFFB0
                                    else label105.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][1] and $08 = $08 then label106.color:=$00FFFFB0
                                    else label106.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][1] and $10 = $10 then label107.color:=$00FFFFB0
                                    else label107.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][1] and $20 = $20 then label108.color:=$00FFFFB0
                                    else label108.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][1] and $40 = $40 then label109.color:=$00FFFFB0
                                    else label109.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[4][1] and $80 = $80 then label110.color:=$00FFFFB0
                                    else label110.color:=$00CFC6FF;
    //5
    if Org_Upr_Rm[num].nav_imp[5][0] and $0040 = $0040 then label77.color:=$00FFFFB0
                                    else label77.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][0] and $0080 = $0080 then label78.color:=$00FFFFB0
                                    else label78.color:=$00CFC6FF;

    if Org_Upr_Rm[num].nav_imp[5][1] and $01 = $01 then label79.color:=$00FFFFB0
                                    else label79.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][1] and $02 = $02 then label80.color:=$00FFFFB0
                                    else label80.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][1] and $04 = $04 then label81.color:=$00FFFFB0
                                    else label81.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][1] and $08 = $08 then label82.color:=$00FFFFB0
                                    else label82.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][1] and $10 = $10 then label83.color:=$00FFFFB0
                                    else label83.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][1] and $20 = $20 then label84.color:=$00FFFFB0
                                    else label84.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][1] and $40 = $40 then label85.color:=$00FFFFB0
                                    else label85.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[5][1] and $80 = $80 then label86.color:=$00FFFFB0
                                    else label86.color:=$00CFC6FF;
    //6
    if Org_Upr_Rm[num].nav_imp[6][0] and $0040 = $0040 then label93.color:=$00FFFFB0
                                    else label93.color:=$00CFC6FF;

    if Org_Upr_Rm[num].nav_imp[6][1] and $01 = $01 then label75.color:=$00FFFFB0
                                    else label75.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[6][1] and $02 = $02 then label76.color:=$00FFFFB0
                                    else label76.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[6][1] and $08 = $08 then label176.color:=$00FFFFB0
                                    else label176.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[6][1] and $10 = $10 then label177.color:=$00FFFFB0
                                    else label177.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[6][1] and $20 = $20 then label186.color:=$00FFFFB0
                                    else label186.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[6][1] and $40 = $40 then label187.color:=$00FFFFB0
                                    else label187.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[6][1] and $80 = $80 then label188.color:=$00FFFFB0
                                    else label188.color:=$00CFC6FF;
    // 7
    if Org_Upr_Rm[num].nav_imp[7][0] and $01 = $01 then label189.color:=$00FFFFB0
                                    else label189.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[7][0] and $02 = $02 then label190.color:=$00FFFFB0
                                    else label190.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[7][0] and $04 = $04 then label191.color:=$00FFFFB0
                                    else label191.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[7][0] and $08 = $08 then label192.color:=$00FFFFB0
                                    else label192.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[7][0] and $10 = $10 then label193.color:=$00FFFFB0
                                    else label193.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[7][0] and $20 = $20 then label194.color:=$00FFFFB0
                                    else label194.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[7][0] and $40 = $40 then label195.color:=$00FFFFB0
                                    else label195.color:=$00CFC6FF;
    if Org_Upr_Rm[num].nav_imp[7][0] and $80 = $80 then label196.color:=$00FFFFB0
                                    else label196.color:=$00CFC6FF;
    r:=Org_Upr_Rm[num].nav_anal[2];
    edit3.Text:=inttostr(round(((r-2000)/2000*27-12)/100));
    edit7.Text:=inttostr(Org_Upr_Rm[num].nav_anal[5] div 100);
end;

procedure TFormOrg.Timer1Timer(Sender: TObject);
begin
  Otobr_Panel;
end;

procedure TFormOrg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
end;

end.

