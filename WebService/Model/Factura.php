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
		public $user_id;

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
		
		function createNewOrder($newOrders){
			$this->makeConection();
			
			if(mysql_query("INSERT INTO Factura (fecha_creacion, estado, Usuario_id) VALUES ('$this->creation_date', '$this->state', '$this->user_id')") or die('2')){
				include('../../Model/simplepush.php');
				$push = new Push(0, $newOrders, 2);
					
				$query = mysql_query("SELECT * FROM Usuario WHERE id = '$this->user_id' LIMIT 1") or die('2');
					
				while($result = mysql_fetch_array($query)){
					$usuario = $result['deviceToken'];
				}
				
				$push->deviceToken = $usuario;
				if ($push->sendPush()) {
					return true;
				} else {
					return false;
				}
			}
					
		}
	}
?>