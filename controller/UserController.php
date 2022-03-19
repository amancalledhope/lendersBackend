<?php

if (session_id() == '' || !isset($_SESSION)) {
    session_start();
}

include_once "../includes/db_connection.php";
include_once "../model/MUser.php";


class UserController extends Database
{


    public function authenticateUser($userName, $password)
    {


        $stmt = $this->pdo->prepare("SELECT * FROM users WHERE username = ? AND password = ?");

        //$arr = array($userName, md5($password));
        $arr = array($userName, $password);
        $stmt->execute($arr);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user != null) {
            $userId = $user['userId'];
            $userObj = $this->getUser($userId);

            $result = $userObj;
        } else {
            $result = "0";
        }


        return $result;
    }

    public function getUser($id)
    {

        $userObj = new MUser();

        $stmt = $this->pdo->prepare("SELECT * FROM users WHERE userId = ?");
        $arr = array($id);
        $stmt->execute($arr);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        $userObj->setUserId($user['userId']);
        $userObj->setUserName($user['username']);
        $userObj->setNrc($user['nrc']);
        $userObj->setEmail($user['email']);
        $userObj->setPhone($user['phone']);

        return $userObj;
    }


    public function addUser($userName, $nrc, $email, $phoneNumber, $password)
    {

        $valueArr = array(
            "userName" => $userName,
            "nrc" => $nrc,
            "email" => $email,
            "phoneNumber" => $phoneNumber,
            "password" => $password
        );

        $sql = "INSERT INTO users";
        $sql .= " (" . implode(",", array_keys($valueArr)) . ") VALUES ";
        $sql .= "('" . implode("','", array_values($valueArr)) . "')";
        $query = $this->pdo->exec($sql);

        return $userId;
    }


}


?>