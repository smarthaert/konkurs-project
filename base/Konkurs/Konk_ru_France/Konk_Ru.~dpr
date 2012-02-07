program Konk_ru;

uses
  Forms,
  Main in 'Main.pas' {Form1},                                     //Главное меню управления тренажером
  UnModel in 'UnModel.pas',                                       //Описание моделей
  UnVybor in 'UnVybor.pas'      {OKBottomDlg1},                   //Выбор упражнений
  UnEdit in 'UnEdit.pas'        {OKBottomDlg4},                   //Редактор наземной и воздушной обстановки
  UnEd_Tak in 'UnEd_Tak.pas'    {Edit_Tak},                       //Редактор с элементами тактики
  UnPoint in 'Unpoint.pas'      {OKBottomDlg7},                   //Формирование информации о перемещении стрелка
  UnBoepr in 'Unboepr.pas'      {OKBottomDlg5},                   //ввод количества боеприпасов, выстрелов
  UnColor in 'UnColor.pas'      {ChangColor},                     //Ввод цвета
  UnTarget in 'UnTarget.pas'    {OKBottomDlg6},                   //Формирование плоских мишеней
  UnTarTak in 'UnTarTak.pas'    {Tar_Tak},                        //Тактические мишени
  UnEkip in 'Unekip.pas'        {OKBottomDlg3},                   //Ввод данных об обучаемых
  UnPogoda in 'Unpogoda.pas'    {OKBottomDlg2},                   //Ввод данных о погодных условиях
  UnVedom in 'Unvedom.pas'      {Vedom},                          //Ведомость тренировки
  UnVed_Ta in 'UnVed_Ta.pas'    {FVed_Ta},                        //Ведомость
  UnClose in 'Unclose.pas'      {OKBottomDlg},                    //Завершение работы
  UnLVS in 'UnLVS.pas'          {LVS},                            //Обмен по локальной вычислительной сети
  UnBuildSetka in '..\Common\Build\UnBuildSetka.pas',             //
  UnBuildServer in '..\Common\Build\UnBuildServer.pas',           //
  UnBuildKoordObject in '..\Common\Build\UnBuildKoordObject.pas', //
  UnOther in '..\Common\Konkurs\UnOther.pas',                     //
  UnGeom in '..\Common\UnGeom.pas',                               //
  UnTask in 'UnTask.pas',                                         //
  UnOcenka in 'UnOcenka.pas',                                     //Формирование оценки по результатам стрельбы
  UnReadIni in 'UnReadIni.pas',                                   //Чтение из ини файла и формирование констант для дальнейшей работы
  UnOtkaz in 'UnOtkaz.pas' {Otkaz},                               //Задание таблицы отказов комплекса
  UnLoadLang in 'UnLoadLang.pas';                                 //Формирование языковой поддержки

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TLVS, LVS);
  Application.CreateForm(TOtkaz, Otkaz);
  Application.Run;
end.
