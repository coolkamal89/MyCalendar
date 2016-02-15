<?php
	function out_json($data) {
		if ($data) {
			header("Content-Type: application/json");
			echo json_encode($data);
		}
		exit;
	}
?>