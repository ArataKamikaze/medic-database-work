<?php
$dsn = 'mysql:dbname=trabalhoDB;localhost';
$user = 'root';
$password = 'root';

try {
    $dbl = new PDO($dsn, $user, $password);
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}
?>
