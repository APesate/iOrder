<?php
	Class Categorie {
		public $id;
		public $name;
		public $products;

		function __construct() {
			
		}
		
		function setId($id){
			$this->id = $id;
		}
		
		function getId(){
			return $this->id;
		} 

		function setName($name) {
			$this->name = $name;
		}

		function getName(){
			return $this->name;
		}

		function setProducts($products) {
			$this->products = $products;
		}

		function getProdcuts(){
			return $this->products;
		}

		function makeConection(){
			require_once('../../Config/config.php');

			$conexion = mysql_connect($server, $username, $passwd) or die('1');
			mysql_select_db($db_name) or die('1');
		}

		function getAllCategories() {
			$this->makeConection();

			$query = mysql_query("SELECT * FROM Categoria") or die('2');

			if (mysql_num_rows($query) > 0) {
				while($result = mysql_fetch_array($query)) {
					$array[] = array(
						'id' => $result['id'],
						'name' => $result['nombre']
						);
				}

				return $array;
			} else {
				echo '3';
			}
		}

		function getAllProductForCategorie(){
			include('../../Model/Product.php');
			$this->makeConection();

			$query = mysql_query("SELECT * FROM Producto WHERE Categoria_id = '$this->id'") or die(mysql_error());

			if (mysql_num_rows($query) > 0) {
				while ($result = mysql_fetch_array($query)) {
					$product = new Product();

					$this->products[] = array(
						'id' => $result['id'],
						'name' => $result['nombre'],
						'precio' => $result['precio'],
						'image' => $result['imagen'],
						'description' => $result['descripcion'],
						'creation_date' => $result['fecha_creacion'],
						'update_date' => $result['fecha_actualizacion'],
						'categorie_id' => $result['Categoria_id']
						);
				}

				return true;
			} else {
				return false;
			}

		}

	}
?>