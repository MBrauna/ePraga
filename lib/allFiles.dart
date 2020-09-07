// --------------------------------------------------------------------------------------- //

/// [EXTERNOS] - Dados principais para as telas
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';
export 'package:sqflite/sqflite.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
export 'package:flare_flutter/flare_actor.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:path/path.dart';
export 'package:map_launcher/map_launcher.dart';

// --------------------------------------------------------------------------------------- //

/// [INTERNOS] - DADOS INTERNOS PARA COMPOSIÇÃO

/// [CONFIG] - Configurações do sistema
export 'package:epraga/config/config.dart';
export 'package:epraga/config/database.dart';
export 'package:epraga/config/theme.dart';

/// [EXCEPTION] - Tratamento de excessões para ePraga
export 'package:epraga/app/exception/ePragaException.dart';

/// [CONTROLLER] - Controladores de fluxo para dados.
export 'package:epraga/app/util/cpfValidator.dart';
export 'package:epraga/app/util/fadePageRoute.dart';
export 'package:epraga/app/util/message.dart';
export 'package:epraga/app/util/verifyNetwork.dart';

export 'package:epraga/app/dataController.dart';
export 'package:epraga/app/destination.dart';
export 'package:epraga/app/controller/requestController.dart';

export 'package:epraga/app/controller/splashScreenController.dart';
export 'package:epraga/app/controller/loginController.dart';


/// [MODEL] - Modelo de dados e estruturas
export 'package:epraga/model/ePraga.dart';
export 'package:epraga/model/login.dart';
export 'package:epraga/model/ListSchudule.dart';

export 'package:epraga/model/schudule/schudule.dart';
export 'package:epraga/model/schudule/schuduleItem.dart';
export 'package:epraga/model/schudule/imageBase64.dart';
export 'package:epraga/model/company/subsidiary.dart';

/// [COMPONENTS] - Componentes para uso na aplicação
export 'package:epraga/resources/components/cardImage.dart';
export 'package:epraga/resources/components/connectivity.dart';
export 'package:epraga/resources/components/ePragaField.dart';

/// [PAGES] - Telas da aplicação
export 'package:epraga/resources/page/splashPage.dart';
export 'package:epraga/resources/page/auth/loginPage.dart';
export 'package:epraga/resources/page/auth/loginRoomPage.dart';
export 'package:epraga/resources/page/mainPage.dart';
export 'package:epraga/resources/page/auth/userPage.dart';
export 'package:epraga/resources/page/guide/guidePage.dart';
export 'package:epraga/resources/page/schudule/schudulePage.dart';
export 'package:epraga/resources/page/schudule/schuduleItemPage.dart';