<?php

class Database {

    var $pdo;

    public function __construct() {

        try {
            $this->pdo = new PDO("mysql:host=us-cdbr-east-05.cleardb.net;dbname=heroku_f69d059cf5e4198", "be60ef75e3e120", "e4316b64");
          

            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {

            die(json_encode(array('return' => $e->getMessage())));
        }
    }

}

$obj = new Database;
?>

