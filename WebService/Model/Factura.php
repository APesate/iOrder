<?php
/*
	Estados posibles
	0 - Sin Ordernar
	1 - Enivada
	2 - Recibida
	3 - Sin Preparar
	4 - Preparando
	5 - Lista
*/

	Class Factura {
		public $id;
		public $state;
		public $creation_date;
		public $deviceToken;

		function setId($id){
			$this->id = $id;
		}

		function setState($state){
			$this->state = $state;
		}

		function setCreationDate($creation_date){
			$this->creation_date = $creation_date;
		}

		function setUserId($user_id){
			$this->user_id = $user_id;
		}

		function getId(){
			return $this->id;
		}

		function getState(){
			return $this->state;
		}

		function getCreationDate(){
			return $this->creation_date;
		}

		function getUserId(){
			return $this->user_id;
		}
		
		function makeConection(){
			require_once('../../Config/config.php');

			$conexion = mysql_connect($server, $username, $passwd) or die('1');
			mysql_select_db($db_name) or die('1');
		}
		
		function createNewOrder(){
			$this->makeConection();
			
			if(mysql_query("INSERT INTO Factura_Nueva (fecha_creacion, estado, deviceToken) VALUES ('$this->creation_date', '$this->state', '$this->deviceToken')") or die('2')){
				include('../../Model/simplepush.php');
			}
					
		}

		function loadNewOrders(){
			$this->makeConection();

			include('../../Model/simplepush.php');

			$query = mysql_query("SELECT * FROM Factura_Nueva") or die('2 FN');

			if (mysql_num_rows($query) > 0) {
				mysql_query("INSERT INTO Factura (SELECT id, fecha_creacion, '3' as estado, deviceToken FROM Factura_Nueva);") or die(mysql_error());
				mysql_query("DELETE FROM Factura_Nueva;");
				
				$push = new Push(0, mysql_num_rows($query), 3);//Push al Gerente
				$push->deviceToken = '1993cff75c320718af37c440045b878c439fa9c63083d40d1dbcb9d394bbe3d1';//tokenGerente
				if ($push->sendPush()) {
					return true;
				} else {
					return false;
				}
			}

		}

		function changeOrderState() {
			$this->makeConection();

			include('../../Model/simplepush.php');

			if (mysql_query("UPDATE Factura SET estado = '$this->state' WHERE id='$this->id';") or die(false)) {
				$query = mysql_query("SELECT deviceToken FROM Factura WHERE id = '$this->id';");
				$result = mysql_fetch_object($query);
				$this->deviceToken = $result->deviceToken;

				$push = new Push($this->state == 5 ? 2 : 1, 0, $this->state);
				$push->deviceToken = $this->deviceToken;
				if ($push->sendPush()) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}

		function allOrders (){
			$this->makeConection();

			$query = mysql_query("SELECT f.id, f.deviceToken, f.estado FROM Factura f WHERE f.estado < 5;") or die(mysql_error());

			if (mysql_num_rows($query) > 0) {
				while ($result = mysql_fetch_object($query)) {

					$productsQuery = mysql_query("SELECT p.nombre FROM Producto p, Factura f, Producto_has_Factura phf 
												  WHERE p.id = phf.Producto_id AND phf.Factura_id = '$result->id' AND f.id = '$result->id';") or die(mysql_error());
					$productos = array();
					while ($product =  mysql_fetch_object($productsQuery)) {
						$productos[] = $product->nombre;
					}
					$facturas[] = array('factura' => $result, 'products' => $productos);
					$productos = array();
				}

				return $facturas;
			} else {
				return false;
			}
		}
	}
?>