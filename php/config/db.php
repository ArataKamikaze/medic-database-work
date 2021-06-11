<?php
$dsn = 'mysql:dbname=hospital;localhost';
$user = 'root';
$password = 'root';

try {
    $dbl = new PDO($dsn, $user, $password);
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}
?>
