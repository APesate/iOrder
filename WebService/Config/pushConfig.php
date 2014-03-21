<?php
	$certificateAddress = "../../Config/ck.pem";
	$passphrase = 'iOrder';
	$message;

	function createMessage($messageType, $newOrders = 0, $newState) {
		switch($messageType){
			case 0:
				return 'Hay '. $newOrders . ' orden(es) nueva(s).';
				break;
			case 1:
				return 'Su orden cambio de estado a: ' . $newState;
				break;
			case 2:
				return 'Su orden esta lista!';
				break;
			default:
				echo 'Mensaje no valido';
				return false;
			}
	}
?>