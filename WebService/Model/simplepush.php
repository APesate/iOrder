<?php
	
	Class Push {
		public $deviceToken;
		public $message;
		public $certificateAddress;
		public $passphrase;
		
		function __construct($messageType, $newOrders = 0, $newState = 2) {
			require_once('../../Config/pushConfig.php');
			
			if(!$this->message = createMessage($messageType, $newOrders, $newState)){
				echo 'Mensaje no valido';
			}
			$this->certificateAddress = $certificateAddress;
			$this->passphrase = $passphrase;
		}

	function sendPush(){
		
		////////////////////////////////////////////////////////////////////////////////
		
		$ctx = stream_context_create();
		stream_context_set_option($ctx, 'ssl', 'local_cert', $this->certificateAddress);
		stream_context_set_option($ctx, 'ssl', 'passphrase', $this->passphrase);

		// Open a connection to the APNS server
		$fp = stream_socket_client(
			'ssl://gateway.sandbox.push.apple.com:2195', $err,
			$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

		if (!$fp)
			exit("Failed to connect: $err $errstr" . PHP_EOL);

		//echo 'Connected to APNS' . PHP_EOL;

		// Create the payload body
		$body['aps'] = array(
			'alert' => $this->message,
			'sound' => 'default',
			);
		$body['msg'] = array(
				'command' => '0',
				'status' => '3'
			);

		// Encode the payload as JSON
		$payload = json_encode($body);

		// Build the binary notification
		$msg = chr(0) . pack('n', 32) . pack('H*', $this->deviceToken) . pack('n', strlen($payload)) . $payload;

		// Send it to the server
		$result = fwrite($fp, $msg, strlen($msg));

		if (!$result){
			//echo 'Message not delivered' . PHP_EOL;
			fclose($fp);
			return false;
		} else {
			//echo 'Message successfully delivered' . PHP_EOL;
			fclose($fp);
			return true;
		}

		// Close the connection to the server
		

	}
	
}
