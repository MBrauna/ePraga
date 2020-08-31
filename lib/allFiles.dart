/// [CONFIG] - Configurações da aplicação
export 'config/database.dart';
export 'config/theme.dart';

/// [CONTROLLER] - Controladores da aplicação
export 'package:epraga/app/controller/dataController.dart';
export 'package:epraga/app/controller/auth/splashController.dart';
export 'package:epraga/app/controller/auth/loginController.dart';
export 'package:epraga/app/controller/guide/guideController.dart';
export 'package:epraga/app/controller/schudule/schuduleController.dart';

/// [WSCOM] - Comunicador da aplicação
export 'package:epraga/app/controller/wscom/loginRequest.dart';
export 'package:epraga/app/controller/wscom/schuduleRequest.dart';
export 'package:epraga/app/controller/wscom/guideRequest.dart';

/// [UTIL] - Utilitários da aplicação
export 'package:epraga/app/util/cpfValidator.dart';
export 'package:epraga/app/util/fadePageRoute.dart';
export 'package:epraga/app/util/message.dart';
export 'package:epraga/app/util/verifyNetwork.dart';

/// [EXCEPTION] - Tratativa de excessões da aplicação
export 'package:epraga/app/exception/ePragaException.dart';

/// [MODEL] - Arquivos para contenção dos dados da aplicação
export 'package:epraga/models/app.dart';
export 'package:epraga/models/auth/login.dart';
export 'package:epraga/models/guide/guide.dart';
export 'package:epraga/models/schudule/schudule.dart';
export 'package:epraga/models/schudule/schuduleItem.dart';

/// [COMPONENTS] - Componentes para criação da aplicação
export 'package:epraga/resources/component/cardImage.dart';
export 'package:epraga/resources/component/connectivity.dart';
export 'package:epraga/resources/component/ePragaField.dart';

/// [PAGES] - Páginas da aplicação
export 'package:epraga/resources/page/auth/splashPage.dart';
export 'package:epraga/resources/page/auth/loginPage.dart';
export 'package:epraga/resources/page/auth/LoginRoomPage.dart';
export 'package:epraga/resources/page/mainEPragaPage.dart';
export 'package:epraga/resources/page/user/userPage.dart';
export 'package:epraga/resources/page/guide/guidePage.dart';
export 'package:epraga/resources/page/chat/chatPage.dart';
export 'package:epraga/resources/page/schudule/schuduleHeaderPage.dart';
export 'package:epraga/resources/page/schudule/schuduleItemPage.dart';