<?php				

				include('../../Model/simplepush.php');
				/*$push = new Push(0, $newOrders, 2);//Push al Gerente
				$push->deviceToken = '';//tokenGerente
				if ($push->sendPush()) {
					return true;
				} else {
					return false;
				}*/
				$push = new Push(1, 0 , "En Preparacion");
				$push->deviceToken = '1993cff75c320718af37c440045b878c439fa9c63083d40d1dbcb9d394bbe3d1';

				if ($push->sendPush()) {
					return true;
				} else {
					return false;
				}
?>