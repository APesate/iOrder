<?php
	if(isset($_GET['appKey'])){
		include('../../Model/Factura.php');

		$factura = new Factura();

		if ($facturas = $factura->allOrders()) {
			echo json_encode($facturas);
		} else {
			echo '501';
		}
	}
?>