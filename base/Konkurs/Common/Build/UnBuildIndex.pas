// Идентификаторы 3D- моделей
unit UnBuildIndex;

interface

var
  PATR_PUSHKA: integer;
  PATR_PKT: integer;
  PATR_PTUR: integer;
  PATR_PTUR2: integer;
  PATR_PTUR3: integer;
  VZRYV_Pushka_1: integer;
  VZRYV_Pushka_2: integer;
  VZRYV_Pushka_3: integer;
  VZRYV_Pushka_4: integer;
  DYM_2: integer;
  VSPYSH: integer;
  UKAZ_AZ_TANK: integer;
  UKAZ_AZ_BASH: integer;
  UKAZ_AZ_STRE: integer;

  ZAVESA: integer;
  FIRE: integer;  // +12

  // Атмосфера
  OBLAKO: integer;
  GORIZONT: integer;
  GORIZONT2: integer;
  ZVEZDA: integer;
  NEBO: integer;
  GORIZONT_GORA:array[0..31] of  integer; //+32/
  // Имя списка под которым ориентиры воспроизводятся
//  ORIENTIR: integer;
  //Ориентиры, которые раасставляет преподаватель
  MIN_NUM_ORIENTIR:array[0..12] of  integer; //+ 29

  // Спрайты           //До 300
  SPRITE: integer;
  SPRITE_PYL: integer;
  SPRITE_VSP: integer;      // 14
//  415
//==============Спрайтовая анимация========================
  SPHERA: integer;
  SOLDAT: integer;          // 100


implementation

end.
