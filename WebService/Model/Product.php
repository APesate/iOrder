<?php 
	Class Product {
		public $id;
		public $name;
		public $description;
		public $image;
		public $precio;
		public $categorie_id;
		public $creation_date;
		public $update_date;

		function __construct() {
			
		}
		
		function setId($id){
			$this->id = $id;
		}

		function setName($name){
			$this->name = $name;
		}

		function setDescription($description){
			$this->description = $description;
		}

		function setImage($image){
			$this->image = $image;
		}

		function setPrecio($precio){
			$this->precio = $precio;
		}

		function setCategorieId($categorie_id){
			$this->categorie_id = $categorie_id;
		}

		function setCreationDate($creation_date){
			$this->creation_date = $creation_date;
		}

		function setUpdateDate($update_date){
			$this->update_date = $update_date;
		}

		function getId(){
			return $this->id;
		}

		function getName(){
			return $this->name;
		}

		function getDescription(){
			return $this->description;
		}

		function getImage(){
			return $this->image;
		}

		function getPrecio(){
			return $this->precio;
		}

		function getCategorieId(){
			return $this->categorie_id;
		}

		function getCreationDate(){
			return $this->creation_date;
		}

		function getUpdateDate(){
			return $this->update_date;
		}

		function makeConection(){
			require_once('config.php');

			$conexion = mysql_connect($server, $username, $passwd) or die('2');
			mysql_select_db($db_name) or die('2');
		}

		function getProductForId(){
			$this->makeConection();
			$query = mysql_query("SELECT * FROM Producto WHERE id = '$this->id'");

			if (mysql_num_rows($query) > 0) {
				$result = mysql_fetch_array($query);
				
				$this->id = $result['id'];
				$this->name = $result['nombre'];
				$this->precio = $result['precio'];
				$this->image = $result['imagen'];
				$this->description = $result['descripcion'];
				$this->creation_date = $result['fecha_creacion'];
				$this->update_date = $result['fecha_actualizacion'];
				$this->categorie_id = $result['Categoria_id'];

				return true;
			} else {
				return false;
			}
		}

	}

?>