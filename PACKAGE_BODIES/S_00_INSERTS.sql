--------------------------------------------------------
--  DDL for Package Body S_00_INSERTS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "SINTAGMA_U"."S_00_INSERTS" AS


PROCEDURE CLASSIF_ACTIVES IS
BEGIN

    	Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('OGIN','0005 - Organismes i governs internacionals');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PCAU','0010 - Presidents de Comunitats Autònomes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MECO','0015 - Mesa del Congreso de los Diputados');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MCDI','0016 - Mesa del Congrés dels Diputats i Diputades');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MESE','0020 - Mesa del Senado');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DICB','0025 - Diputats de Barcelona al Congrès amb domicili a BCN');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DICC','0026 - Diputats de Catalunya al Congrès');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('SEBA','0030 - Senadors per Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('SEPC','0035 - Senadors que represent. al Parlament de Cat. al Senat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('SCSE','0037 - Senadors catalans al Senat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DCPE','0040 - Diputats Catalans al Parlament Europeu');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PSAS','0045 - Primeres Autoritats Catalanes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AUTC','0050 - Autoritats Catalanes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PAPS','0055 - Presidents i Secretaris Grals. dels Partits Polítics');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MEPC','0060 - Mesa del Parlament de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PGPA','0065 - President i Portaveus dels G P -Parlament Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PDGP','0070 - Portaveus del Grups Parlamentaris');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DIPC','0075 - Diputats al Parlament de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CPM4','0076 - Càrrecs Politics  (Diputació, Generalitat, Parlament)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EXPP','0080 - Expresidents del Parlament de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CEGC','0085 - Consell Executiu de la Generalitat de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('SGGE','0090 - Secretaris Generals de la Generalitat de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EXGE','0100 - Expresidents Generalitat de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('REGI','0105 - Corporació Municipal de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CAAJ','0115 - Comissionats de l''Alcaldia - Ajuntament de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('GAAJ','0120 - Gerents dels Sectors d''Actuació - Ajunt. de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CSDI','0125 - Gerents de Districtes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('GEAJ','0130 - Orga.Autòn.(1)Empreses Mpals(2) i Empreses Mixtes(3)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CDAJ','0135 - Càrrecs Directius de l''Ajuntament de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CNAJ','0140 - Cossos Nacionals de l''Ajuntament de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CGTA','0145 - Caps Gab. Alcaldia, Tinents d''Alcalde i Regidors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CGAJ','0150 - Assessors Tècnics dels Regidors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CTDI','0155 - Consellers Tècnics dels Districtes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COCV','0160 - Consellers Districte de Ciutat Vella');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CODE','0165 - Consellers Districte de l''Eixample');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COSM','0170 - Consellers Districte de Sants-Montjuïc');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COLC','0175 - Consellers Districte de Les Corts');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COSG','0180 - Consellers Districte Sarrià-Sant Gervasi');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CODG','0185 - Consellers Districte de Gràcia');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COHG','0190 - Consellers Districte d''Horta-Guinardó');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CONB','0195 - Consellers Districte Nou Barris');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COSA','0200 - Consellers Districte de Sant Andreu');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COND','0205 - Consellers Districte Sant Martí');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('INGU','0210 - Intendents Guàrdia Urbana');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EXAL','0215 - Ex-Alcaldes de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EXRE','0220 - Ex-Regidors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ASCC','0225 - Associació Consell de Cent');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PDCA','0245 - Presidents de les Diputacions de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CGDI','0250 - Diputació de Barcelona-Presidenta i Diputats Àrees');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DPCA','0255 - Diputats president i coord. àrea Diputació de BCN');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DIPU','0260 - Diputats  - Diputació de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AES7','0265 - Alcaldes de les grans ciutats espanyoles');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ATLG','0270 - Alcaldes de les capitals de províncies catalanes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AEME','0275 - Alcaldes. Entitats Metropolitanes i Mancomunitat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ALCO','0280 - Alcaldes 2a. Corona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ACCA','0285 - Alcaldes Ajuntaments Capitals Comunitats Autònomes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ACOM','0290 - Alcaldes Ciutats Corredor Mediterrani');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('APCV','0291 - Alcaldes poblacions catalanes visitades per l''alcal');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FEMU','0295 - Federació de Municipis de Catalunya, Fed. Mun. España');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ASMU','0300 - Associació Catalana Municipis - President');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CCAB','0305- Cos Consular a Barcelona (CE=PRE.100)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CECC','0310 - Comitè Executiu del Cos Consular');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CSEG','0315 - Cossos de Seguretat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JLSB','0320 - Junta Local de Seguretat de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COCI','0322 - Consell de la Ciutat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('VCOM','0323 - Vicepresidents/tes Consells Municipals');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('REUN','0325 - Rectors Universitats Catalanes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AUBC','0327 - Autoritats Socials Barcelona en Comú');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MCBC','0328 - Membres Candidatura Barcelona en Comú');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('LCBC','0329 - Convidats Entitats Socials');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ENCU','0330 - Institucions Culturals');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('REAC','0335 - Reials Acadèmies');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ESCI','0340 - Escriptors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ESCU','0345 - Escultors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('HIST','0350 - Historiadors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PENC','0353 - PEN Català (Plataforma projecció intern. literatura C');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EDIT','0355 - Editors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PINT','0360 - Pintors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('GADA','0365 - Galeries d''Art');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DISS','0370 -  Dissenyadors');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COLE','0375 - Col.leccionistes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FOTO','0380 - Fotògrafs');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MUSE','0385 - Museus');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ICEB','0390 - Instituts Culturals Estrangers a Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('TCIE','0395 - Teatre, Cinema i Música');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MICO','0400 - Mitjans de Comunicació');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PUBL','0405 - Empresaris-agències publicitat i disseny');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('BTVCA','0406 - BTV  Consell Administració');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IEC','0415 - Institut d''estudis catalans (Consell permanent)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CDIC','0416 - Junta Directiva de l''Institut de Cultura de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JDAB','0420 - Junta Directiva Ateneu Barcelonès');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JDGE','0422 - GREMI EDITORS (JUNTA DIRECTIVA)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JUDIR','0425 - Junta Directiva d''Ateneus de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JDOC','0430 - Junta Directiva d''Òmnium Cultural');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CONCA','0435 - Consell Nacional de la Cultura i de les Arts (CoNCA)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('BIBL','0440 - Consorci de Biblioteques de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JDGL','0445 - Gremi de Llibreters de Catalunya (JUNTA DIRECTIVA)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IRLL','0450 - Institut Ramon Llull (JUNTA DIRECTIVA)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CAAL','0453 - Càrrecs Alcaldia Ajuntament de barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PCCI','0455 - Ple Consell Cultura ICUB  ');
		commit;
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AELC','0460 - Associació d''Escriptors en llengua Catalana');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CCLP','0462 - Comissió de la Lectura Pública');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ASEC','0463 -Associació d''Editors en Llengua Catalana (Junta Direc)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ACEC','0464 -  Associació Col·legial d''Escriptors de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JDBL','0465 - Junta directiva de les Bones Lletres');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('RMEB','0465 - Representants del Mon Empresarial');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AGEC','0469 - AGENTS ECONÒMICS DE LA CIUTAT');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('BANC','0470 - Entitats Financeres  Bancs (pre. 0)  Caixes (prel. 1)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('OROF','0471 - Organismes Oficials a Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AESB','0472 - Agents Económics i Serveis ');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ESNB','0473 - ESCOLES DE NEGOCIS DE BARCELONA');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('G16B','0475 - El G-16 de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ARQU','0480 - Arquitectes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CECB','0490 - Cambres de Comerç Estrangeres a Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PMWC','0491 - Patronato Mobile World Capital');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CMWC','0492 - COMISIÓ EXECUTIVA MOBILE WORLD CAPITAL');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('HOTE','0495 - Hotels');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PECB','0500  - Presidents Eixos Comercials de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EEBA','0505 - Empreses Estrangeres ubicades a Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('XAES','0510 - Xarxa d''Economia Solidaria');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ALER','0511-REUNIÓ ALCALDESSA-EMPRESES RENOVABLES (BCN  ACTIVA)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ALDO','0512-ESMORZAR  ALCALDESSA-DONES EMPRENADORES (BCN ACTIVA)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ALUN','0513-ESMORZAR ALCALDESSA-UNIVERSITATS');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ALEM','0514-ESMORZAR ALCALDESSA-EMPRESES');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IVAC','0515 - REUNIÓ TRACTAMENT IVA CULTURAL');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CPRO','0516 - CONSELL ASSESSOR DE PROMOCIÓ DE CIUTAT');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('RSCB','0525 - Representants de la Societat Civil de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('SIND','0530 - Sindicats i Agrupacions Empresarials');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ASVB','0531 - Associació de Veïns i Veïnes de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('GREM','0535  - Gremis');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JDGR','0538 - Junta directiva Consell de Gremis ');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COOF','0540 - Col.legis Oficials');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CRBA','0542 - Confessions Religioses a Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('SAFI','0545 - Presidents de Salons de Fira');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CGFI','0550 - Consell General de la Fira de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CETB','0551 - Turisme de Barcelona - Comitè Executiu');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CEFI','0555 - Consell d''Administració Fira de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CGTB','0560 - Turisme de Barcelona -Consell General');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('GOES','0001 - Govern Espanyol');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ENOC','0572 - Entitats de Nova Ciutadania');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FECR','0575 - Federacions Cases Regionals');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ENCI','0580 - Entitats Cíviques (0) Associació (1) Fundació (2)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ONGS','0581 - Federacions ONGS');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IDHC','0582 - Institut de Drets Humans de Catalunya');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('TESE','0585 - Tercer Sector');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ENME','0590 - Entitats Memòria Històrica');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CUIN','0590 - Restauradors Vips de BCN  (Cuiners)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FEDE','0595 - Federacions, clubs, entitats esportives i esportiste ');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AMCI','0600 - Mon  mèdic i científic');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ACCC','0602 - Associació Catalana de Comunicació Científica');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EMAG','0603 - AGÈNCIA EUROPEA DEL MEDICAMENT - COMITÈ SUPORT');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('TIRB','0604 - Trobada Innovació i Recerca Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AECB','0605 - Associació Esport Cultura Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MEOR','0610 - Medalles de la Ciutat en la Categoria d''Or');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('UFEC','0610 - Unió de Federacions Esportives Catalanes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MEHO','0615 - Medalles d''Honor de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MECV','0620 - Medalla d''Or Merit cívic');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MECI','0625 - Medalles d''Or al mèrit Científic');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MEAR','0630 - Medalles d''Or al Mèrit Artístic');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MOMC','0635 - Medalla d''Or al Mèrit Cultural');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MOME','0640 - Medalla d''Or al Mèrit Esportiu');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CEEA','0718 - Comitè Executiu Consell Cent');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CBES','0850 - Consell Municipal de Benestar Social');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('BREG','0890 - Barcelona Regional - Comitè de Direcció');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AMBA','0892 - Entitats Area Metropolitana de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CEPE','0915 - Pla Estratègic Metropolità de BCN  Comissió Executiva');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PCCB','0955 - Consell Municipal de Cultura de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CMDE','1000 - Consell Municipal d''Esports');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FCIC','1180 - Fòrum Ciutat i Comerç');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CTRI','1185 - Consell Tributari');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('RRPP','1210 - Caps de Protocol i Relacions Institucionals');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('2022','1250 - Candidatura Olímpica Barcelona-Pirineus 2022');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PRME','1286 - Pregoners - Pregoneres de la Festa de La Mercè');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CMER','1290 - Cartells Mercè 1980-1997');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('APBA','1295 - Alcaldes Diada Castellera');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('APMD','1440 - Anfitrions de Pasqual Maragall als Districtes');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FMPM','1445 - Convidats  Pasqual Maragall');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PMAL','1450 - Llistat Gabinet Alcaldia Medall Pasqual Margall ');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('REMA','1455 - REGIDORS MARAGALL');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('VMPM','1460 -Varis Medalla Pasqual maragall');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CCID','1500 - Consell Mpal Cooperació Internacional desenvolupament');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FAVB','1500-Fed. d''Associacions de Veïns i Veïnes de Barcelona(J.D.');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ALSP','1705- Alcaldes Pas Torxa Paralímpica');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ALSU','1710- Alcaldes de les Ciutats Subseus Olímpiques');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ADCB','1715 - Assemblea del COOB''92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CECO','1720 - Comitè Executiu del COOB''92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CHJJ','1725- Comitè d''Honor X Aniversari JJ.OO. Barcelona''92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DB92','1730 - Diplomes Ciutat de Barcelona''92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ERME','1735 - Ex-Regidors Xè.Aniv.Com.Candidatura Barcelona JJ.OO.');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MEBA','1740 - Medalles Barcelona 92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MOJO','1745 - Medalles d''Or Jocs Olímpics''92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MOJP','1750 - Medalles d''Or Jocs Paralímpics''92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('MPJO','1755 - Medalles de Plata Jocs Olímpics''92');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DEFU','1900 - Defuncions');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('GENER','1905 - GENERIC - Classificacio generica');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CCCO','2000 - Consell Ciutat i Comerç');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CMCO','2000 - Consell Municipal de Consum');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PICU','2000 - Proposta convidats inauguració Born - ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ACCO','2015 - Alcaldes de capitals de Comarques');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CAB1','2030 - Cabruja - Proposta Llista Convidats (20 anys JJOO''92)');
		commit;
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('EREA','2050 - Exregidors d''Esports Ajuntament de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('SGEG','2095 - Secretaris Generals de l''Esport - Generalitat de Cat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AUM7','3500 - AUTORITATS MEDALLES D''HONOR 2017');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PPM7','4010 - Peticions Protocol Mercè 2017');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('AE17','AGENTS ECONÒMICS 2017');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ARPL','Arts Plastiques');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CAPM','Cartes Autoritats Pregó Mercè');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CIRC','Circ Cultura ');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CC17','CIUTAT CONVIDADA MERCÈ 2017');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CPTC','Comissió Permanent Consell Municipal Turisme i Ciutat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB05','Comité de Direcció ICUB Mercè 2017  ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB12','Comité Executiu Consell Cultura Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('COMEX','COMITE EXECUTIU EXREGIDORS AJUNTAMENT BCN JJOO12');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB17','CONCA Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB09','Consell Administració ICUB Mercè 2017');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CESB','Consell Econòmic i Social de Barcelona');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CC15','CONSELL MUNICIPAL  COOPERACIÓ INTERNACIONAL PER EL DESENVOLU');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CTIC','Consell Municipal Turisme i Ciutat');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CCSH','Consell Social de l''Habitatge');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('DANS','Dansa');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB11','Dir. Equip.Culturals Artístics Consorciats Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB07','Direcció Segona tinència Mercè 2017  ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ICUB','DIRECTORS DE L''ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB10','Directors Museus-Espais i Directors Artístics Mercè 17 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB03','Dissenyadors Cartells Mercè 2017  ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB08','Equip Festes Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('RE92','Exregidors JJOO''92 (mandat 1991-1995)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FRSS','Familiar Regidors Saló de Cent 2015');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FA15','Familiars Alcaldessa Presa de Possessió 2015');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FRAS','Familiars Regidors Altres Salons 2015');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('FOT7','Fotografs 2017');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('GAD7','Galeries d''art 17');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB18','ICUB Com. Seg. Seguici Popular Bcn Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ICIC','Institucions Culturals (2017)');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ESC7','literatura');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('LITE','LITERATURA');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PP17','MAILING PREGONER  MERCÈ 2017');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB15','PATROCINADORS MERCÈ EMPRESES Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB16','PATROCINADORS MERCE MITJANS Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB14','Patrons Fundació Barcelona Cultura Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PEPR','Peticions Protocol Presa Possessió 2015');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB13','Ple Consell Cultura Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB02','Pregoners Mercè 2017 ICUB');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('PC16','PREMIS CIUTAT DE BARCELONA 2016');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('IB06','Reunió de Direcció ICUB Mercè 2017  ICUB ');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('TTRI','Taula Treball per Recerca i Innovació ');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('TBCR','0510 - Membres Taula Barcelona Creixement');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('JDEX','351-ASS. CATALANA EXPRESSOS POLÍTICS DEL FRANQUISME');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CGPE','0566 - Pla Estratègic Metropolità BCN- Consell Rector');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('CARE','0570 - Cases Regionals');
		Insert into TMP_CLASSIF_ACTIVES (CODI,DESCRIPCIO) 
					 VALUES ('ECAS','0572 - Entitats Catalanes d''Acció Social');




COMMIT;
END;

/* ESTE CATÁLOGO ES FIJO. NO CARGAR A NO SER QUE ESTÉ VACÍO
PROCEDURE A1_PARAMETRE IS
BEGIN


    Insert into A1_PARAMETRE (ID,CLAU,VALOR,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
                    values ('1','ULTIMS_DIES_TRUCADA_PENDENT','30',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);
    Insert into A1_PARAMETRE (ID,CLAU,VALOR,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL) 
                    values ('2','ULTIMS_DIES_TRUCADA_PASSADA','6',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,null,null,null);



COMMIT;
END;
*/

PROCEDURE A1_DM_AMBIT IS
  BEGIN
  
        INSERT INTO A1_DM_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES  (1,'Alcaldia',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'ALCALDIA',NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES  (2,'Protocol',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'PROTOCOL',NULL,NULL,NULL);

  
  COMMIT;
  END;

  PROCEDURE A1_DM_CONF_FUN_VISUALS IS
  BEGIN
            --Literales tal como están.
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (1, 'CONTACTES_PERSONES_RELACIONADES', 1, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (2, 'CONTACTES_TELEFONS_PRIVATS', 1, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (3, 'CONTACTES_VISIBILITAT', 1, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (4, 'TRUCADES', 1, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (5, 'CONTACTES_DADES_QUALITAT', 1, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (6, 'CONTACTES_CLASSIFICACIONS', 2, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (7, 'CONTACTES_PRIORITAT', 2, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (8, 'CONTACTES_ACOMPANYANT', 2, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (9, 'CONTACTES_ACTES', 2, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (10, 'CONTACTES_OBSEQUIS', 2, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);
            INSERT INTO A1_DM_CONF_FUN_VISUALS(ID,DESCRIPCIO,AMBIT_ID,USUARI_CREACIO, DATA_CREACIO) 
                        VALUES (11, 'ACTES', 2, ConstUsuari_CREACIO, CURRENT_TIMESTAMP);

  
  
  COMMIT;
  END;

-----------------------------------------------------------------
-- TRUCADA
-----------------------------------------------------------------

  


  PROCEDURE A1_DM_ESTAT_TRUCADA IS
  BEGIN

      INSERT INTO A1_DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  VALUES ('2','Passada',Sysdate,null,null,ConstUsuari_CREACIO,null,null,'PASSADA',NULL,NULL,NULL);
                  
      INSERT INTO A1_DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  VALUES ('3','Prevista',Sysdate,null,null,ConstUsuari_CREACIO,null,null,'PREVISTA',NULL,NULL,NULL);
                  
      INSERT INTO A1_DM_ESTAT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,CODI,ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  VALUES ('1','Pendent',Sysdate,null,null,ConstUsuari_CREACIO,null,null,'PENDENT',NULL,NULL,NULL);
      
  COMMIT;
  END;


  PROCEDURE A1_DM_SENTIT_TRUCADA IS
  BEGIN
  
            INSERT INTO A1_DM_SENTIT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        values ('2','Entrada',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                        
            INSERT INTO A1_DM_SENTIT_TRUCADA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        values ('1','Sortida',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);

  
  COMMIT;
  END;

-------------------------------------------------------------------
-- CONTACTES 
-------------------------------------------------------------------

  PROCEDURE A1_DM_TIPUS_TELEFON IS
  BEGIN
            INSERT INTO A1_DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        VALUES (1,'Telèfon fixe',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                        
            INSERT INTO A1_DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        VALUES (2,'Telèfon móvil',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                        
            INSERT INTO A1_DM_TIPUS_TELEFON (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        VALUES (3,'Fax',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);

        COMMIT;
    NULL;
  END;


  PROCEDURE A1_DM_TIPUS_SUBJECTE IS  
  BEGIN
  
                INSERT INTO A1_DM_TIPUS_SUBJECTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                            VALUES (1,'Persona',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'PERSONA',NULL,NULL,NULL);
                            
                INSERT INTO A1_DM_TIPUS_SUBJECTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                            VALUES (2,'Entitat',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'ENTITAT',NULL,NULL,NULL);

  
  NULL;
  END;


  
  
  PROCEDURE A1_DM_PRIORITAT IS
  BEGIN
  
              INSERT INTO A1_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                          VALUES (1, '1-S.C.', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2,NULL,NULL,NULL);
                          
              INSERT INTO A1_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                          VALUES (2, 'Prioritat 2', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2,NULL,NULL,NULL);
                          
              INSERT INTO A1_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                          VALUES (3, 'Prioritat 3', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2,NULL,NULL,NULL);
                          
              INSERT INTO A1_DM_PRIORITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                          VALUES (4, 'Prioritat 4', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2,NULL,NULL,NULL);

  
  COMMIT;
  END;
  
  
  PROCEDURE A1_DM_TIPOLOGIA_OBSEQUI IS
  BEGIN
  
        INSERT INTO A1_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (1,'Jocs florals',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (2,'Medalles',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (3,'Concerts',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    VALUES (4,'Objectes varis',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_TIPOLOGIA_OBSEQUI (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (5,'Fotos i vídeo',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
  
  
  COMMIT;
  END;
  
  PROCEDURE A1_DM_OBSEQUI IS
  BEGIN
  
        INSERT INTO A1_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (5,'Fotos papaer - NO',1,SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,5,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (4,'Fotos papaer - SI',1,SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,5,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (3,'CD -  NO',1,SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,5,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (2,'CD -  SI',1,SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,5,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_OBSEQUI (ID, DESCRIPCIO, VALOR, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,TIPOLOGIA_OBSEQUI_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES (6,'CD - SI (Fotos i vídeo)',1,SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,5,NULL,NULL,NULL);

  
  
  COMMIT;
  END;
  
  PROCEDURE A1_DM_VISIBILITAT IS
  BEGIN 
  
            INSERT INTO A1_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                   VALUES (1,'Pública',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'PUBLICA',NULL,NULL,NULL);
                   
            INSERT INTO A1_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                   VALUES (2,'Privada',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'PRIVADA',NULL,NULL,NULL);
                   
            INSERT INTO A1_DM_VISIBILITAT (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                   VALUES (3,'AlcaldÍa',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'COMPARTIDA',NULL,NULL,NULL);

  COMMIT;
  END;
  
  PROCEDURE A1_DM_TIPUS_CONTACTE IS
  BEGIN
  
          INSERT INTO A1_DM_TIPUS_CONTACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                      VALUES  (1,'Personal',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'PERSONAL',NULL,NULL,NULL);
                      
          INSERT INTO A1_DM_TIPUS_CONTACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                      VALUES  (2,'Professional',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,'PROFESSIONAL',NULL,NULL,NULL);
  
  COMMIT;
  END;

  PROCEDURE A1_DM_IDIOMA IS
  BEGIN
  
          INSERT INTO A1_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                      VALUES  (1,'Castellà',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                      
          INSERT INTO A1_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                      VALUES  (2,'Anglès',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                      
          INSERT INTO A1_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                      VALUES  (3,'Català',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                      
          INSERT INTO A1_DM_IDIOMA(ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                      VALUES  (4,'Francès',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
  
  COMMIT;
  END; 


  PROCEDURE A1_DM_TIPOLOGIA_CLASSIFICACIO IS
  BEGIN
  
            INSERT INTO A1_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        values (1,'Tipus 1',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,2,NULL,NULL,NULL);
                        
            INSERT INTO A1_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        values(2,'Tipus 2',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,2,NULL,NULL,NULL);
                        
            INSERT INTO A1_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        values(3,'Tipus 3',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,2,NULL,NULL,NULL);
                        
            INSERT INTO A1_DM_TIPOLOGIA_CLASSIFICACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        values(4,'Tipus 4',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,2,NULL,NULL,NULL);

  
  COMMIT;
  END;
  

  
  
  PROCEDURE A1_DM_AFECTA_AGENDA IS 
  BEGIN
  
            INSERT INTO A1_DM_AFECTA_AGENDA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,CODI) 
                        values ('1','No',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,1,NULL,NULL,NULL,'NO');
                        
            INSERT INTO A1_DM_AFECTA_AGENDA (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO,AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,CODI) 
                        values ('2','Sí',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,1,NULL,NULL,NULL,'SI');


  
  COMMIT;
  END;
  
  
  PROCEDURE A1_DM_TIPUS_AMBIT IS
  BEGIN
  
            INSERT INTO A1_DM_TIPUS_AMBIT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT,AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                        VALUES(1, 'Tipus alcaldia',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,1,NULL,NULL,NULL);

  COMMIT;
  END;
  
  PROCEDURE A1_DM_SECTOR IS
  BEGIN
  
          INSERT INTO A1_DM_SECTOR (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                      VALUES(0, 'Sense Definir',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
  
  COMMIT;
  END;
  
  PROCEDURE A1_DM_DECISIO_ASSISTENCIA IS
  BEGIN
  
        INSERT INTO A1_DM_DECISIO_ASSISTENCIA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES(1, 'NO', 'No', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, NULL, NULL, NULL);
                    
        INSERT INTO A1_DM_DECISIO_ASSISTENCIA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES(2, 'SI', 'Sí', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, NULL, NULL, NULL);
                    
        INSERT INTO A1_DM_DECISIO_ASSISTENCIA (ID, CODI, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                    VALUES(3, 'PENDENT', 'Pendent', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, NULL, NULL, NULL);
        
  
  COMMIT;
  END;
  
  
  PROCEDURE A1_DM_RAO IS
  BEGIN
  
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(1, 'Altres', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL);
                
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(2, 'No es troba disponible el remitent', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL);
                
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(3, 'Respon una altra persona', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL);
                
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(4, 'Comunica', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL);
            
            
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(5, 'Trucada passada al remitent', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2, NULL, NULL, NULL);
                
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(6, 'Trucada derivada a un altre telefon de contacte', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2, NULL, NULL, NULL);
                
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(7, 'Trucada derivada a un altre telefon de contacte', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2, NULL, NULL, NULL);
                
    INSERT INTO A1_DM_RAO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ESTAT_TRUCADA_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                VALUES(8, 'Altres', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 2, NULL, NULL, NULL);

  
  
  COMMIT;
  END;
  
  
  
  
  PROCEDURE A1_DM_ARTICLE IS
  BEGIN
  
      INSERT INTO A1_DM_ARTICLE (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  values ('1','el',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                  
      INSERT INTO A1_DM_ARTICLE (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  values ('2','la',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                  
      INSERT INTO A1_DM_ARTICLE (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  values ('3','en',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                  
      INSERT INTO A1_DM_ARTICLE (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  values ('4','na',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                  
      INSERT INTO A1_DM_ARTICLE (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  values ('5','l''',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
                  
      INSERT INTO A1_DM_ARTICLE (ID,DESCRIPCIO,DATA_CREACIO,DATA_ESBORRAT,DATA_MODIFICACIO,USUARI_CREACIO,USUARI_ESBORRAT,USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL) 
                  values ('6','n''',SYSDATE,NULL,NULL,ConstUsuari_CREACIO,NULL,NULL,NULL,NULL,NULL);
      
  
  
  COMMIT;
  END;



-----------------------------------------------------------------
-- ACTES 
-----------------------------------------------------------------
 PROCEDURE A1_DM_ESTAT_CONFIRMACIO IS
  BEGIN
  
        INSERT INTO A1_DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    VALUES(1, 'Pendent', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);
    
        INSERT INTO A1_DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    VALUES(2, 'Confirmat', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    VALUES(3, 'Delegat', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);
                    
        INSERT INTO A1_DM_ESTAT_CONFIRMACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    VALUES(4, 'Rebutjat', SYSDATE, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);
     
                    
  COMMIT;
  END;
  
  PROCEDURE A1_DM_TIPUS_VIA_INVITACIO IS
  BEGIN
  
            INSERT INTO A1_DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                        VALUES(1, 'INVITACIÓ TIPUS 1', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);
        
            INSERT INTO A1_DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                        VALUES(2, 'INVITACIÓ TIPUS 2', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);        
        
            INSERT INTO A1_DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                        VALUES(3, 'INVITACIÓ TIPUS 3', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);
          
            INSERT INTO A1_DM_TIPUS_VIA_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                        VALUES(4, 'INVITACIÓ TIPUS 4', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);

  
  COMMIT;
  END;
  
  
  
  PROCEDURE A1_DM_INICIATIVA_RESPOSTA IS
  BEGIN
  
        INSERT INTO A1_DM_INICIATIVA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    VALUES(1, 'Convidat', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);

        INSERT INTO A1_DM_INICIATIVA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                    VALUES(2, 'Alcaldía', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);


  COMMIT;
  END;
  
  
  PROCEDURE A1_DM_TIPUS_VIA_RESPOSTA IS
  BEGIN
  
      INSERT INTO A1_DM_TIPUS_VIA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(1, 'Via resposta 1', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL);

      INSERT INTO A1_DM_TIPUS_VIA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(2, 'Via Resposta 2', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL);
  
      INSERT INTO A1_DM_TIPUS_VIA_RESPOSTA (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO)
                VALUES(3, 'Via Resposta 3', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL);
  
  COMMIT;
  END;
  
  
  --GESTIÓN DE ESTADO DE LA INVITACION
    --OJO, LOS DATOS DEL CATÁLOGO SE PODRÍAN SACAR DE VIPS_ACTES (CAMPO ASSITIR)
   PROCEDURE A1_DM_ESTAT_GESTIO_INVITACIO IS
   BEGIN
   
   
        INSERT INTO A1_DM_ESTAT_GESTIO_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,ORDRE_TRAMITACIO)
                    VALUES(1, 'Selecció', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,'SELECCIO',NULL,NULL,NULL,1);


      INSERT INTO A1_DM_ESTAT_GESTIO_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,ORDRE_TRAMITACIO)
                  VALUES(2, 'Convocatoria', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,'CONVOCATORIA',NULL,NULL,NULL,2);
  
      INSERT INTO A1_DM_ESTAT_GESTIO_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,ORDRE_TRAMITACIO)
                VALUES(3, 'Confirmació', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,'CONFIRMACIO',NULL,NULL,NULL,3);
        
       INSERT INTO A1_DM_ESTAT_GESTIO_INVITACIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,CODI, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,ORDRE_TRAMITACIO)
                VALUES(4, 'Assistencia', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,'ASSISTENCIA',NULL,NULL,NULL,4); 
   
   COMMIT;
   END;
  
      --GESTIÓN DE ESTADO DEL ESPACIO    
   PROCEDURE A1_DM_ESTAT_GESTIO_ESPAIS IS
   BEGIN
   
   
      INSERT INTO A1_DM_ESTAT_GESTIO_ESPAIS (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                VALUES(1, 'Sala', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);


      INSERT INTO A1_DM_ESTAT_GESTIO_ESPAIS (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL)
                VALUES(2, 'Plantilla', SYSDATE,  NULL, NULL, ConstUsuari_CREACIO, NULL, NULL,NULL,NULL,NULL);        
   
   COMMIT;
   END;


   PROCEDURE A1_DM_ESTAT_ELEMENT IS
   BEGIN

       INSERT INTO A1_DM_ESTAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, CODI)
               VALUES(1, 'Registre inicial', Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'REGISTRE INICIAL');
   
       INSERT INTO A1_DM_ESTAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, CODI)
               VALUES(2, 'Tramitació', Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'TRAMITACIO');
   
   
       INSERT INTO A1_DM_ESTAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, CODI)
               VALUES(3, 'Conclusió', Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'CONCLUSIO');
               
--       INSERT INTO A1_DM_ESTAT_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, CODI)
--               VALUES(3, 'Distribució', Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL, 'DISTRIBUCIO');
               
        
         

   COMMIT;
   END;

/*
PROCEDURE A1_DM_PAS_ACCIO IS
BEGIN

     INSERT INTO A1_DM_PAS_ACCIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, ORDRE) 
            VALUES(1, 'Petició',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL,1);
            
     INSERT INTO A1_DM_PAS_ACCIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, ORDRE) 
            VALUES(2, 'Realització',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL,2);
            
     INSERT INTO A1_DM_PAS_ACCIO (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, ORDRE) 
            VALUES(3, 'Resolució',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL,3);

COMMIT;
END;
*/

PROCEDURE A1_DM_TIPUS_AGENDA IS
BEGIN

     INSERT INTO A1_DM_TIPUS_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(1, 'Provisional',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);
            
     INSERT INTO A1_DM_TIPUS_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(2, 'Pendent',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);
            
     INSERT INTO A1_DM_TIPUS_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(3, 'Rang',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);

     INSERT INTO A1_DM_TIPUS_AGENDA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(4, 'Concreta',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);
COMMIT;
END;



PROCEDURE A1_DM_ORIGEN_ELEMENT IS
BEGIN

     INSERT INTO A1_DM_ORIGEN_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, CODI) 
            VALUES(1, 'Entrada',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL,'ENTRADA');
            
     INSERT INTO A1_DM_ORIGEN_ELEMENT (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID, CODI) 
            VALUES(2, 'Sortida',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL,'SORTIDA');
            
    
COMMIT;
END;

PROCEDURE A1_DM_TIPUS_DATA IS
BEGIN

     INSERT INTO A1_DM_TIPUS_DATA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(1, 'Provisional',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);
            
     INSERT INTO A1_DM_TIPUS_DATA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(2, 'Pendent',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);
            
     INSERT INTO A1_DM_TIPUS_DATA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(3, 'Rang',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);

     INSERT INTO A1_DM_TIPUS_DATA (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL, INSTALACIOID) 
            VALUES(4, 'Concreta',Sysdate, NULL, NULL, ConstUsuari_CREACIO, NULL, NULL, 1, NULL, NULL, NULL, NULL);
            
    
COMMIT;
END;


PROCEDURE A1_ESTAT_ACTE IS
BEGIN

            INSERT INTO A1_DM_ESTAT_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,CODI)
                        VALUES (1, 'Preparació', Sysdate,NULL,NULL, ConstUsuari_CREACIO,NULL, NULL, '','','', 'PREPARACIO');
                        
            INSERT INTO A1_DM_ESTAT_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,CODI)
                        VALUES (2, 'Producció', Sysdate,NULL,NULL, ConstUsuari_CREACIO,NULL, NULL, '','','', 'PRODUCCIO');
                        
            INSERT INTO A1_DM_ESTAT_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,CODI)
                        VALUES (3, 'Execució', Sysdate,NULL,NULL, ConstUsuari_CREACIO,NULL, NULL, '','','', 'EXECUCIO');

            INSERT INTO A1_DM_ESTAT_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,CODI)
                        VALUES (4, 'Tancament', Sysdate,NULL,NULL, ConstUsuari_CREACIO,NULL, NULL, '','','', 'TANCAMENT');
                        
            INSERT INTO A1_DM_ESTAT_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,CODI)
                        VALUES (5, 'Tancat', Sysdate,NULL,NULL, ConstUsuari_CREACIO,NULL, NULL, '','','', 'TANCAT');
                        
            INSERT INTO A1_DM_ESTAT_ACTE (ID, DESCRIPCIO, DATA_CREACIO, DATA_ESBORRAT, DATA_MODIFICACIO, USUARI_CREACIO, USUARI_ESBORRAT, USUARI_MODIFICACIO,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,CODI)
                        VALUES (6, 'Anul·lat', Sysdate,NULL,NULL, ConstUsuari_CREACIO,NULL, NULL, '','','', 'ANULAT');



COMMIT;
END;



PROCEDURE A1_DM_DISTRICTE IS
BEGIN
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('1','Ciutat Vella',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,1);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('2','Eixample',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,2);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('3','Sants-Monjuïc',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,3);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('4','Les Corts',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,4);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('5','Sarrià-Sant Gervasi',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,5);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('6','Gràcia',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,6);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('7','Horta-Guinardó',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,7);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('8','Nou Barris',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,8);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('9','Sant Andreu',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,9);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('10','Sant Martí',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,10);
            INSERT INTO A1_DM_DISTRICTE (ID,DESCRIPCIO,DATA_CREACIO,DATA_MODIFICACIO,DATA_ESBORRAT,USUARI_CREACIO,USUARI_MODIFICACIO,USUARI_ESBORRAT,AMBIT_ID,ID_ORIGINAL,ESQUEMA_ORIGINAL,TABLA_ORIGINAL,INSTALACIOID,ORDRE)  
                        VALUES  ('11','Districte fora de Barcelona',SYSDATE,null,null,ConstUsuari_CREACIO,null,null,'1',null,null,null,null,1000);


COMMIT;
END;


PROCEDURE A1_DM_BARRI IS
BEGIN


                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('1','EL RAVAL',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',1,1);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('2','EL BARRI GÒTIC',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',1,2);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('3','LA BARCELONETA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',1,3);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('4','SANT PERE, SANTA CATERINA I LA RIBERA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',1,4);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('5','EL FORT PIENC',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',2,5);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('6','LA DRETA DE L''EIXAMPLE',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',2,6);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('7','L''ANTIGA ESQUERRA DE L''EIXAMPLE',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',2,7);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('8','LA NOVA ESQUERRA DE L''EIXAMPLE',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',2,8);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('9','SANT ANTONI',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',2,9);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('10','LA SAGRADA FAMILIA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',2,10);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('11','EL POBLE SEC',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,11);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('12','LA MARINA DEL PRAT VERMELL',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,12);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('13','LA MARINA DEL PORT',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,13);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('14','HOSTAFRANCS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,14);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('15','LA BORDETA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,15);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('16','SANTS - BADAL',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,16);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('17','SANTS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,17);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('18','LA FONT DE LA GUATLLA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',3,18);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('19','LES CORTS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',4,19);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('20','LA MATERNITAT I SANT RAMON',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',4,20);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('21','PEDRALBES',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',4,21);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('22','VALLVIDRERA, EL TIBIDABO I LES PLANES',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',5,22);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('23','LES TRES TORRES',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',5,23);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('24','SANT GERVASI - LA BONANOVA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',5,24);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('25','SANT GERVASI - GALVANY',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',5,25);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('26','EL PUTXET I EL FARRÓ',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',5,26);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('27','SARRIÀ',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',5,27);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('28','VALLCARCA I ELS PENITENTS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',6,28);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('29','EL COLL',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',6,29);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('30','LA SALUT',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',6,30);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('31','EL CAMP D''EN GRASSOT I GRÀCIA NOVA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',6,31);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('32','LA VILA DE GRÀCIA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',6,32);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('33','EL BAIX GUINARDÓ',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,33);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('34','CAN BARÓ',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,34);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('35','EL GUINARDÓ',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,35);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('36','LA FONT D''EN FARGUES',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,36);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('37','EL CARMEL',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,37);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('38','LA TEIXONERA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,38);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('39','MONTBAU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,39);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('40','LA VALL D''HEBRON',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,40);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('41','LA CLOTA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,41);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('42','HORTA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,42);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('43','SANT GENÍS DELS AGUDELLS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',7,43);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('44','VILAPICINA I LA TORRE LLOBETA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,44);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('45','PORTA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,45);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('46','EL TURÓ DE LA PEIRA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,46);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('47','CAN PEGUERA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,47);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('48','CANYELLES',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,48);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('49','LES ROQUETES',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,49);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('50','VERDUN',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,50);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('51','LA PROSPERITAT',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,51);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('52','LA TRINITAT NOVA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,52);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('53','TORRE BARÓ',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,53);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('54','CIUTAT MERIDIANA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,54);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('55','LA GUINEUETA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,55);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('56','VALLBONA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',8,56);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('57','LA TRINITAT VELLA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',9,57);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('58','BARÓ DE VIVER',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',9,58);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('59','EL BON PASTOR',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',9,59);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('60','SANT ANDREU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',9,60);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('61','LA SAGRERA',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',9,61);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('62','EL CONGRÉS I ELS INDIANS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',9,62);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('63','NAVAS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',9,63);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('64','EL CLOT',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,64);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('65','EL PARC I LA LLACUNA DEL POBLENOU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,65);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('66','LA VILA OLÍMPICA DEL POBLENOU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,66);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('67','EL POBLENOU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,67);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('68','DIAGONAL MAR I EL FRONT MARÍTIM DEL POBLENOU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,68);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('69','EL BESÒS I EL MARESME',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,69);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('70','PROVENÇALS DEL POBLENOU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,70);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('71','SANT MARTÍ DE PROVENÇALS',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,71);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('72','EL CAMP DE L''ARPA DEL CLOT',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,72);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('73','LA VERNEDA I LA PAU',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',10,73);
                        INSERT INTO A1_DM_BARRI (ID, DESCRIPCIO, DATA_CREACIO, DATA_MODIFICACIO, DATA_ESBORRAT, USUARI_CREACIO, USUARI_MODIFICACIO, USUARI_ESBORRAT, AMBIT_ID, ID_ORIGINAL, ESQUEMA_ORIGINAL, TABLA_ORIGINAL,DISTRICTE_ID,ORDRE) 
                                    VALUES ('1000','Barri fora de Barcelona',SYSDATE, NULL,NULL, ConstUsuari_CREACIO, NULL, NULL, ConstAMBIT_ALCALDIA, '', '', '',11,1000);


COMMIT;
END;


------------------------------------------------------------------
-- RESET TABLAS DM
------------------------------------------------------------------

PROCEDURE RESETEATOR_TABLAS IS
        BEGIN
        
        DELETE FROM A1_DM_BARRI;
        
        DELETE FROM A1_DM_DISTRICTE;
        
        DELETE FROM TMP_CLASSIF_ACTIVES;
        
        --------------------------------------------------------
        -- TRUCADA
        --------------------------------------------------------
              
               
        --------------------------------------------------------
        -- CONTACTES 
        --------------------------------------------------------
        
        DELETE FROM A1_DM_TIPUS_TELEFON;
        
        
        
        
        
        DELETE FROM A1_DM_PRIORITAT;
        
        
        
        DELETE FROM A1_DM_OBSEQUI;
        
        DELETE FROM A1_DM_VISIBILITAT;
        
        DELETE FROM A1_DM_TIPUS_CONTACTE;
        
        DELETE FROM A1_DM_IDIOMA;
        
        DELETE FROM A1_DM_TIPOLOGIA_CLASSIFICACIO;
        
        DELETE FROM A1_DM_SENTIT_TRUCADA;
        
        DELETE FROM A1_DM_AFECTA_AGENDA;
        
        DELETE FROM A1_DM_TIPUS_AMBIT;
        
      
        DELETE FROM A1_DM_SECTOR;
        
        DELETE FROM A1_DM_DECISIO_ASSISTENCIA;
        
        DELETE FROM A1_DM_RAO;
        
        DELETE FROM A1_DM_ARTICLE;
        
        
        
        --------------------------------------------------------
        -- ACTES
        --------------------------------------------------------
        
        DELETE FROM A1_DM_ESTAT_CONFIRMACIO;
        
        DELETE FROM A1_DM_TIPUS_VIA_INVITACIO;
        
        DELETE FROM A1_DM_INICIATIVA_RESPOSTA;
        
        DELETE FROM A1_DM_TIPUS_VIA_RESPOSTA;
        
        DELETE FROM A1_DM_ESTAT_GESTIO_INVITACIO;
        
        DELETE FROM A1_DM_ESTAT_GESTIO_ESPAIS;
        
        DELETE FROM A1_DM_ESTAT_ELEMENT;
        
        DELETE FROM A1_DM_TIPOLOGIA_OBSEQUI;
        
        DELETE FROM A1_DM_CONF_FUN_VISUALS;
        
        DELETE FROM A1_DM_TIPUS_SUBJECTE;
        
        DELETE FROM A1_DM_ESTAT_TRUCADA;
        
        DELETE FROM A1_DM_ESTAT_ACTE;
        
      
        DELETE FROM A1_DM_TIPUS_AGENDA;
        
        DELETE FROM A1_DM_ORIGEN_ELEMENT;
        
        DELETE FROM A1_DM_TIPUS_DATA;     
        
        DELETE FROM A1_DM_AMBIT;

COMMIT;
END;




END S_00_INSERTS;

/
