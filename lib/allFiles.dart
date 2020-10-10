/// [Principais] - Dados principais para a aplicação
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';


/// [EXTERNOS] - Dados principais para as telas
export 'package:flare_flutter/flare_actor.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
export 'package:path_provider/path_provider.dart';
export 'package:permission_handler/permission_handler.dart';


/// [UTIL] - Dados úteis para ePraga
export 'package:epraga/app/util/epragaException.dart';
export 'package:epraga/app/util/fadePageRoute.dart';
export 'package:epraga/app/util/message.dart';
export 'package:epraga/app/util/verifyNetwork.dart';
export 'package:epraga/app/util/cpfValidator.dart';
export 'package:epraga/app/util/destination.dart';


/// [CONFIG] - Configurações gerais ePraga
export 'package:epraga/config/theme.dart';
export 'package:epraga/config/database.dart';


/// [CONTROLLER] - Controladores para ePraga
export 'package:epraga/app/dataController.dart';
export 'package:epraga/app/controller/splashController.dart';
export 'package:epraga/app/controller/loginController.dart';
export 'package:epraga/app/controller/schuduleController.dart';
export 'package:epraga/app/controller/questionController.dart';
export 'package:epraga/app/controller/senderController.dart';



/// [MODELS] - Modelos para ePraga
export 'package:epraga/model/app.dart';
export 'package:epraga/model/mobile.dart';
export 'package:epraga/model/login.dart';
export 'package:epraga/model/schudule/imgSchudule.dart';
export 'package:epraga/model/schudule/itemSchudule.dart';
export 'package:epraga/model/schudule/location.dart';
export 'package:epraga/model/schudule/option.dart';
export 'package:epraga/model/schudule/question.dart';
export 'package:epraga/model/schudule/schudule.dart';
export 'package:epraga/model/schudule/subsidiary.dart';
export 'package:epraga/model/schudule/product.dart';
export 'package:epraga/model/schudule/sender.dart';


/// [DAO] - DAO para ePraga
export 'package:epraga/app/dao/loginDao.dart';
export 'package:epraga/app/dao/schuduleDao.dart';
export 'package:epraga/app/dao/schuduleItemDao.dart';
export 'package:epraga/app/dao/subsidiaryDao.dart';
export 'package:epraga/app/dao/imageDao.dart';
export 'package:epraga/app/dao/productDao.dart';
export 'package:epraga/app/dao/senderDao.dart';


/// [COMPONENTS] - Componentes para ePraga
export 'package:epraga/resources/components/cardImage.dart';
export 'package:epraga/resources/components/connectivity.dart';
export 'package:epraga/resources/components/ePragaField.dart';


/// [ELEMENTS] - Elementos construtores de páginas
export 'package:epraga/resources/elements/schuduleElement.dart';
export 'package:epraga/resources/elements/schuduleItemElement.dart';
export 'package:epraga/resources/elements/imageElement.dart';


/// [PAGES] - Paginas de conteúdo para ePraga
export 'package:epraga/resources/pages/splashPage.dart';
export 'package:epraga/resources/pages/mainPage.dart';
export 'package:epraga/resources/pages/auth/loginPage.dart';
export 'package:epraga/resources/pages/auth/loginRoomPage.dart';
export 'package:epraga/resources/pages/auth/userPage.dart';
export 'package:epraga/resources/pages/schudule/schudulePage.dart';
export 'package:epraga/resources/pages/subsidiary/subsidiaryPage.dart';
export 'package:epraga/resources/pages/schudule/schuduleItemPage.dart';
export 'package:epraga/resources/pages/images/imagePage.dart';
export 'package:epraga/resources/pages/question/questionPage.dart';
