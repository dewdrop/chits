<?php
session_start();
$_SESSION["dbname"] = "chits";
$_SESSION["dbuser"] = "root";
$_SESSION["dbpass"] = "root";
$conn = mysql_connect("localhost", "root", "root");
$db->connectdb("chits");
?>